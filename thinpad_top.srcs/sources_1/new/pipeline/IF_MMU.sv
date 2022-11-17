// This module is a substitution for instr fetcher
module IF_MMU #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    // CPU -> MMU
    // CPU -> TLB
    input wire satp_t satp_i, // (+)
    input wire tlb_flush,  // must ensure query_en = 1 (+)

    input wire[ADDR_WIDTH-1:0] pc_addr,
    input wire branching,  // not used ?
    output logic [DATA_WIDTH-1:0] instr,
    output logic im_ack,

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

    MMU mmu (
        .clk(clk),
        .rst(rst),

        .satp_i(satp_i),
        .query_en(~rst),
        .query_wen(1'b0),
        .virt_addr(request_addr),
        .query_data_i(32'hbabababa),
        .query_width(3'd4),
        .query_sign_ext(1'b0),
        .tlb_flush(tlb_flush),

        .query_ack(mmu_ack),
        .query_data_o(instr),
        .query_exception(),   // todo: add exception for IM stage
        .query_exception_code(),

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

        // request_addr = pc_addr_last;
        // if (pc_addr != pc_addr_last & (mmu_ack || im_ack_cache)) begin
        //     request_addr = pc_addr;
        // end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            request_comb <= 1;
        end

        else begin

            if (mmu_ack) begin

                request_comb <= 1;

                // if (pc_addr != pc_addr_last) begin
                //     pc_addr_last <= pc_addr;
                //     im_ack_cache <= 0;
                // end else begin
                //     im_ack_cache <= 1;
                //     instr_cached <= query_result;
                // end
            end else begin
                if (request_comb == 1) begin
                    request_comb <= 0;
                    pc_addr_cache <= pc_addr;
                end

                
            end

            // else if (pc_addr != pc_addr_last && (mmu_ack || im_ack_cache || init)) begin
            //     // This indicates a new SEQ request
            //     pc_addr_last <= pc_addr;
            //     im_ack_cache <= 0;
            //     init <= 0;
            // end
            
        end
    end

    // always_comb begin
    //     if (mmu_ack) begin
    //         instr = query_result;
    //     end else if (im_ack) begin
    //         instr = instr_cached;
    //     end else begin
    //         instr = 32'hfcfcfcfc;  // Check for this carefully
    //     end
    // end

    assign im_ack = (mmu_ack) & (pc_addr == request_addr);

endmodule