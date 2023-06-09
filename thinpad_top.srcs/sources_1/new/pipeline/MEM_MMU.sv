`include "../headers/mem.svh"
`include "../headers/exception.svh"

module MEM_MMU #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,  // clk with 50M frequency
    input wire rst,

    input wire mstatus_t mstatus_i,
    input wire priviledge_mode_t priviledge_mode_i,
    input wire satp_t satp_i, // (+)
    input wire tlb_flush,  // must ensure query_en = 1 (+)
    input wire fence_i,

    // data memory
    input wire dm_en,
    input wire dm_wen,
    input wire [ADDR_WIDTH-1:0] dm_addr,
    input wire [DATA_WIDTH-1:0] dm_data_i,
    input wire [2:0] dm_width, // can be either 1, 2 or 4
    input wire dm_sign_ext,
    output wire dm_ack,
    output logic [DATA_WIDTH-1:0] dm_data_o,

    output logic query_exception,
    output logic [`MXLEN-2:0] query_exception_code,
    output logic [DATA_WIDTH-1:0] query_exception_val,

    // Wishbone master
    output wire wbm_cyc_o,
    output reg wbm_stb_o,
    input wire wbm_ack_i,
    output reg[3:0] wbm_sel_o,
    output reg[ADDR_WIDTH-1:0] wbm_adr_o,
    input wire [DATA_WIDTH-1:0] wbm_dat_i,
    output reg[DATA_WIDTH-1:0] wbm_dat_o,
    output reg wbm_we_o,

    // mtimer
    input wire [63:0] mtimer_mtime,
    input wire [63:0] mtimer_mtimecmp,
    output logic mtimer_mtime_wen, 
    output logic mtimer_mtimecmp_wen, 
    output logic mtimer_upper_wen,
    output logic [31:0] mtimer_wdata
);


    logic mmu_ack;
    logic request_comb;

    logic [DATA_WIDTH-1:0] data_cache;

    // Cache request
    logic [ADDR_WIDTH-1:0] request_addr;
    logic [DATA_WIDTH-1:0] request_data_i;
    logic [2:0] request_width;

    logic [ADDR_WIDTH-1:0] dm_addr_cache;
    logic [DATA_WIDTH-1:0] dm_data_i_cache;
    logic [2:0] dm_width_cache;

    // MMU Exception
    logic query_exception_mmu;
    logic [`MXLEN-2:0] query_exception_code_mmu;


    always_comb begin
        query_exception = query_exception_mmu;
        query_exception_code = query_exception_code_mmu;
        query_exception_val = request_addr;

        if (dm_en && ((request_addr & 32'h3) != 0) && request_width == 4) begin
            query_exception = 1;
            if (dm_wen) begin
                query_exception_code = `EXCEPTION_STORE_ADDRESS_MISALIGNED;
            end else begin
                query_exception_code = `EXCEPTION_LOAD_ADDRESS_MISALIGNED;
            end
        end

        else if (dm_en && ((request_addr & 32'h1) != 0) && request_width == 2) begin
            query_exception = 1;
            if (dm_wen) begin
                query_exception_code = `EXCEPTION_STORE_ADDRESS_MISALIGNED;
            end else begin
                query_exception_code = `EXCEPTION_LOAD_ADDRESS_MISALIGNED;
            end
        end
    end


    MMU mmu (
        .clk(clk),
        .rst(rst),

        .mstatus_i(mstatus_i),
        .priviledge_mode_i(priviledge_mode_i),
        .satp_i(satp_i),
        .query_en(dm_en),
        .query_wen(dm_wen),
        .virt_addr(request_addr),
        .query_data_i(request_data_i),
        .query_width(request_width),
        .query_sign_ext(dm_sign_ext),
        .tlb_flush(tlb_flush),

        .fence_i(fence_i | tlb_flush),
        .fence_i_wb(1'b1),

        .query_ack(mmu_ack),
        .query_data_o(dm_data_o),
        .query_exception(query_exception_mmu),
        .query_exception_code(query_exception_code_mmu),

        .wb_cyc_o(wbm_cyc_o),
        .wb_stb_o(wbm_stb_o),
        .wb_ack_i(wbm_ack_i),
        .wb_adr_o(wbm_adr_o),
        .wb_dat_o(wbm_dat_o),
        .wb_dat_i(wbm_dat_i),
        .wb_sel_o(wbm_sel_o),
        .wb_we_o(wbm_we_o),

        .mtimer_enabled(1'b1),
        .mtimer_mtime(mtimer_mtime),
        .mtimer_mtimecmp(mtimer_mtimecmp),
        .mtimer_mtime_wen(mtimer_mtime_wen),
        .mtimer_mtimecmp_wen(mtimer_mtimecmp_wen),
        .mtimer_upper_wen(mtimer_upper_wen),
        .mtimer_wdata(mtimer_wdata)
    );


    always_comb begin
        if (request_comb) begin
            request_addr = dm_addr;
            request_data_i = dm_data_i;
            request_width = dm_width;
        end else begin
            request_addr = dm_addr_cache;
            request_data_i = dm_data_i_cache;
            request_width = dm_width_cache;
        end

    end

    always_ff @(posedge clk) begin
        if (rst | ~dm_en) begin
            request_comb <= 1;
        end

        else begin
            if (mmu_ack) begin
                request_comb <= 1;
            end else begin
                if (request_comb == 1) begin
                    request_comb <= 0;
                    dm_addr_cache <= dm_addr;
                    dm_data_i_cache <= dm_data_i;
                    dm_width_cache <= dm_width;
                end
            end
        end
    end

    assign dm_ack = (mmu_ack) & (dm_addr == request_addr);

endmodule
