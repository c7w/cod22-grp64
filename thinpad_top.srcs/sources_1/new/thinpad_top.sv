`default_nettype none
`include "../headers/ops.vh"
`include "../headers/ctrl.vh"
`include "../headers/branch_comp.vh"

module thinpad_top #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk_50M,     // 50MHz 时钟输入
    input wire clk_11M0592, // 11.0592MHz 时钟输入（备用，可不用）

    input wire push_btn,  // BTN5 按钮�?关，带消抖电路，按下时为 1
    input wire reset_btn, // BTN6 复位按钮，带消抖电路，按下时�? 1

    input  wire [ 3:0] touch_btn,  // BTN1~BTN4，按钮开关，按下时为 1
    input  wire [31:0] dip_sw,     // 32 位拨码开关，拨到“ON”时�? 1
    output wire [15:0] leds,       // 16 �? LED，输出时 1 点亮
    output wire [ 7:0] dpy0,       // 数码管低位信号，包括小数点，输出 1 点亮
    output wire [ 7:0] dpy1,       // 数码管高位信号，包括小数点，输出 1 点亮

    // CPLD 串口控制器信�?
    output wire uart_rdn,        // 读串口信号，低有�?
    output wire uart_wrn,        // 写串口信号，低有�?
    input  wire uart_dataready,  // 串口数据准备�?
    input  wire uart_tbre,       // 发�?�数据标�?
    input  wire uart_tsre,       // 数据发�?�完毕标�?

    // BaseRAM 信号
    inout wire [31:0] base_ram_data,  // BaseRAM 数据，低 8 位与 CPLD 串口控制器共�?
    output wire [19:0] base_ram_addr,  // BaseRAM 地址
    output wire [3:0] base_ram_be_n,  // BaseRAM 字节使能，低有效。如果不使用字节使能，请保持�? 0
    output wire base_ram_ce_n,  // BaseRAM 片�?�，低有�?
    output wire base_ram_oe_n,  // BaseRAM 读使能，低有�?
    output wire base_ram_we_n,  // BaseRAM 写使能，低有�?

    // ExtRAM 信号
    inout wire [31:0] ext_ram_data,  // ExtRAM 数据
    output wire [19:0] ext_ram_addr,  // ExtRAM 地址
    output wire [3:0] ext_ram_be_n,  // ExtRAM 字节使能，低有效。如果不使用字节使能，请保持�? 0
    output wire ext_ram_ce_n,  // ExtRAM 片�?�，低有�?
    output wire ext_ram_oe_n,  // ExtRAM 读使能，低有�?
    output wire ext_ram_we_n,  // ExtRAM 写使能，低有�?

    // 直连串口信号
    output wire txd,  // 直连串口发�?�端
    input  wire rxd,  // 直连串口接收�?

    // Flash 存储器信号，参�?? JS28F640 芯片手册
    output wire [22:0] flash_a,  // Flash 地址，a0 仅在 8bit 模式有效�?16bit 模式无意�?
    inout wire [15:0] flash_d,  // Flash 数据
    output wire flash_rp_n,  // Flash 复位信号，低有效
    output wire flash_vpen,  // Flash 写保护信号，低电平时不能擦除、烧�?
    output wire flash_ce_n,  // Flash 片�?�信号，低有�?
    output wire flash_oe_n,  // Flash 读使能信号，低有�?
    output wire flash_we_n,  // Flash 写使能信号，低有�?
    output wire flash_byte_n, // Flash 8bit 模式选择，低有效。在使用 flash �? 16 位模式时请设�? 1

    // USB 控制器信号，参�?? SL811 芯片手册
    output wire sl811_a0,
    // inout  wire [7:0] sl811_d,     // USB 数据线与网络控制器的 dm9k_sd[7:0] 共享
    output wire sl811_wr_n,
    output wire sl811_rd_n,
    output wire sl811_cs_n,
    output wire sl811_rst_n,
    output wire sl811_dack_n,
    input  wire sl811_intrq,
    input  wire sl811_drq_n,

    // 网络控制器信号，参�?? DM9000A 芯片手册
    output wire dm9k_cmd,
    inout wire [15:0] dm9k_sd,
    output wire dm9k_iow_n,
    output wire dm9k_ior_n,
    output wire dm9k_cs_n,
    output wire dm9k_pwrst_n,
    input wire dm9k_int,

    // 图像输出信号
    output wire [2:0] video_red,    // 红色像素�?3 �?
    output wire [2:0] video_green,  // 绿色像素�?3 �?
    output wire [1:0] video_blue,   // 蓝色像素�?2 �?
    output wire       video_hsync,  // 行同步（水平同步）信�?
    output wire       video_vsync,  // 场同步（垂直同步）信�?
    output wire       video_clk,    // 像素时钟输出
    output wire       video_de      // 行数据有效信号，用于区分消隐�?
);

  /* =========== Demo code begin =========== */

  // PLL 分频示例
  logic locked, clk_10M, clk_20M;
  pll_example clock_gen (
      // Clock in ports
      .clk_in1(clk_50M),  // 外部时钟输入
      // Clock out ports
      .clk_out1(clk_10M),  // 时钟输出 1，频率在 IP 配置界面中设�?
      .clk_out2(clk_20M),  // 时钟输出 2，频率在 IP 配置界面中设�?
      // Status and control signals
      .reset(reset_btn),  // PLL 复位输入
      .locked(locked)  // PLL 锁定指示输出�?"1"表示时钟稳定�?
                       // 后级电路复位信号应当由它生成（见下）
  );

  // logic reset_of_clk10M;
  // // 异步复位，同步释放，�? locked 信号转为后级电路的复�? reset_of_clk10M
  // always_ff @(posedge clk_10M or negedge locked) begin
  //   if (~locked) reset_of_clk10M <= 1'b1;
  //   else reset_of_clk10M <= 1'b0;
  // end

  // always_ff @(posedge clk_10M or posedge reset_of_clk10M) begin
  //   if (reset_of_clk10M) begin
  //     // Your Code
  //   end else begin
  //     // Your Code
  //   end
  // end

  // // 不使用内存�?�串口时，禁用其使能信号
  // assign base_ram_ce_n = 1'b1;
  // assign base_ram_oe_n = 1'b1;
  // assign base_ram_we_n = 1'b1;

  // assign ext_ram_ce_n = 1'b1;
  // assign ext_ram_oe_n = 1'b1;
  // assign ext_ram_we_n = 1'b1;

  // assign uart_rdn = 1'b1;
  // assign uart_wrn = 1'b1;

  // // 数码管连接关系示意图，dpy1 同理
  // // p=dpy0[0] // ---a---
  // // c=dpy0[1] // |     |
  // // d=dpy0[2] // f     b
  // // e=dpy0[3] // |     |
  // // b=dpy0[4] // ---g---
  // // a=dpy0[5] // |     |
  // // f=dpy0[6] // e     c
  // // g=dpy0[7] // |     |
  // //           // ---d---  p

  // // 7 段数码管译码器演示，�? number �? 16 进制显示在数码管上面
  // logic [7:0] number;
  // SEG7_LUT segL (
  //     .oSEG1(dpy0),
  //     .iDIG (number[3:0])
  // );  // dpy0 是低位数码管
  // SEG7_LUT segH (
  //     .oSEG1(dpy1),
  //     .iDIG (number[7:4])
  // );  // dpy1 是高位数码管

  // logic [15:0] led_bits;
  // assign leds = led_bits;

  // always_ff @(posedge push_btn or posedge reset_btn) begin
  //   if (reset_btn) begin  // 复位按下，设�? LED 为初始�??
  //     led_bits <= 16'h1;
  //   end else begin  // 每次按下按钮�?关，LED 循环左移
  //     led_bits <= {led_bits[14:0], led_bits[15]};
  //   end
  // end

  // // 直连串口接收发�?�演示，从直连串口收到的数据再发送出�?
  // logic [7:0] ext_uart_rx;
  // logic [7:0] ext_uart_buffer, ext_uart_tx;
  // logic ext_uart_ready, ext_uart_clear, ext_uart_busy;
  // logic ext_uart_start, ext_uart_avai;

  // assign number = ext_uart_buffer;

  // // 接收模块�?9600 无检验位
  // async_receiver #(
  //     .ClkFrequency(50000000),
  //     .Baud(9600)
  // ) ext_uart_r (
  //     .clk           (clk_50M),         // 外部时钟信号
  //     .RxD           (rxd),             // 外部串行信号输入
  //     .RxD_data_ready(ext_uart_ready),  // 数据接收到标�?
  //     .RxD_clear     (ext_uart_clear),  // 清除接收标志
  //     .RxD_data      (ext_uart_rx)      // 接收到的�?字节数据
  // );

  // assign ext_uart_clear = ext_uart_ready; // 收到数据的同时，清除标志，因为数据已取到 ext_uart_buffer �?
  // always_ff @(posedge clk_50M) begin  // 接收到缓冲区 ext_uart_buffer
  //   if (ext_uart_ready) begin
  //     ext_uart_buffer <= ext_uart_rx;
  //     ext_uart_avai   <= 1;
  //   end else if (!ext_uart_busy && ext_uart_avai) begin
  //     ext_uart_avai <= 0;
  //   end
  // end
  // always_ff @(posedge clk_50M) begin  // 将缓冲区 ext_uart_buffer 发�?�出�?
  //   if (!ext_uart_busy && ext_uart_avai) begin
  //     ext_uart_tx <= ext_uart_buffer;
  //     ext_uart_start <= 1;
  //   end else begin
  //     ext_uart_start <= 0;
  //   end
  // end

  // // 发�?�模块，9600 无检验位
  // async_transmitter #(
  //     .ClkFrequency(50000000),
  //     .Baud(9600)
  // ) ext_uart_t (
  //     .clk      (clk_50M),         // 外部时钟信号
  //     .TxD      (txd),             // 串行信号输出
  //     .TxD_busy (ext_uart_busy),   // 发�?�器忙状态指�?
  //     .TxD_start(ext_uart_start),  // �?始发送信�?
  //     .TxD_data (ext_uart_tx)      // 待发送的数据
  // );

  // // 图像输出演示，分辨率 800x600@75Hz，像素时钟为 50MHz
  // logic [11:0] hdata;
  // assign video_red   = hdata < 266 ? 3'b111 : 0;  // 红色竖条
  // assign video_green = hdata < 532 && hdata >= 266 ? 3'b111 : 0;  // 绿色竖条
  // assign video_blue  = hdata >= 532 ? 2'b11 : 0;  // 蓝色竖条
  // assign video_clk   = clk_50M;
  // vga #(12, 800, 856, 976, 1040, 600, 637, 643, 666, 1, 1) vga800x600at75 (
  //     .clk        (clk_50M),
  //     .hdata      (hdata),        // 横坐�?
  //     .vdata      (),             // 纵坐�?
  //     .hsync      (video_hsync),
  //     .vsync      (video_vsync),
  //     .data_enable(video_de)
  // );
  // /* =========== Demo code end =========== */


    // Controller
    logic [3:0] CONTROLLER_stall;
    logic [3:0] CONTROLLER_bubble;
    logic CONTROLLER_branching;
    logic CONTROLLER_dm_ack;
    logic CONTROLLER_bc_cond;  // TODO: add branching support

    CONTROLLER_pipeline CONTROLLER_pipeline (
        .dm_ack(CONTROLLER_dm_ack),
        
        .ID_rs1(ID_rs1),
        .ID_rs2(ID_rs2),
        .EXE_rd(EXE_rd),
        .EXE_wb_en(EXE_wb_en),
        .DM_rd(MEM_rd),
        .DM_wb_en(MEM_wb_en),
        .WB_rd(RF_waddr),
        .WB_wb_en(RF_wen),

        .bc_comp_result(CONTROLLER_bc_cond),
        .EXE_pc_addr(EXE_pc_addr),
        .EXE_pc_addr_calculated(alu_o),
        .EXE_pc_addr_predicted(ID_pc_addr),
        
        .branching(CONTROLLER_branching),
        .stall_o(CONTROLLER_stall),
        .bubble_o(CONTROLLER_bubble)
    );

    // IF

    logic [ADDR_WIDTH-1:0] IF_pc_addr;
    logic [ADDR_WIDTH-1:0] IF_pc_nxt, IF_pc_next_prediction;
    logic [DATA_WIDTH-1:0] IF_instr;
    logic [DATA_WIDTH-1:0] IF_imm;
    logic [4:0] IF_rs1, IF_rs2, IF_rd;
    logic [`PC_MUX_WIDTH-1:0] IF_pc_mux_ctr;
    logic [`BC_OP_WIDTH-1:0] IF_BC_op;
    logic [`ALU_OP_WIDTH-1:0] IF_ALU_op;
    logic [`ALU_MUX_A_WIDTH-1:0] IF_ALU_mux_a_ctr;
    logic [`ALU_MUX_B_WIDTH-1:0] IF_ALU_mux_b_ctr;
    logic [`DM_MUX_WIDTH-1:0] IF_dm_mux_ctr;
    logic IF_dm_en, IF_dm_wen, IF_wb_en;


    IF_pc pc (
        .clk (clk_10M),
        .rst (reset_btn),
        .stall(CONTROLLER_stall[0]),
        .pc_nxt(IF_pc_nxt),
        .pc_addr(IF_pc_addr),  // output
        .pc_nxt_prediction(IF_pc_next_prediction)  // todo: add branching prediction
    );

    IF_pc_mux pc_mux (
        .branching(CONTROLLER_branching),
        .pc_predicted(IF_pc_next_prediction),
        .branch_addr(alu_o),
        .pc_nxt(IF_pc_nxt)
    );

    // wishbone master for IM
    logic wbm_cyc_im;
    logic wbm_stb_im;
    logic wbm_ack_im;
    logic [ADDR_WIDTH-1:0] wbm_adr_im;
    logic [DATA_WIDTH-1:0] wbm_dat_m2s_im;  // master 2 slave
    logic [DATA_WIDTH-1:0] wbm_dat_s2m_im;  // slave 2 master
    logic [DATA_WIDTH/8-1:0] wbm_sel_im;
    logic wbm_we_im;

    IF_im instr_fetcher (
        .clk(clk_50M),
        .rst(reset_btn),
        .pc_addr(IF_pc_addr),
        .instr(IF_instr),
        .wb_cyc_o(wbm_cyc_im),
        .wb_stb_o(wbm_stb_im),
        .wb_ack_i(wbm_ack_im),
        .wb_adr_o(wbm_adr_im),
        .wb_dat_o(wbm_dat_m2s_im),
        .wb_dat_i(wbm_dat_s2m_im),
        .wb_sel_o(wbm_sel_im),
        .wb_we_o(wbm_we_im)
    );

    logic [ADDR_WIDTH-1:0] ID_pc_addr;
    logic [DATA_WIDTH-1:0] ID_imm;
    logic [4:0] ID_rs1, ID_rs2, ID_rd;
    logic [`PC_MUX_WIDTH-1:0] ID_pc_mux_ctr;
    logic [`BC_OP_WIDTH-1:0] ID_BC_op;
    logic [`ALU_OP_WIDTH-1:0] ID_ALU_op;
    logic [`ALU_MUX_A_WIDTH-1:0] ID_ALU_mux_a_ctr;
    logic [`ALU_MUX_B_WIDTH-1:0] ID_ALU_mux_b_ctr;
    logic [`DM_MUX_WIDTH-1:0] ID_dm_mux_ctr;
    logic ID_dm_en, ID_dm_wen, ID_wb_en;

    IF_DECODER instr_decoder(
        .instr(IF_instr),
        .imm(IF_imm),
        .imm_en(),  // not used
        .dm_en(IF_dm_en),
        .dm_wen(IF_dm_wen),
        .wb_en(IF_wb_en),
        .rd(IF_rd),
        .rs1(IF_rs1),
        .rs2(IF_rs2),
        .pc_mux_ctr(IF_pc_mux_ctr),
        .bc_op(IF_BC_op),
        .alu_op(IF_ALU_op),
        .alu_mux_a_ctr(IF_ALU_mux_a_ctr),
        .alu_mux_b_ctr(IF_ALU_mux_b_ctr),
        .dm_mux_ctr(IF_dm_mux_ctr)
    );

    REG_IF_ID reg_if_id (
        .clk(clk_10M),
        .rst(reset_btn),
        .stall(CONTROLLER_stall[1]),
        .bubble(CONTROLLER_bubble[0]),

        // IF -> ID
        .rs1_i(IF_rs1),
        .rs2_i(IF_rs2),
        .rd_i(IF_rd),
        .imm_i(IF_imm),
        
        .rs1_o(ID_rs1),
        .rs2_o(ID_rs2),
        .rd_o(ID_rd),
        .imm_o(ID_imm),

        // ID -> EXE
        .bc_op_i(IF_BC_op),
        .alu_op_i(IF_ALU_op),
        .alu_mux_a_ctr_i(IF_ALU_mux_a_ctr),
        .alu_mux_b_ctr_i(IF_ALU_mux_b_ctr),
        .pc_mux_ctr_i(IF_pc_mux_ctr),

        .bc_op_o(ID_BC_op),
        .alu_op_o(ID_ALU_op),
        .alu_mux_a_ctr_o(ID_ALU_mux_a_ctr),
        .alu_mux_b_ctr_o(ID_ALU_mux_b_ctr),
        .pc_mux_ctr_o(ID_pc_mux_ctr),

        // EXE -> MEM
        .pc_addr_i(IF_pc_addr),
        .dm_en_i(IF_dm_en),
        .dm_wen_i(IF_dm_wen),
        .dm_mux_ctr_i(IF_dm_mux_ctr),
        
        .pc_addr_o(ID_pc_addr),
        .dm_en_o(ID_dm_en),
        .dm_wen_o(ID_dm_wen),
        .dm_mux_ctr_o(ID_dm_mux_ctr),

        // MEM -> WB
        .wb_en_i(IF_wb_en),
        .wb_en_o(ID_wb_en)
    );

    logic [4:0] RF_waddr;
    logic [DATA_WIDTH-1:0] RF_wdata;
    logic RF_wen;
    logic [DATA_WIDTH-1:0] RF_data_a, RF_data_b;


    RegisterFile rf (
        .clk(clk_10M),
        .rst(reset_btn),

        .waddr(RF_waddr),
        .wdata(RF_wdata),
        .wen(RF_wen),

        .raddr_a(ID_rs1),
        .raddr_b(ID_rs2),

        .rdata_a(RF_data_a),
        .rdata_b(RF_data_b)
    );

    logic [DATA_WIDTH-1:0] EXE_data_a, EXE_data_b, EXE_imm;
    logic [`BC_OP_WIDTH-1:0] EXE_bc_op;
    logic [`ALU_OP_WIDTH-1:0] EXE_ALU_op;
    logic [`ALU_MUX_A_WIDTH-1:0] EXE_ALU_mux_a_ctr;
    logic [`ALU_MUX_B_WIDTH-1:0] EXE_ALU_mux_b_ctr;
    logic [`DM_MUX_WIDTH-1:0] EXE_dm_mux_ctr;
    logic [`PC_MUX_WIDTH-1:0] EXE_pc_mux_ctr;
    logic [ADDR_WIDTH-1:0] EXE_pc_addr;
    logic EXE_dm_en, EXE_dm_wen, EXE_wb_en;
    logic [4:0] EXE_rd;
    

    REG_ID_EXE reg_id_exe (
        .clk(clk_10M),
        .rst(reset_btn),

        .stall(CONTROLLER_stall[2]),
        .bubble(CONTROLLER_bubble[1]),

        .imm_i(ID_imm),
        .rd_i(ID_rd),
        .imm_o(EXE_imm),
        .rd_o(EXE_rd),

        .rf_data_a_i(RF_data_a),
        .bc_op_i(ID_BC_op),
        .alu_op_i(ID_ALU_op),
        .alu_mux_a_ctr_i(ID_ALU_mux_a_ctr),
        .alu_mux_b_ctr_i(ID_ALU_mux_b_ctr),
        .pc_mux_ctr_i(ID_pc_mux_ctr),

        .rf_data_a_o(EXE_data_a),
        .bc_op_o(EXE_bc_op),
        .alu_op_o(EXE_ALU_op),
        .alu_mux_a_ctr_o(EXE_ALU_mux_a_ctr),
        .alu_mux_b_ctr_o(EXE_ALU_mux_b_ctr),
        .pc_mux_ctr_o(EXE_pc_mux_ctr),


        .pc_addr_i(ID_pc_addr),
        .dm_en_i(ID_dm_en),
        .dm_wen_i(ID_dm_wen),
        .dm_mux_ctr_i(ID_dm_mux_ctr),
        .rf_data_b_i(RF_data_b),

        .pc_addr_o(EXE_pc_addr),
        .dm_en_o(EXE_dm_en),
        .dm_wen_o(EXE_dm_wen),
        .dm_mux_ctr_o(EXE_dm_mux_ctr),
        .rf_data_b_o(EXE_data_b),


        .wb_en_i(ID_wb_en),
        .wb_en_o(EXE_wb_en)
    );

    
    logic [DATA_WIDTH-1:0] alu_a, alu_b, alu_o;
    logic [3:0] alu_op;

    EXE_alu_mux_a exe_alu_mux_a (
        .alu_mux_a_ctr_i(EXE_ALU_mux_a_ctr),
        .alu_mux_a_data(EXE_data_a),
        .alu_mux_a_pc(EXE_pc_addr),
        .alu_mux_a_o(alu_a)
    );

    EXE_alu_mux_b exe_alu_mux_b (
        .alu_mux_b_ctr_i(EXE_ALU_mux_b_ctr),
        .alu_mux_b_data(EXE_data_b),
        .alu_mux_b_imm(EXE_imm),
        .alu_mux_b_o(alu_b)
    );

    ALU alu (
        .a(alu_a),
        .b(alu_b),
        .op(alu_op),
        .y(alu_o)
    );

    EXE_branch_comp exe_branch_comp (
        .bc_op (EXE_bc_op),
        .data_a(EXE_data_a),
        .data_b(EXE_data_b),
        .cond(CONTROLLER_bc_cond)
    );

    logic [`DM_MUX_WIDTH-1:0] MEM_dm_mux_ctr;
    logic [ADDR_WIDTH-1:0] MEM_pc_addr;
    logic MEM_dm_en, MEM_dm_wen, MEM_wb_en;
    logic [4:0] MEM_rd;

    logic [DATA_WIDTH-1:0] MEM_alu, MEM_data_b;

    REG_EXE_MEM reg_exe_mem (
        .clk(clk_10M),
        .rst(reset_btn),

        .stall(CONTROLLER_stall[3]),
        .bubble(CONTROLLER_bubble[2]),

        .rd_i(EXE_rd),
        .rd_o(MEM_rd),

        .pc_addr_i(EXE_pc_addr),
        .alu_out_i(alu_o),
        .dm_en_i(EXE_dm_en),
        .dm_wen_i(EXE_dm_wen),
        .dm_mux_ctr_i(EXE_dm_mux_ctr),
        .rf_data_b_i(EXE_data_b),

        .pc_addr_o(MEM_pc_addr),
        .alu_out_o(MEM_alu),
        .dm_en_o(MEM_dm_en),
        .dm_wen_o(MEM_dm_wen),
        .dm_mux_ctr_o(MEM_dm_mux_ctr),
        .rf_data_b_o(MEM_data_b),


        .wb_en_i(EXE_wb_en),
        .wb_en_o(MEM_wb_en)
    );

    logic [DATA_WIDTH-1:0] MEM_DM_data;
    logic [DATA_WIDTH-1:0] MEM_wb_data;

    // wishbone master for DM
    logic wbm_cyc_dm;
    logic wbm_stb_dm;
    logic wbm_ack_dm;
    logic [ADDR_WIDTH-1:0] wbm_adr_dm;
    logic [DATA_WIDTH-1:0] wbm_dat_m2s_dm;  // master 2 slave
    logic [DATA_WIDTH-1:0] wbm_dat_s2m_dm;  // slave 2 master
    logic [DATA_WIDTH/8-1:0] wbm_sel_dm; // todo: add support for this
    logic wbm_we_dm;

    MEM_dm data_fetcher (
        .clk (clk_50M),
        .rst (reset_btn),

        .dm_en(MEM_dm_en),
        .dm_wen(MEM_dm_wen),
        .dm_addr(MEM_alu),
        .dm_ack(CONTROLLER_dm_ack),
        .dm_data(MEM_DM_data),

        .wb_cyc_o(wbm_cyc_dm),
        .wb_stb_o(wbm_stb_dm),
        .wb_ack_i(wbm_ack_dm),
        .wb_adr_o(wbm_adr_dm),
        .wb_dat_o(wbm_dat_m2s_dm),
        .wb_dat_i(wbm_dat_s2m_dm),
        .wb_sel_o(wbm_sel_dm),
        .wb_we_o(wbm_we_dm)
    );

    MEM_dm_mux (
        .dm_mux_ctr (MEM_dm_mux_ctr),
        .dm_mux_pc_addr (MEM_pc_addr),
        .dm_mux_alu (MEM_alu),
        .dm_mux_dm(MEM_DM_data),
        .dm_mux_o(MEM_wb_data)
    );

    REG_MEM_WB (
        .clk(clk_10M),
        .rst(reset_btn),
        .bubble(CONTROLLER_bubble[3]),

        .wb_en_i(MEM_wb_en),
        .wb_addr_i(MEM_rd),
        .wb_data_i(MEM_wb_data),

        .wb_en_o(RF_wen),
        .wb_addr_o(RF_waddr),
        .wb_data_o(RF_wdata)
    );




endmodule
