// PC mux
`define PC_MUX_WIDTH 2
`define PC_MUX_INC `PC_MUX_WIDTH'd0
`define PC_MUX_BRANCH `PC_MUX_WIDTH'd1

// ALU OP and ALU mux
`define ALU_OP_WIDTH 4
`define ALU_MUX_WIDTH 2
`define ALU_MUX_A_WIDTH 2
`define ALU_MUX_B_WIDTH 2

`define ALU_OP_UNKNOWN   `ALU_OP_WIDTH'd0
`define ALU_OP_ADD   `ALU_OP_WIDTH'd1
`define ALU_OP_SUB   `ALU_OP_WIDTH'd2
`define ALU_OP_AND   `ALU_OP_WIDTH'd3
`define ALU_OP_OR    `ALU_OP_WIDTH'd4
`define ALU_OP_XOR   `ALU_OP_WIDTH'd5
`define ALU_OP_NOT   `ALU_OP_WIDTH'd6
`define ALU_OP_SLL   `ALU_OP_WIDTH'd7
`define ALU_OP_SLR   `ALU_OP_WIDTH'd8
`define ALU_OP_SAR   `ALU_OP_WIDTH'd9
`define ALU_OP_RL   `ALU_OP_WIDTH'd10

`define ALU_MUX_A_DATA `ALU_MUX_WIDTH'd0
`define ALU_MUX_A_PC `ALU_MUX_WIDTH'd1
`define ALU_MUX_A_ZERO `ALU_MUX_WIDTH'd2
`define ALU_MUX_A_CSR `ALU_MUX_WIDTH'd3

`define ALU_MUX_B_DATA `ALU_MUX_WIDTH'd0
`define ALU_MUX_B_IMM `ALU_MUX_WIDTH'd1
`define ALU_MUX_B_ZERO `ALU_MUX_WIDTH'd2
`define ALU_MUX_B_BC_RESULT `ALU_MUX_WIDTH'd3

// DM mux
`define DM_MUX_WIDTH 2
`define DM_MUX_MEM `DM_MUX_WIDTH'd0
`define DM_MUX_ALU `DM_MUX_WIDTH'd1
`define DM_MUX_PC_INC `DM_MUX_WIDTH'd2
`define DM_MUX_ALU_JALR `DM_MUX_WIDTH'd3
