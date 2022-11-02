`default_nettype none

module lab5_top (
    input wire clk_50M,     // 50MHz ʱ������
    input wire clk_11M0592, // 11.0592MHz ʱ�����루���ã��ɲ��ã�

    input wire push_btn,  // BTN5 ��ť���أ���������·������ʱΪ 1
    input wire reset_btn, // BTN6 ��λ��ť����������·������ʱΪ 1

    input  wire [ 3:0] touch_btn,  // BTN1~BTN4����ť���أ�����ʱΪ 1
    input  wire [31:0] dip_sw,     // 32 λ���뿪�أ�������ON��ʱΪ 1
    output wire [15:0] leds,       // 16 λ LED�����ʱ 1 ����
    output wire [ 7:0] dpy0,       // ����ܵ�λ�źţ�����С���㣬��� 1 ����
    output wire [ 7:0] dpy1,       // ����ܸ�λ�źţ�����С���㣬��� 1 ����

    // CPLD ���ڿ������ź�
    output wire uart_rdn,        // �������źţ�����Ч
    output wire uart_wrn,        // д�����źţ�����Ч
    input  wire uart_dataready,  // ��������׼����
    input  wire uart_tbre,       // �������ݱ�־
    input  wire uart_tsre,       // ���ݷ�����ϱ�־

    // BaseRAM �ź�
    inout wire [31:0] base_ram_data,  // BaseRAM ���ݣ��� 8 λ�� CPLD ���ڿ���������
    output wire [19:0] base_ram_addr,  // BaseRAM ��ַ
    output wire [3:0] base_ram_be_n,  // BaseRAM �ֽ�ʹ�ܣ�����Ч�������ʹ���ֽ�ʹ�ܣ��뱣��Ϊ 0
    output wire base_ram_ce_n,  // BaseRAM Ƭѡ������Ч
    output wire base_ram_oe_n,  // BaseRAM ��ʹ�ܣ�����Ч
    output wire base_ram_we_n,  // BaseRAM дʹ�ܣ�����Ч

    // ExtRAM �ź�
    inout wire [31:0] ext_ram_data,  // ExtRAM ����
    output wire [19:0] ext_ram_addr,  // ExtRAM ��ַ
    output wire [3:0] ext_ram_be_n,  // ExtRAM �ֽ�ʹ�ܣ�����Ч�������ʹ���ֽ�ʹ�ܣ��뱣��Ϊ 0
    output wire ext_ram_ce_n,  // ExtRAM Ƭѡ������Ч
    output wire ext_ram_oe_n,  // ExtRAM ��ʹ�ܣ�����Ч
    output wire ext_ram_we_n,  // ExtRAM дʹ�ܣ�����Ч

    // ֱ�������ź�
    output wire txd,  // ֱ�����ڷ��Ͷ�
    input  wire rxd,  // ֱ�����ڽ��ն�

    // Flash �洢���źţ��ο� JS28F640 оƬ�ֲ�
    output wire [22:0] flash_a,  // Flash ��ַ��a0 ���� 8bit ģʽ��Ч��16bit ģʽ������
    inout wire [15:0] flash_d,  // Flash ����
    output wire flash_rp_n,  // Flash ��λ�źţ�����Ч
    output wire flash_vpen,  // Flash д�����źţ��͵�ƽʱ���ܲ�������д
    output wire flash_ce_n,  // Flash Ƭѡ�źţ�����Ч
    output wire flash_oe_n,  // Flash ��ʹ���źţ�����Ч
    output wire flash_we_n,  // Flash дʹ���źţ�����Ч
    output wire flash_byte_n, // Flash 8bit ģʽѡ�񣬵���Ч����ʹ�� flash �� 16 λģʽʱ����Ϊ 1

    // USB �������źţ��ο� SL811 оƬ�ֲ�
    output wire sl811_a0,
    // inout  wire [7:0] sl811_d,     // USB ������������������� dm9k_sd[7:0] ����
    output wire sl811_wr_n,
    output wire sl811_rd_n,
    output wire sl811_cs_n,
    output wire sl811_rst_n,
    output wire sl811_dack_n,
    input  wire sl811_intrq,
    input  wire sl811_drq_n,

    // ����������źţ��ο� DM9000A оƬ�ֲ�
    output wire dm9k_cmd,
    inout wire [15:0] dm9k_sd,
    output wire dm9k_iow_n,
    output wire dm9k_ior_n,
    output wire dm9k_cs_n,
    output wire dm9k_pwrst_n,
    input wire dm9k_int,

    // ͼ������ź�
    output wire [2:0] video_red,    // ��ɫ���أ�3 λ
    output wire [2:0] video_green,  // ��ɫ���أ�3 λ
    output wire [1:0] video_blue,   // ��ɫ���أ�2 λ
    output wire       video_hsync,  // ��ͬ����ˮƽͬ�����ź�
    output wire       video_vsync,  // ��ͬ������ֱͬ�����ź�
    output wire       video_clk,    // ����ʱ�����
    output wire       video_de      // ��������Ч�źţ���������������
);

  /* =========== Demo code begin =========== */

  // PLL ��Ƶʾ��
  logic locked, clk_10M, clk_20M;
  pll_example clock_gen (
      // Clock in ports
      .clk_in1(clk_50M),  // �ⲿʱ������
      // Clock out ports
      .clk_out1(clk_10M),  // ʱ����� 1��Ƶ���� IP ���ý���������
      .clk_out2(clk_20M),  // ʱ����� 2��Ƶ���� IP ���ý���������
      // Status and control signals
      .reset(reset_btn),  // PLL ��λ����
      .locked(locked)  // PLL ����ָʾ�����"1"��ʾʱ���ȶ���
                       // �󼶵�·��λ�ź�Ӧ���������ɣ����£�
  );

  logic reset_of_clk10M;
  // �첽��λ��ͬ���ͷţ��� locked �ź�תΪ�󼶵�·�ĸ�λ reset_of_clk10M
  always_ff @(posedge clk_10M or negedge locked) begin
    if (~locked) reset_of_clk10M <= 1'b1;
    else reset_of_clk10M <= 1'b0;
  end

  /* =========== Demo code end =========== */

  logic sys_clk;
  logic sys_rst;

  assign sys_clk = clk_10M;
  assign sys_rst = reset_of_clk10M;

  // ��ʵ�鲻ʹ�� CPLD ���ڣ����÷�ֹ���߳�ͻ
  assign uart_rdn = 1'b1;
  assign uart_wrn = 1'b1;

  /* =========== Lab5 Master begin =========== */
  // Lab5 Master => Wishbone MUX (Slave)
  logic        wbm_cyc_o;
  logic        wbm_stb_o;
  logic        wbm_ack_i;
  logic [31:0] wbm_adr_o;
  logic [31:0] wbm_dat_o;
  logic [31:0] wbm_dat_i;
  logic [ 3:0] wbm_sel_o;
  logic        wbm_we_o;

  lab5_master #(
      .ADDR_WIDTH(32),
      .DATA_WIDTH(32)
  ) u_lab5_master (
      .clk_i(sys_clk),
      .rst_i(sys_rst),

      .addr_i(dip_sw),
      .leds_o(leds),

      // wishbone master
      .wb_cyc_o(wbm_cyc_o),
      .wb_stb_o(wbm_stb_o),
      .wb_ack_i(wbm_ack_i),
      .wb_adr_o(wbm_adr_o),
      .wb_dat_o(wbm_dat_o),
      .wb_dat_i(wbm_dat_i),
      .wb_sel_o(wbm_sel_o),
      .wb_we_o (wbm_we_o)
  );

  /* =========== Lab5 Master end =========== */

  /* =========== Lab5 MUX begin =========== */
  // Wishbone MUX (Masters) => bus slaves
  logic wbs0_cyc_o;
  logic wbs0_stb_o;
  logic wbs0_ack_i;
  logic [31:0] wbs0_adr_o;
  logic [31:0] wbs0_dat_o;
  logic [31:0] wbs0_dat_i;
  logic [3:0] wbs0_sel_o;
  logic wbs0_we_o;

  logic wbs1_cyc_o;
  logic wbs1_stb_o;
  logic wbs1_ack_i;
  logic [31:0] wbs1_adr_o;
  logic [31:0] wbs1_dat_o;
  logic [31:0] wbs1_dat_i;
  logic [3:0] wbs1_sel_o;
  logic wbs1_we_o;

  logic wbs2_cyc_o;
  logic wbs2_stb_o;
  logic wbs2_ack_i;
  logic [31:0] wbs2_adr_o;
  logic [31:0] wbs2_dat_o;
  logic [31:0] wbs2_dat_i;
  logic [3:0] wbs2_sel_o;
  logic wbs2_we_o;

  wb_mux_3 wb_mux (
      .clk(sys_clk),
      .rst(sys_rst),

      // Master interface (to Lab5 master)
      .wbm_adr_i(wbm_adr_o),
      .wbm_dat_i(wbm_dat_o),
      .wbm_dat_o(wbm_dat_i),
      .wbm_we_i (wbm_we_o),
      .wbm_sel_i(wbm_sel_o),
      .wbm_stb_i(wbm_stb_o),
      .wbm_ack_o(wbm_ack_i),
      .wbm_err_o(),
      .wbm_rty_o(),
      .wbm_cyc_i(wbm_cyc_o),

      // Slave interface 0 (to BaseRAM controller)
      // Address range: 0x8000_0000 ~ 0x803F_FFFF
      .wbs0_addr    (32'h8000_0000),
      .wbs0_addr_msk(32'hFFC0_0000),

      .wbs0_adr_o(wbs0_adr_o),
      .wbs0_dat_i(wbs0_dat_i),
      .wbs0_dat_o(wbs0_dat_o),
      .wbs0_we_o (wbs0_we_o),
      .wbs0_sel_o(wbs0_sel_o),
      .wbs0_stb_o(wbs0_stb_o),
      .wbs0_ack_i(wbs0_ack_i),
      .wbs0_err_i('0),
      .wbs0_rty_i('0),
      .wbs0_cyc_o(wbs0_cyc_o),

      // Slave interface 1 (to ExtRAM controller)
      // Address range: 0x8040_0000 ~ 0x807F_FFFF
      .wbs1_addr    (32'h8040_0000),
      .wbs1_addr_msk(32'hFFC0_0000),

      .wbs1_adr_o(wbs1_adr_o),
      .wbs1_dat_i(wbs1_dat_i),
      .wbs1_dat_o(wbs1_dat_o),
      .wbs1_we_o (wbs1_we_o),
      .wbs1_sel_o(wbs1_sel_o),
      .wbs1_stb_o(wbs1_stb_o),
      .wbs1_ack_i(wbs1_ack_i),
      .wbs1_err_i('0),
      .wbs1_rty_i('0),
      .wbs1_cyc_o(wbs1_cyc_o),

      // Slave interface 2 (to UART controller)
      // Address range: 0x1000_0000 ~ 0x1000_FFFF
      .wbs2_addr    (32'h1000_0000),
      .wbs2_addr_msk(32'hFFFF_0000),

      .wbs2_adr_o(wbs2_adr_o),
      .wbs2_dat_i(wbs2_dat_i),
      .wbs2_dat_o(wbs2_dat_o),
      .wbs2_we_o (wbs2_we_o),
      .wbs2_sel_o(wbs2_sel_o),
      .wbs2_stb_o(wbs2_stb_o),
      .wbs2_ack_i(wbs2_ack_i),
      .wbs2_err_i('0),
      .wbs2_rty_i('0),
      .wbs2_cyc_o(wbs2_cyc_o)
  );

  /* =========== Lab5 MUX end =========== */

  /* =========== Lab5 Slaves begin =========== */
  sram_controller #(
      .SRAM_ADDR_WIDTH(20),
      .SRAM_DATA_WIDTH(32)
  ) sram_controller_base (
      .clk_i(sys_clk),
      .rst_i(sys_rst),

      // Wishbone slave (to MUX)
      .wb_cyc_i(wbs0_cyc_o),
      .wb_stb_i(wbs0_stb_o),
      .wb_ack_o(wbs0_ack_i),
      .wb_adr_i(wbs0_adr_o),
      .wb_dat_i(wbs0_dat_o),
      .wb_dat_o(wbs0_dat_i),
      .wb_sel_i(wbs0_sel_o),
      .wb_we_i (wbs0_we_o),

      // To SRAM chip
      .sram_addr(base_ram_addr),
      .sram_data(base_ram_data),
      .sram_ce_n(base_ram_ce_n),
      .sram_oe_n(base_ram_oe_n),
      .sram_we_n(base_ram_we_n),
      .sram_be_n(base_ram_be_n)
  );

  sram_controller #(
      .SRAM_ADDR_WIDTH(20),
      .SRAM_DATA_WIDTH(32)
  ) sram_controller_ext (
      .clk_i(sys_clk),
      .rst_i(sys_rst),

      // Wishbone slave (to MUX)
      .wb_cyc_i(wbs1_cyc_o),
      .wb_stb_i(wbs1_stb_o),
      .wb_ack_o(wbs1_ack_i),
      .wb_adr_i(wbs1_adr_o),
      .wb_dat_i(wbs1_dat_o),
      .wb_dat_o(wbs1_dat_i),
      .wb_sel_i(wbs1_sel_o),
      .wb_we_i (wbs1_we_o),

      // To SRAM chip
      .sram_addr(ext_ram_addr),
      .sram_data(ext_ram_data),
      .sram_ce_n(ext_ram_ce_n),
      .sram_oe_n(ext_ram_oe_n),
      .sram_we_n(ext_ram_we_n),
      .sram_be_n(ext_ram_be_n)
  );

  // ���ڿ�����ģ��
  // NOTE: ����޸�ϵͳʱ��Ƶ�ʣ�Ҳ��Ҫ�޸Ĵ˴���ʱ��Ƶ�ʲ���
  uart_controller #(
      .CLK_FREQ(10_000_000),
      .BAUD    (115200)
  ) uart_controller (
      .clk_i(sys_clk),
      .rst_i(sys_rst),

      .wb_cyc_i(wbs2_cyc_o),
      .wb_stb_i(wbs2_stb_o),
      .wb_ack_o(wbs2_ack_i),
      .wb_adr_i(wbs2_adr_o),
      .wb_dat_i(wbs2_dat_o),
      .wb_dat_o(wbs2_dat_i),
      .wb_sel_i(wbs2_sel_o),
      .wb_we_i (wbs2_we_o),

      // to UART pins
      .uart_txd_o(txd),
      .uart_rxd_i(rxd)
  );

  /* =========== Lab5 Slaves end =========== */

endmodule
