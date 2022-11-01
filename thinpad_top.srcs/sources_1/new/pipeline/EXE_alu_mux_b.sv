`include "../headers/ops.vh"
`include "../headers/ctrl.vh"
`include "../headers/branch_comp.vh"

module EXE_alu_mux_b #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire[`ALU_MUX_B_WIDTH-1:0] alu_mux_b_ctr_i,
    input wire [DATA_WIDTH-1:0] alu_mux_b_data,
    input wire [DATA_WIDTH-1:0] alu_mux_b_imm,
    output logic [DATA_WIDTH-1:0] alu_mux_b_o
);

    always_comb begin
        alu_mux_b_o = {DATA_WIDTH{1'b0}};

        case (alu_mux_b_ctr_i) 
            `ALU_MUX_B_DATA: begin
                alu_mux_b_o = alu_mux_b_data;
            end

            `ALU_MUX_B_IMM: begin
                alu_mux_b_o = alu_mux_b_imm;
            end
        endcase

    end

endmodule
