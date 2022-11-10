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

    // control signals
    output csr_op_t csr_opcode,
    output [`CSR_ADDR_WIDTH-1:0] csr_addr,

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

    assign rd = instr[11:7];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign opcode[6:0] = instr[6:0];
    assign funct3[2:0] = instr[14:12];
    assign funct7[6:0] = instr[31:25];
    assign csr_addr[`CSR_ADDR_WIDTH-1:0] = instr[31:20];

    typedef enum logic[7:0] { 
        // Added in lab6
        OP_LUI,
        OP_BEQ,
        OP_LB,
        OP_SB,
        OP_SW,
        OP_ADDI,
        OP_ANDI,
        OP_ADD,
        OP_NOP,

        // Added in lab7, stage-I
        OP_SLTI,
        OP_SLTIU,

        OP_SLT,
        OP_SLTU,

        OP_SLLI,
        OP_SRLI,
        OP_SRAI,

        OP_SLL,
        OP_SRL,
        OP_SRA,

        OP_BNE,
        OP_BLT,
        OP_BGE,
        OP_BLTU,
        OP_BGEU,

        OP_AUIPC,

        OP_XORI,
        OP_ORI,

        OP_SUB,
        OP_XOR,
        OP_OR,
        OP_AND,

        OP_LH,
        OP_LW,
        OP_LBU,
        OP_LHU,
        
        OP_SH,
        
        OP_JAL,
        OP_JALR,

        // Added in lab7, stage-II
        OP_CSRRW,
        OP_CSRRS,
        OP_CSRRC,
        OP_CSRRWI,
        OP_CSRRSI,
        OP_CSRRCI,
        OP_ECALL,
        OP_EBREAK,
        OP_URET,
        OP_SRET,
        OP_MRET,

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
                    3'b001: op_type = OP_BNE;
                    3'b100: op_type = OP_BLT;
                    3'b101: op_type = OP_BGE;
                    3'b110: op_type = OP_BLTU;
                    3'b111: op_type = OP_BGEU;
                endcase
            end

            // I Type
            7'b0000011: begin
                case (funct3) 
                    3'b000: op_type = OP_LB;
                    3'b100: op_type = OP_LBU;
                    3'b001: op_type = OP_LH;
                    3'b101: op_type = OP_LHU;
                    3'b010: op_type = OP_LW;

                endcase
            end

            // S Type
            7'b0100011: begin
                case (funct3) 
                    3'b000: op_type = OP_SB;
                    3'b010: op_type = OP_SW;
                    3'b001: op_type = OP_SH;
                endcase
            end

            // I Type
            7'b0010011: begin
                case (funct3) 
                    3'b000: op_type = OP_ADDI;
                    3'b111: op_type = OP_ANDI;

                    3'b010: op_type = OP_SLTI;
                    3'b011: op_type = OP_SLTIU;

                    3'b001: op_type = OP_SLLI;
                    3'b101: begin
                        if (instr[31:27] == 5'b00000) begin
                            op_type = OP_SRLI;
                        end

                        else if (instr[31:27] == 5'b01000) begin
                            op_type = OP_SRAI;
                        end
                    end

                    3'b100: op_type = OP_XORI;
                    3'b110: op_type = OP_ORI;
                endcase
            end

            // R Type
            7'b0110011: begin
                case ({funct7, funct3}) 
                    10'b0000000000: op_type = OP_ADD;
                    10'b0000000010: op_type = OP_SLT;
                    10'b0000000011: op_type = OP_SLTU;
                    10'b0000000001: op_type = OP_SLL;
                    10'b0000000101: op_type = OP_SRL;
                    10'b0100000101: op_type = OP_SRA;
                    10'b0100000000: op_type = OP_SUB;
                    10'b0000000100: op_type = OP_XOR;
                    10'b0000000110: op_type = OP_OR;
                    10'b0000000111: op_type = OP_AND;

                endcase
            end

            // AUIPC
            7'b0010111: begin
                op_type = OP_AUIPC;
            end

            // jal
            7'b1101111: begin
                op_type = OP_JAL;
            end

            // jalr
            7'b1100111: begin
                op_type = OP_JALR;
            end

            // exception
            7'b1110011: begin
                case (funct3) 
                    3'b001: op_type = OP_CSRRW;
                    3'b010: op_type = OP_CSRRS;
                    3'b011: op_type = OP_CSRRC;
                    3'b101: op_type = OP_CSRRWI;
                    3'b110: op_type = OP_CSRRSI;
                    3'b111: op_type = OP_CSRRCI;
                    3'b000: begin
                        if (instr == 32'b00000_00_00000_00000_000_00000_11100_11) begin
                            op_type = OP_ECALL;
                        end
                        else if (instr == 32'b00000_00_00001_00000_000_00000_11100_11) begin
                            op_type = OP_EBREAK;
                        end
                        else if (instr == 32'b00000_00_00010_00000_000_00000_11100_11) begin
                            op_type = OP_URET;
                        end
                        else if (instr == 32'b00010_00_00010_00000_000_00000_11100_11) begin
                            op_type = OP_SRET;
                        end
                        else if (instr == 32'b00110_00_00010_00000_000_00000_11100_11) begin
                            op_type = OP_MRET;
                        end
                    end
                endcase
            end

            default: begin 
                op_type = OP_UNKNOWN;
            end
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
        csr_opcode = 15;

        case (op_type)
            OP_LUI: begin
                imm = {instr[31:12], 12'b0}; 
                imm_en = 1; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            OP_BEQ, OP_BNE, OP_BLT, OP_BGE, OP_BLTU, OP_BGEU: begin
                imm = {sign_ext20[18:0], instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
                imm_en = 1; wb_en = 0;
                dm_en = 0; dm_wen = 0;
            end

            OP_LB, OP_LH, OP_LW, OP_LBU, OP_LHU: begin
                imm = {sign_ext20[19:0], instr[31:20]}; 
                imm_en = 1; wb_en = 1;
                dm_en = 1; dm_wen = 0;  // Read memory
                case (op_type) 
                    OP_LB: begin
                        dm_width = 1; dm_sign_ext = 1;
                    end
                    OP_LH: begin
                        dm_width = 2; dm_sign_ext = 1;
                    end
                    OP_LW: begin
                        dm_width = 4; dm_sign_ext = 1;
                    end
                    OP_LBU: begin
                        dm_width = 1; dm_sign_ext = 0;
                    end
                    OP_LHU: begin
                        dm_width = 2; dm_sign_ext = 0;
                    end
                endcase
            end

            OP_SB, OP_SH, OP_SW: begin
                imm = {sign_ext20[19:0], instr[31:25], instr[11:7]}; 
                imm_en = 1; wb_en = 0;
                dm_en = 1; dm_wen = 1; 
                case (op_type) 
                    OP_SB: dm_width = 1;
                    OP_SH: dm_width = 2;
                    OP_SW: dm_width = 4;
                endcase    
            end

            OP_ADDI, OP_ANDI, OP_XORI, OP_ORI: begin
                imm = {sign_ext20[19:0], instr[31:20]}; 
                imm_en = 1; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            OP_ADD, OP_SUB, OP_XOR, OP_OR, OP_AND: begin
                imm = 32'h0; imm_en = 0; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end



            OP_SLTI, OP_SLTIU: begin
                imm = {sign_ext20[19:0], instr[31:20]}; 
                imm_en = 1; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            OP_SLT, OP_SLTU, OP_SLL, OP_SRL, OP_SRA: begin
                imm = 32'h0; imm_en = 0; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            OP_SLLI, OP_SRLI, OP_SRAI: begin
                imm = {27'b0, rs2}; imm_en = 1; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end


            OP_AUIPC: begin
                imm = {instr[31:12], 12'b0}; imm_en = 1; wb_en = 1;
                dm_en = 0; dm_wen = 0;
            end

            
            OP_JAL: begin
                imm = {sign_ext20[10:0], instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; imm_en = 1;
                wb_en = 1; dm_en = 0; dm_wen = 0;
            end

            OP_JALR: begin
                imm = {sign_ext20[19:0], instr[31:20]}; imm_en = 1;
                wb_en = 1; dm_en = 0; dm_wen = 1;  // use this to specify JALR
            end

            OP_CSRRW, OP_CSRRS, OP_CSRRC: begin
                case (op_type) 
                    OP_CSRRW: csr_opcode = 1;
                    OP_CSRRS: csr_opcode = 2;
                    OP_CSRRC: csr_opcode = 3;
                endcase
                imm = 0; imm_en = 0;
                wb_en = 1; dm_en = 0; dm_wen = 0;
            end

            OP_CSRRWI, OP_CSRRSI, OP_CSRRCI: begin
                case (op_type) 
                    OP_CSRRWI: csr_opcode = 4;
                    OP_CSRRSI: csr_opcode = 5;
                    OP_CSRRCI: csr_opcode = 6;
                endcase
                imm = {27'b0, instr[19:15]}; imm_en = 1;
                wb_en = 1; dm_en = 0; dm_wen = 0;
            end

            // OP_ECALL,
            // OP_EBREAK,
            // OP_URET,
            // OP_SRET,
            // OP_MRET,


            default: begin
                imm = 32'h0; imm_en = 0; 
                wb_en = 0; dm_en = 0; dm_wen = 0;
                dm_width = 4; dm_sign_ext = 1;
            end
        endcase
    end
    
    logic [`PC_MUX_WIDTH-1:0] pc_mux_ctr_comb;
    logic [`BC_OP_WIDTH-1:0] bc_op_comb;
    logic [3:0] alu_op_comb;
    logic [`ALU_MUX_A_WIDTH-1:0] alu_mux_a_ctr_comb;
    logic [`ALU_MUX_B_WIDTH-1:0] alu_mux_b_ctr_comb;
    logic [`DM_MUX_WIDTH-1:0] dm_mux_ctr_comb;
    
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

            OP_BEQ, OP_BNE, OP_BLT, OP_BGE, OP_BLTU, OP_BGEU: begin
                pc_mux_ctr_comb = `PC_MUX_BRANCH;  // Branch if bc_comp output is 1
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_PC;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;

                case (op_type)
                    OP_BEQ: bc_op_comb = `BC_OP_EQU;
                    OP_BNE: bc_op_comb = `BC_OP_NEQ;
                    OP_BLT: bc_op_comb = `BC_OP_LT;
                    OP_BGE: bc_op_comb = `BC_OP_GE;
                    OP_BLTU: bc_op_comb = `BC_OP_LTU;
                    OP_BGEU: bc_op_comb = `BC_OP_GEU;
                endcase
            end


            OP_LB, OP_LH, OP_LW, OP_LBU, OP_LHU: begin
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_MEM;
            end

            OP_SB, OP_SH, OP_SW : begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_MEM;
            end

            OP_ADDI, OP_ANDI, OP_XORI, OP_ORI: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;
                case(op_type) 
                    OP_ADDI: alu_op_comb = `ALU_OP_ADD;
                    OP_ANDI: alu_op_comb = `ALU_OP_AND;
                    OP_XORI: alu_op_comb = `ALU_OP_XOR;
                    OP_ORI: alu_op_comb = `ALU_OP_OR;
                endcase
            end

            OP_ADD, OP_SUB, OP_XOR, OP_OR, OP_AND: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_DATA;
                dm_mux_ctr_comb = `DM_MUX_ALU;
                case (op_type) 
                    OP_ADD: alu_op_comb = `ALU_OP_ADD;
                    OP_SUB: alu_op_comb = `ALU_OP_SUB;
                    OP_XOR: alu_op_comb = `ALU_OP_XOR;
                    OP_OR: alu_op_comb = `ALU_OP_OR;
                    OP_AND: alu_op_comb = `ALU_OP_AND;
                endcase
            end

            OP_NOP: begin 
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_UNKNOWN;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_DATA;
                dm_mux_ctr_comb = `DM_MUX_ALU;
            end

            OP_SLTI, OP_SLTIU, OP_SLT, OP_SLTU: begin
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_op_comb = `ALU_OP_ADD;
                alu_mux_a_ctr_comb = `ALU_MUX_A_ZERO;
                alu_mux_b_ctr_comb = `ALU_MUX_B_BC_RESULT;
                dm_mux_ctr_comb = `DM_MUX_ALU;

                if (op_type == OP_SLTI || op_type == OP_SLT) begin
                    bc_op_comb = `BC_OP_LT;
                end else begin
                    bc_op_comb = `BC_OP_LTU;
                end

            end

            OP_SLLI, OP_SRLI, OP_SRAI: begin
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;

                if (op_type == OP_SLLI) begin
                    alu_op_comb = `ALU_OP_SLL;
                end else if (op_type == OP_SRLI) begin
                    alu_op_comb = `ALU_OP_SLR;
                end else if (op_type == OP_SRAI) begin
                    alu_op_comb = `ALU_OP_SAR;
                end
            end
            
            OP_SLL, OP_SRL, OP_SRA: begin
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_DATA;
                dm_mux_ctr_comb = `DM_MUX_ALU;

                if (op_type == OP_SLL) begin
                    alu_op_comb = `ALU_OP_SLL;
                end else if (op_type == OP_SRL) begin
                    alu_op_comb = `ALU_OP_SLR;
                end else if (op_type == OP_SRA) begin
                    alu_op_comb = `ALU_OP_SAR;
                end
            end

            OP_AUIPC: begin
                pc_mux_ctr_comb = `PC_MUX_INC;
                alu_mux_a_ctr_comb = `ALU_MUX_A_PC;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_ALU;
                alu_op_comb = `ALU_OP_ADD;
            end

            OP_JAL: begin
                pc_mux_ctr_comb = `PC_MUX_BRANCH;
                alu_mux_a_ctr_comb = `ALU_MUX_A_PC;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_PC_INC;
                alu_op_comb = `ALU_OP_ADD;
                bc_op_comb = `BC_OP_TRUE;
            end

            OP_JALR: begin
                pc_mux_ctr_comb = `PC_MUX_BRANCH;
                alu_mux_a_ctr_comb = `ALU_MUX_A_DATA;
                alu_mux_b_ctr_comb = `ALU_MUX_B_IMM;
                dm_mux_ctr_comb = `DM_MUX_PC_INC;
                alu_op_comb = `ALU_OP_ADD;
                bc_op_comb = `BC_OP_TRUE;
            end
            
            OP_CSRRW, OP_CSRRS, OP_CSRRC, OP_CSRRWI, OP_CSRRSI, OP_CSRRCI: begin
                pc_mux_ctr_comb = `PC_MUX_INC;
                bc_op_comb = `BC_OP_FALSE;
                alu_op_comb = `ALU_OP_ADD; 
                alu_mux_a_ctr_comb = `ALU_MUX_A_CSR;
                alu_mux_b_ctr_comb = `ALU_MUX_B_ZERO; // zero
                dm_mux_ctr_comb = `DM_MUX_ALU;
            end

        endcase
    end

endmodule
