module IF_pc_mux #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire branching,
    input wire [ADDR_WIDTH-1:0] pc_predicted,
    input wire [ADDR_WIDTH-1:0] branch_addr,
    output logic [ADDR_WIDTH-1:0] pc_nxt
);

    always_comb begin
        if (branching) begin
            pc_nxt = branch_addr;
        end

        else begin
            pc_nxt = pc_predicted;
        end
    end

endmodule