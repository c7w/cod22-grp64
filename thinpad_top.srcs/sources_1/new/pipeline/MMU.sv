/*
    This module is used to manipulate multiple peripherals. (SRAM / UART / VGA / Flash)


CPU ---> [T   L   B]  <---> [Cache] <---> [SRAM] 
     |     |      /|\
     |     |       |
     |    \|/      | 
     |   Translation Unit
     |
    UART / VGA / Flash    
*/
`include "../headers/exception.svh"
`include "../headers/mem.svh"
module MMU #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter SELECT_WIDTH = 4
) (
    input wire clk,
    input wire rst,

    // CPU -> MMU
    input wire mstatus_t mstatus_i,
    input wire priviledge_mode_t priviledge_mode_i,
    input wire satp_t satp_i,
    input wire query_en,
    input wire query_wen,
    input wire virt_addr_t virt_addr,
    input wire [DATA_WIDTH-1:0] query_data_i,
    input wire [2:0] query_width,
    input wire query_sign_ext,
    input wire tlb_flush,  // must ensure query_en = 1
    
    input wire fence_i,
    input wire fence_i_wb,

    // MMU -> CPU
    output logic query_ack,
    output logic [DATA_WIDTH-1:0] query_data_o,
    output logic query_exception,  // todo: add support for exception
    output logic [`MXLEN-2:0] query_exception_code,

    // Wishbone master -> Wishbone arbiter
    output logic wb_cyc_o,
    output logic wb_stb_o, 
    input wire wb_ack_i, 
    output logic [ADDR_WIDTH-1:0] wb_adr_o,
    output logic [DATA_WIDTH-1:0] wb_dat_o,
    input wire [DATA_WIDTH-1:0] wb_dat_i,
    output logic [DATA_WIDTH/8-1:0] wb_sel_o,
    output logic wb_we_o,

    // MTimer -> MMU
    input wire mtimer_enabled,
    input wire [63:0] mtimer_mtime,
    input wire [63:0] mtimer_mtimecmp,
    output logic mtimer_mtime_wen, 
    output logic mtimer_mtimecmp_wen, 
    output logic mtimer_upper_wen,
    output logic [31:0] mtimer_wdata
    
);

    // Device selector
    typedef enum logic [3:0] { 
        DEVICE_SRAM,
        DEVICE_UART,
        DEVICE_VGA,
        DEVICE_FLASH,
        DEVICE_MTIMER,
        DEVICE_UNKNOWN
    } device_t;
    device_t device;

    always_comb begin
        device = DEVICE_SRAM;

        if (32'h10000000 <= virt_addr && virt_addr <= 32'h10000007) begin
            device = DEVICE_UART;
        end

        else if ((virt_addr == 32'h0200bff8 || virt_addr == 32'h0200bffc || virt_addr == 32'h02004000 || virt_addr == 32'h02004004) && mtimer_enabled) begin
            device = DEVICE_MTIMER;
        end

        else begin
            // ? for VGA and Flash
        end
    end


    logic mmu_seize_master;
    logic master_owner_tlb;

    logic query_en_tlb;

    logic query_ack_tlb;
    logic [DATA_WIDTH-1:0] query_data_o_tlb;
    logic query_exception_tlb;
    logic [`MXLEN-2:0] query_exception_code_tlb;

    logic query_ack_uart;
    logic [DATA_WIDTH-1:0] query_data_o_uart;

    logic [DATA_WIDTH-1:0] mtimer_rdata;  // comb

    // Only wire to TLB if device == DEVICE_SRAM
    always_comb begin
        query_en_tlb = 0;

        query_ack = 0;
        query_data_o = 0;
        query_exception = 0;
        query_exception_code = 0;

        mmu_seize_master = 1;

        
        if (fence_i) begin
            mmu_seize_master = 0;
            query_ack = query_ack_tlb;
        end
        
        
        else if (tlb_flush) begin
            
            query_ack = 1;

        end 

        else if (~query_en) begin
            query_ack = 1;
        end

        else if (device == DEVICE_SRAM) begin

            mmu_seize_master = 0;

            query_en_tlb = query_en;

            query_ack = query_ack_tlb;
            query_data_o = query_data_o_tlb;
            query_exception = query_exception_tlb;
            query_exception_code = query_exception_code_tlb;
        
        end else if (device == DEVICE_MTIMER) begin

            query_ack = 1'b1;
            query_data_o = mtimer_rdata;

        end else if (device == DEVICE_UART) begin

            query_ack = query_ack_uart;
            query_data_o = query_data_o_uart;

        end
    end

    // inner wires
    logic translation_ack;
    pte_t translation_result;

    logic [DATA_WIDTH-1:0] satp_o;
    logic translation_en;
    virt_addr_t translation_addr;

    logic cache_ack;
    logic [DATA_WIDTH-1:0] cache_data_i;

    logic cache_en;
    logic cache_wen;
    logic [2:0] cache_width;
    logic cache_sign_ext;
    logic [ADDR_WIDTH-1:0] cache_addr;  // phys addr
    logic [DATA_WIDTH-1:0] cache_data_o;

    logic [ADDR_WIDTH-1:0] wbm0_adr_o; // ADR_I() address input
    logic [DATA_WIDTH-1:0] wbm0_dat_o; // DAT_I() data in
    logic [DATA_WIDTH-1:0] wbm0_dat_i; // DAT_O() data out
    logic wbm0_we_o; // WE_I write enable input
    logic [SELECT_WIDTH-1:0] wbm0_sel_o; // SEL_I() select input
    logic wbm0_stb_o; // STB_I strobe input
    logic wbm0_ack_i; // ACK_O acknowledge output
    logic wbm0_cyc_o; // CYC_I cycle input

    // Translation Unit -> Wishbone master
    logic [ADDR_WIDTH-1:0] wbm1_adr_o; // ADR_I() address input
    logic [DATA_WIDTH-1:0] wbm1_dat_o; // DAT_I() data in
    logic [DATA_WIDTH-1:0] wbm1_dat_i; // DAT_O() data out
    logic wbm1_we_o; // WE_I write enable input
    logic [SELECT_WIDTH-1:0] wbm1_sel_o; // SEL_I() select input
    logic wbm1_stb_o; // STB_I strobe input
    logic wbm1_ack_i; // ACK_O acknowledge output
    logic wbm1_cyc_o; // CYC_I cycle input
    
    // MMU -> Wishbone master
    logic [ADDR_WIDTH-1:0] wbm3_adr_o; // ADR_I() address input
    logic [DATA_WIDTH-1:0] wbm3_dat_o; // DAT_I() data in
    logic wbm3_we_o; // WE_I write enable input
    logic [SELECT_WIDTH-1:0] wbm3_sel_o; // SEL_I() select input
    logic wbm3_stb_o; // STB_I strobe input
    logic wbm3_cyc_o; // CYC_I cycle input


    logic [ADDR_WIDTH-1:0] trans_cache_bypassing_addr;
    logic trans_cache_bypassing_valid;
    logic [DATA_WIDTH-1:0] trans_cache_bypassing_data;

    MMU_tlb mmu_tlb (

        .clk(clk),
        .rst(rst),

        // CPU -> TLB
        .mstatus_i(mstatus_i),
        .priviledge_mode_i(priviledge_mode_i),
        .satp_i(satp_i),
        .query_en(query_en_tlb),
        .query_wen(query_wen),
        .virt_addr(virt_addr),
        .query_data_i(query_data_i),
        .query_width(query_width),
        .query_sign_ext(query_sign_ext),
        .tlb_flush(tlb_flush),
        .fence_i(fence_i),
        .fence_i_wb(fence_i_wb),

        // TLB -> CPU
        .query_ack(query_ack_tlb),
        .query_data_o(query_data_o_tlb),
        .query_exception(query_exception_tlb),
        .query_exception_code(query_exception_code_tlb),

        // Translation Unit -> TLB
        .translation_ack(translation_ack),
        .translation_result(translation_result),

        // TLB -> Translation Unit
        .satp_o(satp_o),
        .translation_en(translation_en),
        .translation_addr(translation_addr),

        // Cache -> TLB
        .cache_ack(cache_ack),
        .cache_data_i(cache_data_i),

        // TLB -> Cache
        .cache_en(cache_en),
        .cache_wen(cache_wen),
        .cache_width(cache_width),
        .cache_sign_ext(cache_sign_ext),
        .cache_addr(cache_addr),
        .cache_data_o(cache_data_o),

        // TLB -> Wishbone master
        .master_owner(master_owner_tlb)
    );

    MMU_translation_unit mmu_translation_unit (

        .clk(clk),
        .rst(rst),

        // Translation Unit -> TLB.
        .translation_ack(translation_ack),
        .translation_result(translation_result),

        // TLB -> Translation Unit
        .satp(satp_o),
        .translation_en(translation_en),
        .translation_addr(translation_addr),

        // Cache -> Translation Unit
        .cache_request_addr(trans_cache_bypassing_addr),

        // Translation Unit -> Cache
        .cache_request_valid(trans_cache_bypassing_valid),
        .cache_request_data(trans_cache_bypassing_data),

        // Translation Unit -> Wishbone master
        .wb_cyc_o(wbm1_cyc_o),
        .wb_stb_o(wbm1_stb_o),
        .wb_adr_o(wbm1_adr_o),
        .wb_dat_o(wbm1_dat_o),
        .wb_sel_o(wbm1_sel_o),
        .wb_we_o(wbm1_we_o),

        // Wishbone master -> Translation Unit
        .wb_ack_i(wbm1_ack_i),
        .wb_dat_i(wbm1_dat_i)
    );

    MMU_cache mmu_cache (
        .clk(clk),
        .rst(rst),

        // Cache -> TLB
        .cache_ack(cache_ack),
        .data_o(cache_data_i),

        // TLB -> Cache
        .cache_en(cache_en),
        .cache_wen(cache_wen),
        .cache_width(cache_width),
        .cache_sign_ext(cache_sign_ext),
        .cache_addr(cache_addr),
        .data_i(cache_data_o),

        .fence_i(fence_i),
        .fence_i_wb(fence_i_wb),

        // Cache -> Translation Unit
        .translation_unit_request_addr(trans_cache_bypassing_addr),

        // Translation Unit -> Cache
        .translation_unit_request_valid(trans_cache_bypassing_valid),
        .translation_unit_request_data(trans_cache_bypassing_data),

        // Cache -> Wishbone Master
        .wb_cyc_o(wbm0_cyc_o),
        .wb_stb_o(wbm0_stb_o),
        .wb_adr_o(wbm0_adr_o),
        .wb_dat_o(wbm0_dat_o),
        .wb_sel_o(wbm0_sel_o),
        .wb_we_o(wbm0_we_o),

        // Wishbone Master -> Cache
        .wb_ack_i(wbm0_ack_i),
        .wb_dat_i(wbm0_dat_i)
    );

    MMU_master mmu_master (
        // TLB -> Wishbone master
        .master_owner(fence_i ? 2'b00 : {mmu_seize_master, master_owner_tlb}),

        // Cache -> Wishbone master
        .wbm0_adr_o(wbm0_adr_o),
        .wbm0_dat_o(wbm0_dat_o),
        .wbm0_dat_i(wbm0_dat_i),
        .wbm0_we_o(wbm0_we_o),
        .wbm0_sel_o(wbm0_sel_o),
        .wbm0_stb_o(wbm0_stb_o),
        .wbm0_ack_i(wbm0_ack_i),
        .wbm0_cyc_o(wbm0_cyc_o),

        // Translation Unit -> Wishbone master
        .wbm1_adr_o(wbm1_adr_o),
        .wbm1_dat_o(wbm1_dat_o),
        .wbm1_dat_i(wbm1_dat_i),
        .wbm1_we_o(wbm1_we_o),
        .wbm1_sel_o(wbm1_sel_o),
        .wbm1_stb_o(wbm1_stb_o),
        .wbm1_ack_i(wbm1_ack_i),
        .wbm1_cyc_o(wbm1_cyc_o),

        // MMU -> Wishbone master
        .wbm3_adr_o(wbm3_adr_o),
        .wbm3_dat_o(wbm3_dat_o),
        .wbm3_we_o(wbm3_we_o),
        .wbm3_sel_o(wbm3_sel_o),
        .wbm3_stb_o(wbm3_stb_o),
        .wbm3_cyc_o(wbm3_cyc_o),

        // Wishbone master -> Wishbone arbiter
        .wb_cyc_o(wb_cyc_o),
        .wb_stb_o(wb_stb_o),
        .wb_ack_i(wb_ack_i),
        .wb_adr_o(wb_adr_o),
        .wb_dat_o(wb_dat_o),
        .wb_dat_i(wb_dat_i),
        .wb_sel_o(wb_sel_o),
        .wb_we_o(wb_we_o)
    );

    // State
    typedef enum logic[3:0] {
        STATE_IDLE,
        STATE_READ_UART,
        STATE_WRITE_UART
    } state_t;
    state_t state, state_nxt;

    always_comb begin

        state_nxt = STATE_IDLE;

        if (state == STATE_IDLE) begin
            if (device == DEVICE_UART && query_en && query_wen) begin
                state_nxt = STATE_WRITE_UART;
            end

            else if (device == DEVICE_UART & query_en & ~query_wen) begin
                state_nxt = STATE_READ_UART;
            end
        end

        else if (state == STATE_READ_UART) begin
            if (wb_ack_i) begin
                state_nxt = STATE_IDLE;
            end
            else begin
                state_nxt = STATE_READ_UART;
            end
        end

        else if (state == STATE_WRITE_UART) begin
            if (wb_ack_i) begin
                state_nxt = STATE_IDLE;
            end
            else begin
                state_nxt = STATE_WRITE_UART;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= STATE_IDLE;
        end else begin
            state <= state_nxt;
        end
    end

    // UART
    always_comb begin
        query_ack_uart = 0;
        query_data_o_uart = 0;

        if (state == STATE_READ_UART) begin
            if (wb_ack_i) begin
                query_ack_uart = 1;
                query_data_o_uart = {24'b0, wb_dat_i[7:0]};
            end
        end else if (state == STATE_WRITE_UART) begin
            if (wb_ack_i) begin
                query_ack_uart = 1;
            end
        end
    end

    // Wishbone master
    always_comb begin
        wbm3_adr_o = 0;
        wbm3_dat_o = 0;
        wbm3_we_o = 0;
        wbm3_sel_o = 0;
        wbm3_stb_o = 0;
        wbm3_cyc_o = 0;

        if (state == STATE_READ_UART) begin
            wbm3_stb_o = 1;
            wbm3_cyc_o = 1;
            wbm3_sel_o = 4'b1111;
            wbm3_we_o = 1'b0;
            wbm3_dat_o = 32'haeaeaeae;
            wbm3_adr_o = virt_addr;
        end

        else if (state == STATE_WRITE_UART) begin
            wbm3_stb_o = 1;
            wbm3_cyc_o = 1;
            wbm3_sel_o = 4'b1111;
            wbm3_we_o = 1'b1;
            wbm3_dat_o = query_data_i;
            wbm3_adr_o = virt_addr;
        end
    end


    // MTimer
    always_comb begin
        // mtimer logic
        mtimer_rdata = 32'h0;
        mtimer_mtime_wen = 0;
        mtimer_mtimecmp_wen = 0;
        mtimer_upper_wen = 0;

        if (query_wen) begin
            case (virt_addr) 
                32'h200bff8: mtimer_mtime_wen = 1;
                32'h200bffc: begin 
                    mtimer_mtime_wen = 1;
                    mtimer_upper_wen = 1;
                end
                32'h2004000: mtimer_mtimecmp_wen = 1;
                32'h2004004: begin
                    mtimer_mtimecmp_wen = 1;
                    mtimer_upper_wen = 1;
                end
            endcase
        end

        else begin
            case (virt_addr) 
                32'h200bff8: mtimer_rdata = mtimer_mtime[31:0];
                32'h200bffc: mtimer_rdata = mtimer_mtime[63:32];
                32'h2004000: mtimer_rdata = mtimer_mtimecmp[31:0];
                32'h2004004: mtimer_rdata = mtimer_mtimecmp[63:32];
            endcase
        end
    end

    assign mtimer_wdata = query_data_i;

endmodule
