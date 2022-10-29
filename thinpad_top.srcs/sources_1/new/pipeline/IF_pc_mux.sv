module IF_pc_mux #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire [`PC_MUX_WIDTH-1:0] pc_mux_ctr,
    input wire [ADDR_WIDTH-1:0] pc_curr,
    input wire [ADDR_WIDTH-1:0] branch_addr,
    output wire [ADDR_WIDTH-1:0] pc_nxt
);

    always_comb begin
        pc_nxt = pc_curr + 4;

        if (pc_mux_ctr == `PC_MUX_BRANCH) begin
            pc_nxt = branch_addr;
        end
    end

endmodule