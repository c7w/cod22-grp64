`include "../headers/exception.svh"

// This module is a substitution for instr fetcher
module IF_MMU #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    // CPU -> MMU
    // CPU -> TLB
    input wire mstatus_t mstatus_i,
    input wire priviledge_mode_t priviledge_mode_i,
    input wire satp_t satp_i, // (+)
    input wire tlb_flush,  // must ensure query_en = 1 (+)
    input wire fence_i,

    input wire[ADDR_WIDTH-1:0] pc_addr,
    input wire branching,  // not used ?
    output logic [DATA_WIDTH-1:0] instr,
    output logic im_ack,

    output logic query_exception,
    output logic [`MXLEN-2:0] query_exception_code,
    output logic [DATA_WIDTH-1:0] query_exception_val,

    // wishbone master
    output wire wb_cyc_o, 
    output logic wb_stb_o, 
    input wire wb_ack_i, 
    output logic [ADDR_WIDTH-1:0] wb_adr_o, 
    output wire [DATA_WIDTH-1:0] wb_dat_o, 
    input wire [DATA_WIDTH-1:0] wb_dat_i, 
    output wire [DATA_WIDTH/8-1:0] wb_sel_o, 
    output wire wb_we_o
);

    // Cache pc_addr
    logic [ADDR_WIDTH-1:0] request_addr;
    logic [ADDR_WIDTH-1:0] pc_addr_cache;

    logic mmu_ack;

    logic request_comb;
    
    logic [DATA_WIDTH-1:0] instr;


    logic query_exception_mmu;
    logic [`MXLEN-2:0] query_exception_code_mmu;

    always_comb begin
        query_exception = query_exception_mmu;
        query_exception_code = query_exception_code_mmu;
        query_exception_val = request_addr;

        if (request_addr & 32'h3 != 0) begin
            query_exception = 1;
            query_exception_code = `EXCEPTION_INSTRUCTION_ADDRESS_MISALIGNED;
        end
    end

    MMU mmu (
        .clk(clk),
        .rst(rst),

        .mstatus_i(mstatus_i),
        .priviledge_mode_i(priviledge_mode_i),
        .satp_i(satp_i),
        .query_en(~rst),
        .query_wen(1'b0),
        .virt_addr(request_addr),
        .query_data_i(32'hbabababa),
        .query_width(3'd4),
        .query_sign_ext(1'b0),
        .tlb_flush(tlb_flush),

        .fence_i(fence_i),
        .fence_i_wb(1'b0),

        .query_ack(mmu_ack),
        .query_data_o(instr),
        .query_exception(query_exception_mmu),
        .query_exception_code(query_exception_code_mmu),

        .wb_cyc_o(wb_cyc_o),
        .wb_stb_o(wb_stb_o),
        .wb_ack_i(wb_ack_i),
        .wb_adr_o(wb_adr_o),
        .wb_dat_o(wb_dat_o),
        .wb_dat_i(wb_dat_i),
        .wb_sel_o(wb_sel_o),
        .wb_we_o(wb_we_o),

        .mtimer_enabled(1'b0),
        .mtimer_mtime(64'd0),
        .mtimer_mtimecmp(64'd1),
        .mtimer_mtime_wen(),
        .mtimer_mtimecmp_wen(),
        .mtimer_upper_wen(),
        .mtimer_wdata()

    );

    // request addr
    always_comb begin

        if (request_comb) begin
            request_addr = pc_addr;
        end else begin
            request_addr = pc_addr_cache;
        end

    end

    always_ff @(posedge clk) begin
        if (rst) begin
            request_comb <= 1;
        end

        else begin

            if (mmu_ack) begin

                request_comb <= 1;

            end else begin
                if (request_comb == 1) begin
                    request_comb <= 0;
                    pc_addr_cache <= pc_addr;
                end
            end

        end
    end

    assign im_ack = (mmu_ack) & (pc_addr == request_addr);

endmodule