`include "../headers/ctrl.vh"
`include "../headers/branch_comp.vh"
`include "../headers/exception.svh"

module REG_IF_ID #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (

    input wire clk,
    input wire rst,

    input wire stall, // freeze status
    input wire bubble, // bubble status

    // IF -> ID
    input wire[4:0] rs1_i,
    input wire[4:0] rs2_i,
    input wire[4:0] rd_i,
    input wire[DATA_WIDTH-1:0] imm_i,
    input wire imm_en_i,

    output reg[4:0] rs1_o,
    output reg[4:0] rs2_o,
    output reg[4:0] rd_o,
    output reg[DATA_WIDTH-1:0] imm_o,
    output reg imm_en_o,
    

    // ID -> EXE
    // input wire[DATA_WIDTH-1:0] rf_data_a_i,
    input wire [`CSR_ADDR_WIDTH-1:0] csr_addr_i,
    input wire [`CSR_OP_WIDTH-1:0] csr_opcode_i,
    input wire [`BC_OP_WIDTH-1:0] bc_op_i,
    input wire [`ALU_OP_WIDTH-1:0] alu_op_i,
    input wire [`ALU_MUX_A_WIDTH-1:0] alu_mux_a_ctr_i,
    input wire [`ALU_MUX_B_WIDTH-1:0] alu_mux_b_ctr_i,
    input wire[`PC_MUX_WIDTH-1:0] pc_mux_ctr_i,

    input wire query_exception_i,
    input wire [`MXLEN-2:0] query_exception_code_i,
    input wire illegal_instruction_i,

    // output reg [DATA_WIDTH-1:0] rf_data_a_o,
    output reg [`CSR_ADDR_WIDTH-1:0] csr_addr_o,
    output reg [`CSR_OP_WIDTH-1:0] csr_opcode_o,
    output reg [`BC_OP_WIDTH-1:0] bc_op_o,
    output reg [`ALU_OP_WIDTH-1:0] alu_op_o,
    output reg [`ALU_MUX_A_WIDTH-1:0] alu_mux_a_ctr_o,
    output reg [`ALU_MUX_B_WIDTH-1:0] alu_mux_b_ctr_o,
    output reg[`PC_MUX_WIDTH-1:0] pc_mux_ctr_o,

    output reg query_exception_o,
    output reg [`MXLEN-2:0] query_exception_code_o,
    output reg illegal_instruction_o,

    // EXE -> MEM
    input wire[ADDR_WIDTH-1:0] pc_addr_i,
    // input wire [DATA_WIDTH-1:0] alu_out_i,
    input wire dm_en_i,
    input wire dm_wen_i,
    input wire [2:0] dm_width_i,
    input wire dm_sign_ext_i,
    input wire [`DM_MUX_WIDTH-1:0] dm_mux_ctr_i,
    input wire tlb_flush_i,
    input wire drain_pipeline_i,
    input wire fence_i_i,

    // input wire [DATA_WIDTH-1:0] rf_data_b_i,
    
    output reg [ADDR_WIDTH-1:0] pc_addr_o,
    // output reg [DATA_WIDTH-1:0] alu_out_o,
    output reg dm_en_o,
    output reg dm_wen_o,
    output reg [2:0] dm_width_o,
    output reg dm_sign_ext_o,
    output reg [`DM_MUX_WIDTH-1:0] dm_mux_ctr_o,
    output reg tlb_flush_o,
    output reg drain_pipeline_o,
    output reg fence_i_o,
    // output wire [DATA_WIDTH-1:0] rf_data_b_o,


    // MEM -> WB
    input wire wb_en_i, // write back enabled
    // input wire[ADDR_WIDTH-1:0] wb_addr_i,
    // input wire[DATA_WIDTH-1:0] wb_data_i,

    output reg wb_en_o
    // output reg[ADDR_WIDTH-1:0] wb_addr_o,
    // output reg[DATA_WIDTH-1:0] wb_data_o
);

    always_ff @(posedge clk) begin

        if (rst) begin
            // bubble : id
            csr_addr_o <= 0; csr_opcode_o <= 15;
            rs1_o <= 0; rs2_o <= 0; rd_o <= 0; imm_o <= 0;
            imm_en_o <= 0;

            // bubble : exe
            // rf_data_a_o <= 0;
            bc_op_o <= `BC_OP_FALSE;
            alu_op_o <= `ALU_OP_UNKNOWN;
            alu_mux_a_ctr_o <= `ALU_MUX_A_ZERO;
            alu_mux_b_ctr_o <= `ALU_MUX_B_ZERO;
            pc_mux_ctr_o <= `PC_MUX_INC;

            query_exception_o <= 0;
            query_exception_code_o <= 32'd31;
            illegal_instruction_o <= 0;

            // bubble : mem
            pc_addr_o <= 0; // alu_out_o <= 0;
            dm_width_o <= 4; dm_sign_ext_o <= 1;
            dm_en_o <= 0; dm_wen_o <= 0; dm_mux_ctr_o <= `DM_MUX_ALU;
            tlb_flush_o <= 0; drain_pipeline_o <= 0; fence_i_o <= 0;
            // rf_data_b_o <= 0;
            
            // bubble : wb
            wb_en_o <= 0; // wb_addr_o <= 0; wb_data_o <= 0;
        end

        else begin

            if (stall) begin
                // freeze!
                // do nothing :)
            end

            else begin
                
                if (bubble) begin

                    // bubble : id
                    csr_addr_o <= 0; csr_opcode_o <= 15;
                    rs1_o <= 0; rs2_o <= 0; rd_o <= 0; imm_o <= 0;
                    imm_en_o <= 0;

                    // bubble : exe
                    // rf_data_a_o <= 0;
                    bc_op_o <= `BC_OP_FALSE;
                    alu_op_o <= `ALU_OP_UNKNOWN;
                    alu_mux_a_ctr_o <= `ALU_MUX_A_ZERO;
                    alu_mux_b_ctr_o <= `ALU_MUX_B_ZERO;
                    pc_mux_ctr_o <= `PC_MUX_INC;

                    query_exception_o <= 0;
                    query_exception_code_o <= 32'd31;
                    illegal_instruction_o <= 0;

                    // bubble : mem
                    pc_addr_o <= 0; // alu_out_o <= 0;
                    dm_width_o <= 4; dm_sign_ext_o <= 1;
                    dm_en_o <= 0; dm_wen_o <= 0; dm_mux_ctr_o <= `DM_MUX_ALU;
                    tlb_flush_o <= 0; drain_pipeline_o <= 0; fence_i_o <= 0;
                    // rf_data_b_o <= 0;
                    
                    // bubble : wb
                    wb_en_o <= 0; // wb_addr_o <= 0; wb_data_o <= 0;
                end else begin

                    // normal : id
                    csr_addr_o <= csr_addr_i; csr_opcode_o <= csr_opcode_i;
                    rs1_o <= rs1_i; rs2_o <= rs2_i;
                    rd_o <= rd_i; imm_o <= imm_i;
                    imm_en_o <= imm_en_i;

                    // normal : exe
                    // rf_data_a_o <= rf_data_a_i;
                    bc_op_o <= bc_op_i;
                    alu_op_o <= alu_op_i;
                    alu_mux_a_ctr_o <= alu_mux_a_ctr_i;
                    alu_mux_b_ctr_o <= alu_mux_b_ctr_i;
                    pc_mux_ctr_o <= pc_mux_ctr_i;

                    query_exception_o <= query_exception_i;
                    query_exception_code_o <= query_exception_code_i;
                    illegal_instruction_o <= illegal_instruction_i;

                    // normal : mem
                    pc_addr_o <= pc_addr_i;
                    // alu_out_o <= alu_out_i;
                    dm_en_o <= dm_en_i;
                    dm_wen_o <= dm_wen_i;
                    dm_width_o <= dm_width_i; 
                    dm_sign_ext_o <= dm_sign_ext_i;
                    dm_mux_ctr_o <= dm_mux_ctr_i;

                    tlb_flush_o <= tlb_flush_i; 
                    drain_pipeline_o <= drain_pipeline_i; 
                    fence_i_o <= fence_i_i;

                    // rf_data_b_o <= rf_data_b_i;

                    // normal : wb
                    wb_en_o <= wb_en_i;
                    // wb_addr_o <= wb_addr_i;
                    // wb_data_o <= wb_data_i;
                end

            end

        end

    end

endmodule