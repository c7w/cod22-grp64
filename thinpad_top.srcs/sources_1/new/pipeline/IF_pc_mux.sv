module IF_pc_mux #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire [ADDR_WIDTH-1:0] pc_nxt_prediction,
    output wire[ADDR_WIDTH-1:0] pc_nxt
);

    assign pc_nxt = pc_nxt_prediction;
    // TODO : add branching prediction?

endmodule