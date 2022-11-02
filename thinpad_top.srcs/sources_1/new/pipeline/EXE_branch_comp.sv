`include "../headers/branch_comp.vh"

module EXE_branch_comp #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire [`BC_OP_WIDTH-1:0] bc_op,
    input wire [DATA_WIDTH-1:0] data_a,
    input wire [DATA_WIDTH-1:0] data_b,
    output logic cond
);

    always_comb begin
        cond = 0;
        case (bc_op) 
            `BC_OP_EQU: begin
                cond = data_a == data_b;
            end

            `BC_OP_GE: begin
                cond = $signed(data_a) >= $signed(data_b);
            end

            `BC_OP_GEU: begin 
                cond =  data_a >= data_b;
            end

            `BC_OP_LT: begin
                cond = $signed(data_a) < $signed(data_b);
            end

            `BC_OP_LTU: begin
                cond = data_a <= data_b;
            end

            `BC_OP_NEQ: begin
                cond = data_a != data_b;
            end

        endcase
    end

endmodule