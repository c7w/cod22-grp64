module controller (
    input wire clk,
    input wire reset,

    // 连接寄存器堆模块的信号
    output reg  [4:0]  rf_raddr_a,
    input  wire [15:0] rf_rdata_a,
    output reg  [4:0]  rf_raddr_b,
    input  wire [15:0] rf_rdata_b,
    output reg  [4:0]  rf_waddr,
    output reg  [15:0] rf_wdata,
    output reg  rf_we,

    // 连接 ALU 模块的信号
    output reg  [15:0] alu_a,
    output reg  [15:0] alu_b,
    output reg  [ 3:0] alu_op,
    input  wire [15:0] alu_y,

    // 控制信号
    input  wire        step,    // 用户按键状态脉冲
    input  wire [31:0] dip_sw,  // 32 位拨码开关状态
    output reg  [15:0] leds
);

  logic [31:0] inst_reg;  // 指令寄存器

  // 组合逻辑，解析指令中的常用部分，依赖于有效的 inst_reg 值
  logic is_rtype, is_itype, is_peek, is_poke;
  logic [15:0] imm;
  logic [4:0] rd, rs1, rs2;
  logic [3:0] opcode;

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

  // 使用枚举定义状态列表，数据类型为 logic [3:0]
  typedef enum logic [3:0] {
    ST_INIT,
    ST_DECODE,
    ST_CALC,
    ST_READ_REG,
    ST_WRITE_REG
  } state_t;

  // 状态机当前状态寄存器
  state_t state;
  
  reg[2:0] delay;

  // 状态机逻辑
  always_ff @(posedge clk) begin
    if (reset) begin
        rf_raddr_a <= 0;
        rf_raddr_b <= 0;
        rf_waddr <= 0;
        rf_wdata <= 0;
        rf_we <= 0;
        alu_a <= 0;
        alu_b <= 0;
        alu_op <= 0;
        leds <= 0;
        
        delay <= 0;
        state <= ST_INIT;
    end else begin
      case (state)
        ST_INIT: begin
          if (step) begin
            inst_reg <= dip_sw;
            state <= ST_DECODE;
          end
        end

        ST_DECODE: begin
          if (is_rtype) begin
            rf_raddr_a <= rs1;
            rf_raddr_b <= rs2;
            state <= ST_CALC;
          end else if (is_itype) begin
            if (is_peek) begin
                state <= ST_READ_REG;
            end else if (is_poke) begin
                state <= ST_WRITE_REG;
            end else begin
                state <= ST_INIT;
            end
          end else begin
            state <= ST_INIT;
          end
        end

        ST_CALC: begin
          // TODO: 将数据交给 ALU
          if (delay == 0) begin
              // 此时 RF 仅有地址
              delay <= 1;
          end else if (delay == 1) begin
              // 此时可以拿到 RF 的数据
              alu_a <= rf_rdata_a;
              alu_b <= rf_rdata_b;
              alu_op <= opcode;
              delay <= 2;
          end else if (delay == 2) begin
              // TODO: 并从 ALU 获取结果
              inst_reg[31:16] <= alu_y;
              state <= ST_WRITE_REG;
              delay <= 0;
          end
        end

        ST_WRITE_REG: begin
          if (delay == 0) begin
              rf_waddr <= rd;
              rf_wdata <= imm;
              delay <= 1;
          end else if (delay == 1) begin
              rf_we <= 1;
              delay <= 2;
          end else if (delay == 2) begin
              rf_we <= 0;
              delay <= 0;
              state <= ST_INIT;
          end          
        end

        ST_READ_REG: begin
          if (delay == 0) begin
              rf_raddr_a <= rd;
              delay <= 1;
          end else if (delay == 1) begin
              delay <= delay + 1;
          end else if (delay == 2) begin
              leds <= rf_rdata_a;
              delay <= 0;
              state <= ST_INIT;
          end
          
        end

        default: begin
          state <= ST_INIT;
        end
      endcase
    end
  end
endmodule
