`include "../headers/ctrl.vh"
`include "../headers/branch_comp.vh"

module EXE_alu_mux_a #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire[`ALU_MUX_A_WIDTH-1:0] alu_mux_a_ctr_i,
    input wire [DATA_WIDTH-1:0] alu_mux_a_data,
    input wire [DATA_WIDTH-1:0] alu_mux_a_csr,
    input wire [ADDR_WIDTH-1:0] alu_mux_a_pc,
    output logic [DATA_WIDTH-1:0] alu_mux_a_o
);

    always_comb begin
        alu_mux_a_o = {DATA_WIDTH{1'b0}};

        case (alu_mux_a_ctr_i) 
            `ALU_MUX_A_DATA: begin
                alu_mux_a_o = alu_mux_a_data;
            end

            `ALU_MUX_A_PC: begin
                alu_mux_a_o = alu_mux_a_pc;
            end

            `ALU_MUX_A_CSR: begin
                alu_mux_a_o = alu_mux_a_csr;
            end
        endcase

    end

endmodule