module REG_IF_ID #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input clk,
    input rst,

    input pc_addr,
    input instr,

    // Control signals
);

    // Decode instr
    logic is_rtype, is_itype, is_stype, is_btype, is_utype, is_jtype;
    logic [31:0] imm;
    logic [4:0] rd, rs1, rs2;
    logic [6:0] opcode;
    logic [4:0] opcode_alu;

    assign opcode[6:0] = instr[6:0];
    always_comb begin
        is_rtype = opcode == 7'b0110011;
        
    end

    always_comb begin
        is_rtype = (inst_reg[2:0] == 3'b001);
        is_itype = (inst_reg[2:0] == 3'b010);
        is_peek = is_itype && (inst_reg[6:3] == 4'b0010);
        is_poke = is_itype && (inst_reg[6:3] == 4'b0001);

        imm = inst_reg[31:16];
        rd = inst_reg[11:7];
        rs1 = inst_reg[19:15];
        rs2 = inst_reg[24:20];
        opcode = inst_reg[6:3];
    end




endmodule