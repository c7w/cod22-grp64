`include "../headers/ctrl.vh"
`include "../headers/branch_comp.vh"

module IF_DECODER #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire[DATA_WIDTH-1:0] instr,

    // Control signals
    output logic[DATA_WIDTH-1:0] imm,
    output logic imm_en,  // immediate enabled
    output logic dm_en, // data memory enabled
    output logic dm_wen,  // data memory write enabled
    output logic [2:0] dm_width,
    output logic dm_sign_ext,
    output logic wb_en,  // write back enabled
    output logic [5:0] rd,
    output logic [5:0] rs1,
    output logic [5:0] rs2,
    // control singals
    output wire [`PC_MUX_WIDTH-1:0] pc_mux_ctr,
    output wire [`BC_OP_WIDTH-1:0] bc_op,
    output wire [`ALU_OP_WIDTH-1:0] alu_op,
    output wire [`ALU_MUX_A_WIDTH-1:0] alu_mux_a_ctr,
    output wire [`ALU_MUX_B_WIDTH-1:0] alu_mux_b_ctr,
    output wire [`DM_MUX_WIDTH-1:0] dm_mux_ctr
);

    // Decode instr
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign rd = instr[11:7];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign opcode[6:0] = instr[6:0];
    assign funct3[2:0] = instr[14:12];
    assign funct7[6:0] = instr[31:25];

    typedef enum logic[7:0] { 
        OP_LUI,
        OP_BEQ,
        OP_LB,
        OP_SB,
        OP_SW,
        OP_ADDI,
        OP_ANDI,
        OP_ADD,
        OP_NOP,
        OP_UNKNOWN
    } OP_Type;
    
    OP_Type op_type;

    // From instr to op_type
    // TODO: add more instructions
    always_comb begin
        op_type = OP_UNKNOWN;
        case (opcode)
            // U Type
            7'b0110111: begin
                op_type = OP_LUI;
            end

            // B Type
            7'b1100011: begin
                case (funct3)
                    3'b000: op_type = OP_BEQ;
                endcase
            end

            // I Type
            7'b0000011: begin
                case (funct3) 
                    3'b000: op_type = OP_LB;
                endcase
            end

            // S Type
            7'b0100011: begin
                case (funct3) 
                    3'b000: op_type = OP_SB;
                    3'b010: op_type = OP_SW;
                endcase
            end

            // I Type
            7'b0010011: begin
                case (funct3) 
                    3'b000: op_type = OP_ADDI;
                    3'b111: op_type = OP_ANDI;
                endcase
            end

            // R Type
            7'b0110011: begin
                case ({funct7, funct3}) 
                    10'b0000000: op_type = OP_ADD;
                endcase
            end

            default: begin end
        endcase
    end

    // Utils for decoding IMMs
    logic sign; logic[19:0] sign_ext20;
    assign sign = instr[31];
    assign sign_ext20 = {20{sign}};
    
    // From op_type to decoding results
    always_comb begin
        // Initial values
        imm = 32'h0; imm_en = 0; wb_en = 0;
        dm_en = 0; dm_wen = 0; 
        dm_width = 4; dm_sign_ext = 1;

        case (op_type)
            OP_LUI: begin
                imm = {instr[31:12], 12'b0}; 
                imm_en = 1; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            OP_BEQ: begin
                imm = {sign_ext20[18:0], instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
                imm_en = 1; wb_en = 0;
                dm_en = 0; dm_wen = 0;
            end

            OP_LB: begin
                imm = {sign_ext20[19:0], instr[31:20]}; 
                imm_en = 1; wb_en = 1;
                dm_en = 1; dm_wen = 0;  // Read memory
                dm_width = 1;
            end

            OP_SB: begin
                imm = {sign_ext20[19:0], instr[31:25], instr[11:7]}; 
                imm_en = 1; wb_en = 0;
                dm_en = 1; dm_wen = 1; dm_width = 1;
            end

            OP_SW: begin
                imm = {sign_ext20[19:0], instr[31:25], instr[11:7]}; 
                imm_en = 1; wb_en = 0;
                dm_en = 1; dm_wen = 1;
            end

            OP_ADDI, OP_ANDI: begin
                imm = {sign_ext20[19:0], instr[31:20]}; 
                imm_en = 1; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            OP_ADD: begin
                imm = 32'h0; imm_en = 0; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            default: begin
                imm = 32'h0; imm_en = 0; 
                wb_en = 0; dm_en = 0; dm_wen = 0;
                dm_width = 4; dm_sign_ext = 1;
            end
        endcase
    end
    
    logic pc_mux_ctr_comb;
    logic [`BC_OP_WIDTH-1:0] bc_op_comb;
    logic [3:0] alu_op_comb;
    logic alu_mux_a_ctr_comb;
    logic alu_mux_b_ctr_comb;
    logic dm_mux_ctr_comb;
    
    assign pc_mux_ctr = pc_mux_ctr_comb;
    assign bc_op = bc_op_comb;
    assign alu_op = alu_op_comb;
    assign alu_mux_a_ctr = alu_mux_a_ctr_comb;
    assign alu_mux_b_ctr = alu_mux_b_ctr_comb;
    assign dm_mux_ctr = dm_mux_ctr_comb;

    // Decoding for control signals
    always_comb begin
        pc_mux_ctr_comb = `PC_MUX_INC;
        bc_op_comb = `BC_OP_FALSE;
        alu_op_comb = `ALU_OP_UNKNOWN; 
        alu_mux_a_ctr_comb = `ALU_MUX_A_ZERO;  // zero
        alu_mux_b_ctr_comb = `ALU_MUX_B_ZERO; // zero
        dm_mux_ctr_comb = `DM_MUX_ALU;

        case (op_type)
            OP_LUI: begin
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_ZERO;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;
            end

            OP_BEQ: begin
                pc_mux_ctr_comb = `PC_MUX_BRANCH;  // Branch if bc_comp output is 1
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_PC;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;
                bc_op_comb = `BC_OP_EQU;
            end


            OP_LB: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_MEM;
            end

            OP_SB : begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_MEM;
            end

            OP_SW: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_MEM;
            end

            OP_ADDI: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;
            end

            OP_ANDI: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_AND;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;
            end

            OP_ADD: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_DATA;
                dm_mux_ctr_comb = `DM_MUX_ALU;
            end

            OP_NOP: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_UNKNOWN;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_DATA;
                dm_mux_ctr_comb = `DM_MUX_ALU;
            end

        endcase
    end

endmodule
