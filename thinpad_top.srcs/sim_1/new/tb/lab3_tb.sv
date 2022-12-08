`timescale 1ns / 1ps
module lab3_tb;

  wire clk_50M, clk_11M0592;

  reg push_btn;   // BTN5 ��ť���أ���������·������ʱΪ 1
  reg reset_btn;  // BTN6 ��λ��ť����������·������ʱΪ 1

  reg [3:0] touch_btn; // BTN1~BTN4����ť���أ�����ʱΪ 1
  reg [31:0] dip_sw;   // 32 λ���뿪�أ�������ON��ʱΪ 1

  wire [15:0] leds;  // 16 λ LED�����ʱ 1 ����
  wire [7:0] dpy0;   // ����ܵ�λ�źţ�����С���㣬��� 1 ����
  wire [7:0] dpy1;   // ����ܸ�λ�źţ�����С���㣬��� 1 ����

  // ʵ�� 3 �õ���ָ���ʽ
  `define inst_rtype(rd, rs1, rs2, op) \
    {7'b0, rs2, rs1, 3'b0, rd, op, 3'b001}

  `define inst_itype(rd, imm, op) \
    {imm, 4'b0, rd, op, 3'b010}
  
  `define inst_poke(rd, imm) `inst_itype(rd, imm, 4'b0001)
  `define inst_peek(rd, imm) `inst_itype(rd, imm, 4'b0010)

  // opcode table
  typedef enum logic [3:0] {
    ADD = 4'b0001,
    SUB = 4'b0010,
    AND = 4'b0011,
    OR  = 4'b0100,
    XOR = 4'b0101,
    NOT = 4'b0110,
    SLL = 4'b0111,
    SRL = 4'b1000,
    SRA = 4'b1001,
    ROL = 4'b1010
  } opcode_t;

//  logic is_rtype, is_itype, is_load, is_store, is_unknown;
//  logic [15:0] imm;
//  logic [4:0] rd, rs1, rs2;
//  logic [3:0] opcode;
logic [3:0] i;
  initial begin
    // ����������Զ�������������У����磺
    dip_sw = 32'h0;
    touch_btn = 0;
    reset_btn = 0;
    push_btn = 0;

    #100;
    reset_btn = 1;
    #100;
    reset_btn = 0;
    #1000;  // �ȴ���λ����
    
    dip_sw = `inst_poke(5'h1, -16'h63);
    #500;
    push_btn = 1;
    #500;
    push_btn = 0;
    #1000;
    
    dip_sw = `inst_poke(5'h2, 16'h4);
    #500;
    push_btn = 1;
    #500;
    push_btn = 0;
    #2000;
    
    dip_sw = `inst_rtype(5'h3, 5'h1, 5'h2, 4'h1);
    #500;
    push_btn = 1;
    #500;
    push_btn = 0;
    #1000;
    
    dip_sw = `inst_peek(5'h3, 16'h111);
    #500;
    push_btn = 1;
    #500;
    push_btn = 0;
    #2000;

    // ������ʹ�� POKE ָ��Ϊ�Ĵ����������ֵ
    for (i = 4'h1; i <= 10; i = i + 1) begin
        dip_sw = `inst_rtype(5'h3, 5'h1, 5'h2, i);
        #500;
        push_btn = 1;
        #500;
        push_btn = 0;
        #1000;
        
        dip_sw = `inst_peek(5'h3, 16'h111);
        #500;
        push_btn = 1;
        #500;
        push_btn = 0;
        #2000;
    end

    // DontCare: ������Ը���ָ��

    #10000 $finish;
  end

  // �������û����
  lab3_top dut (
      .clk_50M(clk_50M),
      .clk_11M0592(clk_11M0592),
      .push_btn(push_btn),
      .reset_btn(reset_btn),
      .touch_btn(touch_btn),
      .dip_sw(dip_sw),
      .leds(leds),
      .dpy1(dpy1),
      .dpy0(dpy0),

      .txd(),
      .rxd(1'b1),
      .uart_rdn(),
      .uart_wrn(),
      .uart_dataready(1'b0),
      .uart_tbre(1'b0),
      .uart_tsre(1'b0),
      .base_ram_data(),
      .base_ram_addr(),
      .base_ram_ce_n(),
      .base_ram_oe_n(),
      .base_ram_we_n(),
      .base_ram_be_n(),
      .ext_ram_data(),
      .ext_ram_addr(),
      .ext_ram_ce_n(),
      .ext_ram_oe_n(),
      .ext_ram_we_n(),
      .ext_ram_be_n(),
      .flash_d(),
      .flash_a(),
      .flash_rp_n(),
      .flash_vpen(),
      .flash_oe_n(),
      .flash_ce_n(),
      .flash_byte_n(),
      .flash_we_n()
  );

  // ʱ��Դ
  clock osc (
      .clk_11M0592(clk_11M0592),
      .clk_50M    (clk_50M)
  );

endmodule
