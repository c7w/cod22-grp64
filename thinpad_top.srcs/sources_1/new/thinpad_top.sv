`default_nettype none
`include "exception.svh"
`include "ctrl.vh"
`include "branch_comp.vh"

module thinpad_top #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk_50M,     // 50MHz 时钟输入
    input wire clk_11M0592, // 11.0592MHz 时钟输入（备用，可不用）

    input wire push_btn,  // BTN5 按钮�?????????关，带消抖电路，按下时为 1
    input wire reset_btn, // BTN6 复位按钮，带消抖电路，按下时�????????? 1

    input  wire [ 3:0] touch_btn,  // BTN1~BTN4，按钮开关，按下时为 1
    input  wire [31:0] dip_sw,     // 32 位拨码开关，拨到“ON”时�????????? 1
    output wire [15:0] leds,       // 16 �????????? LED，输出时 1 点亮
    output wire [ 7:0] dpy0,       // 数码管低位信号，包括小数点，输出 1 点亮
    output wire [ 7:0] dpy1,       // 数码管高位信号，包括小数点，输出 1 点亮

    // CPLD 串口控制器信�?????????
    output wire uart_rdn,        // 读串口信号，低有�?????????
    output wire uart_wrn,        // 写串口信号，低有�?????????
    input  wire uart_dataready,  // 串口数据准备�?????????
    input  wire uart_tbre,       // 发�?�数据标�?????????
    input  wire uart_tsre,       // 数据发�?�完毕标�?????????

    // BaseRAM 信号
    inout wire [31:0] base_ram_data,  // BaseRAM 数据，低 8 位与 CPLD 串口控制器共�?????????
    output wire [19:0] base_ram_addr,  // BaseRAM 地址
    output wire [3:0] base_ram_be_n,  // BaseRAM 字节使能，低有效。如果不使用字节使能，请保持�????????? 0
    output wire base_ram_ce_n,  // BaseRAM 片�?�，低有�?????????
    output wire base_ram_oe_n,  // BaseRAM 读使能，低有�?????????
    output wire base_ram_we_n,  // BaseRAM 写使能，低有�?????????

    // ExtRAM 信号
    inout wire [31:0] ext_ram_data,  // ExtRAM 数据
    output wire [19:0] ext_ram_addr,  // ExtRAM 地址
    output wire [3:0] ext_ram_be_n,  // ExtRAM 字节使能，低有效。如果不使用字节使能，请保持�????????? 0
    output wire ext_ram_ce_n,  // ExtRAM 片�?�，低有�?????????
    output wire ext_ram_oe_n,  // ExtRAM 读使能，低有�?????????
    output wire ext_ram_we_n,  // ExtRAM 写使能，低有�?????????

    // 直连串口信号
    output wire txd,  // 直连串口发�?�端
    input  wire rxd,  // 直连串口接收�?????????

    // Flash 存储器信号，参�?? JS28F640 芯片手册
    output wire [22:0] flash_a,  // Flash 地址，a0 仅在 8bit 模式有效�?????????16bit 模式无意�?????????
    inout wire [15:0] flash_d,  // Flash 数据
    output wire flash_rp_n,  // Flash 复位信号，低有效
    output wire flash_vpen,  // Flash 写保护信号，低电平时不能擦除、烧�?????????
    output wire flash_ce_n,  // Flash 片�?�信号，低有�?????????
    output wire flash_oe_n,  // Flash 读使能信号，低有�?????????
    output wire flash_we_n,  // Flash 写使能信号，低有�?????????
    output wire flash_byte_n, // Flash 8bit 模式选择，低有效。在使用 flash �????????? 16 位模式时请设�????????? 1

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
    output wire [2:0] video_red,    // 红色像素�?????????3 �?????????
    output wire [2:0] video_green,  // 绿色像素�?????????3 �?????????
    output wire [1:0] video_blue,   // 蓝色像素�?????????2 �?????????
    output wire       video_hsync,  // 行同步（水平同步）信�?????????
    output wire       video_vsync,  // 场同步（垂直同步）信�?????????
    output wire       video_clk,    // 像素时钟输出
    output wire       video_de      // 行数据有效信号，用于区分消隐�?????????
);

  /* =========== Demo code begin =========== */

    // PLL 分频示例
    logic locked, clk_10M, clk_20M, clk_30M, clk_40M;
    logic clk_48M;

    pll_example clock_gen (
        // Clock in ports
        .clk_in1(clk_50M),  // 外部时钟输入
        // Clock out ports
        .clk_out1(clk_10M),  // 时钟输出 1，频率在 IP 配置界面中设�?????????
        .clk_out2(clk_20M),  // 时钟输出 2，频率在 IP 配置界面中设�?????????
        .clk_out3(clk_30M),
        .clk_out4(clk_40M),
        // Status and control signals
        .reset(reset_btn),  // PLL 复位输入
        .locked(locked)  // PLL 锁定指示输出�?????????"1"表示时钟稳定�?????????
                        // 后级电路复位信号应当由它生成（见下）
    );



    wire sys_clk, sys_rst;

    logic reset_of_sys_clk;
    always_ff @(posedge sys_clk or negedge locked) begin
        if (~locked) reset_of_sys_clk <= 1'b1;
        else reset_of_sys_clk <= 1'b0;
    end

    assign sys_rst = reset_of_sys_clk;


    assign uart_rdn = 1'b1;
    assign uart_wrn = 1'b1;

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

  // // 7 段数码管译码器演示，�????????? number �????????? 16 进制显示在数码管上面
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
  //   if (reset_btn) begin  // 复位按下，设�????????? LED 为初始�??
  //     led_bits <= 16'h1;
  //   end else begin  // 每次按下按钮�?????????关，LED 循环左移
  //     led_bits <= {led_bits[14:0], led_bits[15]};
  //   end
  // end

  // // 直连串口接收发�?�演示，从直连串口收到的数据再发送出�?????????
  // logic [7:0] ext_uart_rx;
  // logic [7:0] ext_uart_buffer, ext_uart_tx;
  // logic ext_uart_ready, ext_uart_clear, ext_uart_busy;
  // logic ext_uart_start, ext_uart_avai;

  // assign number = ext_uart_buffer;

  // // 接收模块�?????????9600 无检验位
  // async_receiver #(
  //     .ClkFrequency(50000000),
  //     .Baud(9600)
  // ) ext_uart_r (
  //     .clk           (clk_50M),         // 外部时钟信号
  //     .RxD           (rxd),             // 外部串行信号输入
  //     .RxD_data_ready(ext_uart_ready),  // 数据接收到标�?????????
  //     .RxD_clear     (ext_uart_clear),  // 清除接收标志
  //     .RxD_data      (ext_uart_rx)      // 接收到的�?????????字节数据
  // );

  // assign ext_uart_clear = ext_uart_ready; // 收到数据的同时，清除标志，因为数据已取到 ext_uart_buffer �?????????
  // always_ff @(posedge clk_50M) begin  // 接收到缓冲区 ext_uart_buffer
  //   if (ext_uart_ready) begin
  //     ext_uart_buffer <= ext_uart_rx;
  //     ext_uart_avai   <= 1;
  //   end else if (!ext_uart_busy && ext_uart_avai) begin
  //     ext_uart_avai <= 0;
  //   end
  // end
  // always_ff @(posedge clk_50M) begin  // 将缓冲区 ext_uart_buffer 发�?�出�?????????
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
  //     .TxD_busy (ext_uart_busy),   // 发�?�器忙状态指�?????????
  //     .TxD_start(ext_uart_start),  // �?????????始发送信�?????????
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
  //     .hdata      (hdata),        // 横坐�?????????
  //     .vdata      (),             // 纵坐�?????????
  //     .hsync      (video_hsync),
  //     .vsync      (video_vsync),
  //     .data_enable(video_de)
  // );
  // /* =========== Demo code end =========== */


    // Exception
    priviledge_mode_t CONTROLLER_priviledge_mode_reg;
    mtvec_t CONTROLLER_mtvec_reg;
    mscratch_t CONTROLLER_mscratch_reg;
    mepc_t CONTROLLER_mepc_reg;
    mcause_t CONTROLLER_mcause_reg;
    mstatus_t CONTROLLER_mstatus_reg;
    mie_t CONTROLLER_mie_reg;
    mip_t CONTROLLER_mip_reg;
    mtval_t CONTROLLER_mtval_reg;
    mideleg_t CONTROLLER_mideleg_reg;
    medeleg_t CONTROLLER_medeleg_reg;
    satp_t CONTROLLER_satp_reg;
    sepc_t CONTROLLER_sepc_reg;
    scause_t CONTROLLER_scause_reg;
    stval_t CONTROLLER_stval_reg;
    stvec_t CONTROLLER_stvec_reg;
    sscratch_t CONTROLLER_sscratch_reg;

    priviledge_mode_t CONTROLLER_priviledge_mode_bypassing;
    mtvec_t CONTROLLER_mtvec_bypassing;
    mscratch_t CONTROLLER_mscratch_bypassing;
    mepc_t CONTROLLER_mepc_bypassing;
    mcause_t CONTROLLER_mcause_bypassing;
    mstatus_t CONTROLLER_mstatus_bypassing;
    mie_t CONTROLLER_mie_bypassing;
    mip_t CONTROLLER_mip_bypassing;
    mtval_t CONTROLLER_mtval_bypassing;
    mideleg_t CONTROLLER_mideleg_bypassing;
    medeleg_t CONTROLLER_medeleg_bypassing;
    satp_t CONTROLLER_satp_bypassing;
    sepc_t CONTROLLER_sepc_bypassing;
    scause_t CONTROLLER_scause_bypassing;
    stval_t CONTROLLER_stval_bypassing;
    stvec_t CONTROLLER_stvec_bypassing;
    sscratch_t CONTROLLER_sscratch_bypassing;

    priviledge_mode_t CONTROLLER_priviledge_mode_data_write;
    mtvec_t CONTROLLER_mtvec_data_write;
    mscratch_t CONTROLLER_mscratch_data_write;
    mepc_t CONTROLLER_mepc_data_write;
    mcause_t CONTROLLER_mcause_data_write;
    mstatus_t CONTROLLER_mstatus_data_write;
    mie_t CONTROLLER_mie_data_write;
    mip_t CONTROLLER_mip_data_write;
    mtval_t CONTROLLER_mtval_data_write;
    mideleg_t CONTROLLER_mideleg_data_write;
    medeleg_t CONTROLLER_medeleg_data_write;
    satp_t CONTROLLER_satp_data_write;
    sepc_t CONTROLLER_sepc_data_write;
    scause_t CONTROLLER_scause_data_write;
    stval_t CONTROLLER_stval_data_write;
    stvec_t CONTROLLER_stvec_data_write;
    sscratch_t CONTROLLER_sscratch_data_write;

    logic CONTROLLER_priviledge_mode_wen;
    logic CONTROLLER_mtvec_wen;
    logic CONTROLLER_mscratch_wen;
    logic CONTROLLER_mepc_wen;
    logic CONTROLLER_mcause_wen;
    logic CONTROLLER_mstatus_wen;
    logic CONTROLLER_mie_wen;
    logic CONTROLLER_mip_wen;
    logic CONTROLLER_mtval_wen;
    logic CONTROLLER_mideleg_wen;
    logic CONTROLLER_medeleg_wen;
    logic CONTROLLER_satp_wen;
    logic CONTROLLER_sepc_wen;
    logic CONTROLLER_scause_wen;
    logic CONTROLLER_stval_wen;
    logic CONTROLLER_stvec_wen;
    logic CONTROLLER_sscratch_wen;

    logic CONTROLLER_interrupt_timer;

    logic [1:0] CONTROLLER_exception;

    CONTROLLER_csrs controller_csrs (
        .clk (sys_clk),
        .rst (sys_rst),

        .priviledge_mode_wen(CONTROLLER_priviledge_mode_wen),
        .mtvec_wen(CONTROLLER_mtvec_wen),
        .mscratch_wen(CONTROLLER_mscratch_wen),
        .mepc_wen(CONTROLLER_mepc_wen),
        .mcause_wen(CONTROLLER_mcause_wen),
        .mstatus_wen(CONTROLLER_mstatus_wen),
        .mie_wen(CONTROLLER_mie_wen),
        .mip_wen(CONTROLLER_mip_wen),
        .mtval_wen(CONTROLLER_mtval_wen),
        .mideleg_wen(CONTROLLER_mideleg_wen),
        .medeleg_wen(CONTROLLER_medeleg_wen),
        .satp_wen(CONTROLLER_satp_wen),
        .sepc_wen(CONTROLLER_sepc_wen),
        .scause_wen(CONTROLLER_scause_wen),
        .stval_wen(CONTROLLER_stval_wen),
        .stvec_wen(CONTROLLER_stvec_wen),
        .sscratch_wen(CONTROLLER_sscratch_wen),

        .priviledge_mode_i(CONTROLLER_priviledge_mode_data_write),
        .mtvec_i(CONTROLLER_mtvec_data_write),
        .mscratch_i(CONTROLLER_mscratch_data_write),
        .mepc_i(CONTROLLER_mepc_data_write),
        .mcause_i(CONTROLLER_mcause_data_write),
        .mstatus_i(CONTROLLER_mstatus_data_write),
        .mie_i(CONTROLLER_mie_data_write),
        .mip_i(CONTROLLER_mip_data_write),
        .mtval_i(CONTROLLER_mtval_data_write),
        .mideleg_i(CONTROLLER_mideleg_data_write),
        .medeleg_i(CONTROLLER_medeleg_data_write),
        .satp_i(CONTROLLER_satp_data_write),
        .sepc_i(CONTROLLER_sepc_data_write),
        .scause_i(CONTROLLER_scause_data_write),
        .stval_i(CONTROLLER_stval_data_write),
        .stvec_i(CONTROLLER_stvec_data_write),
        .sscratch_i(CONTROLLER_sscratch_data_write),

        .priviledge_mode_o(CONTROLLER_priviledge_mode_bypassing),
        .mtvec_o(CONTROLLER_mtvec_bypassing),
        .mscratch_o(CONTROLLER_mscratch_bypassing),
        .mepc_o(CONTROLLER_mepc_bypassing),
        .mcause_o(CONTROLLER_mcause_bypassing),
        .mstatus_o(CONTROLLER_mstatus_bypassing),
        .mie_o(CONTROLLER_mie_bypassing),
        .mip_o(CONTROLLER_mip_bypassing),
        .mtval_o(CONTROLLER_mtval_bypassing),
        .mideleg_o(CONTROLLER_mideleg_bypassing),
        .medeleg_o(CONTROLLER_medeleg_bypassing),
        .satp_o(CONTROLLER_satp_bypassing),
        .sepc_o(CONTROLLER_sepc_bypassing),
        .scause_o(CONTROLLER_scause_bypassing),
        .stval_o(CONTROLLER_stval_bypassing),
        .stvec_o(CONTROLLER_stvec_bypassing),
        .sscratch_o(CONTROLLER_sscratch_bypassing),

        .priviledge_mode_reg(CONTROLLER_priviledge_mode_reg),
        .mtvec_reg(CONTROLLER_mtvec_reg),
        .mscratch_reg(CONTROLLER_mscratch_reg),
        .mepc_reg(CONTROLLER_mepc_reg),
        .mcause_reg(CONTROLLER_mcause_reg),
        .mstatus_reg(CONTROLLER_mstatus_reg),
        .mie_reg(CONTROLLER_mie_reg),
        .mip_reg(CONTROLLER_mip_reg),
        .mtval_reg(CONTROLLER_mtval_reg),
        .mideleg_reg(CONTROLLER_mideleg_reg),
        .medeleg_reg(CONTROLLER_medeleg_reg),
        .satp_reg(CONTROLLER_satp_reg),
        .sepc_reg(CONTROLLER_sepc_reg),
        .scause_reg(CONTROLLER_scause_reg),
        .stval_reg(CONTROLLER_stval_reg),
        .stvec_reg(CONTROLLER_stvec_reg),
        .sscratch_reg(CONTROLLER_sscratch_reg),
        
        // From timer
        .time_interrupt(CONTROLLER_interrupt_timer)
    );

    // Controller
    logic [3:0] CONTROLLER_stall;
    logic [3:0] CONTROLLER_bubble;
    logic CONTROLLER_branching;
    logic [ADDR_WIDTH-1:0] CONTROLLER_branching_addr;
    logic CONTROLLER_bc_cond;
    logic CONTROLLER_im_ack, CONTROLLER_dm_ack;
    logic CONTROLLER_data_hazard;
    logic [3:0] CONTROLLER_csr_transfer_state;
    logic [ADDR_WIDTH-1:0] pc_nxt_exception;

    CONTROLLER_pipeline CONTROLLER_pipeline (
        .im_ack(CONTROLLER_im_ack),
        .dm_ack(CONTROLLER_dm_ack),
        .dm_exception(MEM_query_exception),
        
        .data_hazard(CONTROLLER_data_hazard),
        .ID_rs1(ID_rs1),
        .ID_rs2(ID_rs2),
        .EXE_rd(EXE_rd),
        .EXE_wb_en(EXE_wb_en),
        .DM_rd(MEM_rd),
        .DM_wb_en(MEM_wb_en),
        .WB_rd(RF_waddr),
        .WB_wb_en(RF_wen),

        .pc_nxt_exception(pc_nxt_exception),
        .CONTROLLER_csr_transfer_state(CONTROLLER_csr_transfer_state),
        .bc_comp_result(CONTROLLER_bc_cond),
        .EXE_pc_addr(EXE_pc_addr),
        .EXE_pc_mux_ctr(EXE_pc_mux_ctr),
        .EXE_pc_addr_calculated(alu_o_branch),
        .ID_pc_addr(ID_pc_addr),
        .IF_pc_addr(IF_pc_addr),
        
        .IF_drain_pipeline(IF_drain_pipeline),
        .ID_drain_pipeline(ID_drain_pipeline),
        .EXE_drain_pipeline(EXE_drain_pipeline),
        .MEM_drain_pipeline(MEM_drain_pipeline),
        .WB_drain_pipeline(WB_drain_pipeline),

        .branching(CONTROLLER_branching),
        .pc_addr_right(CONTROLLER_branching_addr),
        .stall_o(CONTROLLER_stall),
        .bubble_o(CONTROLLER_bubble),

        .CONTROLLER_exception(CONTROLLER_exception)
    );

    // IF

    logic [ADDR_WIDTH-1:0] IF_pc_addr;
    logic [ADDR_WIDTH-1:0] IF_pc_nxt, IF_pc_next_prediction;
    logic [DATA_WIDTH-1:0] IF_instr;
    logic [DATA_WIDTH-1:0] IF_imm;
    logic IF_imm_en;
    logic [4:0] IF_rs1, IF_rs2, IF_rd;
    
    logic [`CSR_OP_WIDTH-1:0] IF_csr_opcode;
    logic [`CSR_ADDR_WIDTH-1:0] IF_csr_addr;

    logic [`PC_MUX_WIDTH-1:0] IF_pc_mux_ctr;
    logic [`BC_OP_WIDTH-1:0] IF_BC_op;
    logic [`ALU_OP_WIDTH-1:0] IF_ALU_op;
    logic [`ALU_MUX_A_WIDTH-1:0] IF_ALU_mux_a_ctr;
    logic [`ALU_MUX_B_WIDTH-1:0] IF_ALU_mux_b_ctr;
    logic [`DM_MUX_WIDTH-1:0] IF_dm_mux_ctr;
    logic IF_dm_en, IF_dm_wen, IF_wb_en;
    logic IF_tlb_flush, IF_drain_pipeline, IF_fence_i;
    logic [2:0] IF_dm_width; 
    logic IF_dm_sign_ext;


    IF_pc pc (
        .clk (sys_clk),
        .rst (sys_rst),
        .stall(CONTROLLER_stall[3]),
        .pc_nxt(IF_pc_nxt),  // PC mux -> PC
        .pc_addr(IF_pc_addr)  // PC -> instr fetcher
    );

    IF_BTB if_btb (
        .clk(sys_clk),
        .rst(sys_rst),

        .curr_pc_addr(IF_pc_addr),
        .predicted_pc_addr(IF_pc_next_prediction),

        .exe_pc_addr(EXE_pc_addr),
        .target_pc_addr(CONTROLLER_branching_addr),
        .branching(CONTROLLER_branching)
    );

    IF_pc_mux pc_mux (
        .branching(CONTROLLER_branching),
        .pc_predicted(IF_pc_next_prediction),
        .branch_addr(CONTROLLER_branching_addr),
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

    logic IF_query_exception;
    logic [`MXLEN-2:0] IF_query_exception_code;
    logic IF_illegal_instruction;
    logic [DATA_WIDTH-1:0] IF_query_exception_val;

    // IF_im instr_fetcher (
    //     .clk(sys_clk),
    //     .rst(sys_rst),

    //     .pc_addr(IF_pc_addr),
    //     .branching(CONTROLLER_branching),
    //     .instr(IF_instr),
    //     .im_ack(CONTROLLER_im_ack),

    //     .wb_cyc_o(wbm_cyc_im),
    //     .wb_stb_o(wbm_stb_im),
    //     .wb_ack_i(wbm_ack_im),
    //     .wb_adr_o(wbm_adr_im),
    //     .wb_dat_o(wbm_dat_m2s_im),
    //     .wb_dat_i(wbm_dat_s2m_im),
    //     .wb_sel_o(wbm_sel_im),
    //     .wb_we_o(wbm_we_im)
    // );
    logic WB_tlb_flush;
    logic WB_fence_i;
    IF_MMU instr_fetcher (
        .clk(sys_clk),
        .rst(sys_rst),

        .mstatus_i(CONTROLLER_mstatus_bypassing),
        .priviledge_mode_i(CONTROLLER_priviledge_mode_bypassing),
        .satp_i(CONTROLLER_satp_bypassing),
        .tlb_flush(WB_tlb_flush),
        .fence_i(WB_fence_i),
        
        .pc_addr(IF_pc_addr),
        .branching(CONTROLLER_branching),
        .instr(IF_instr),
        .im_ack(CONTROLLER_im_ack),

        .query_exception(IF_query_exception),
        .query_exception_code(IF_query_exception_code),
        .query_exception_val(IF_query_exception_val), 

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
    logic ID_imm_en;
    logic [4:0] ID_rs1, ID_rs2, ID_rd;
    logic [`CSR_OP_WIDTH-1:0] ID_csr_opcode;
    logic [`CSR_ADDR_WIDTH-1:0] ID_csr_addr;
    logic [DATA_WIDTH-1:0] ID_csr_data;
    logic [`PC_MUX_WIDTH-1:0] ID_pc_mux_ctr;
    logic [`BC_OP_WIDTH-1:0] ID_BC_op;
    logic [`ALU_OP_WIDTH-1:0] ID_ALU_op;
    logic [`ALU_MUX_A_WIDTH-1:0] ID_ALU_mux_a_ctr;
    logic [`ALU_MUX_B_WIDTH-1:0] ID_ALU_mux_b_ctr;
    logic [`DM_MUX_WIDTH-1:0] ID_dm_mux_ctr;
    logic ID_dm_en, ID_dm_wen, ID_wb_en;
    logic ID_tlb_flush, ID_drain_pipeline, ID_fence_i;
    logic [2:0] ID_dm_width; 
    logic ID_dm_sign_ext;
    logic [DATA_WIDTH-1:0] ID_instr;

    logic ID_query_exception;
    logic [`MXLEN-2:0] ID_query_exception_code;
    logic ID_illegal_instruction;
    logic [DATA_WIDTH-1:0] ID_query_exception_val;

    IF_decoder instr_decoder(
        .instr(IF_instr),

        .imm(IF_imm),
        .imm_en(IF_imm_en),


        .tlb_flush(IF_tlb_flush),
        .drain_pipeline(IF_drain_pipeline),
        .fence_i(IF_fence_i),
        .illegal_instruction(IF_illegal_instruction),

        .dm_en(IF_dm_en),
        .dm_wen(IF_dm_wen),
        .dm_width(IF_dm_width),
        .dm_sign_ext(IF_dm_sign_ext),
        .wb_en(IF_wb_en),
        .rd(IF_rd),
        .rs1(IF_rs1),
        .rs2(IF_rs2),
        
        .csr_opcode(IF_csr_opcode),
        .csr_addr(IF_csr_addr),
        
        .pc_mux_ctr(IF_pc_mux_ctr),
        .bc_op(IF_BC_op),
        .alu_op(IF_ALU_op),
        .alu_mux_a_ctr(IF_ALU_mux_a_ctr),
        .alu_mux_b_ctr(IF_ALU_mux_b_ctr),
        .dm_mux_ctr(IF_dm_mux_ctr)
    );

    REG_IF_ID reg_if_id (
        .clk(sys_clk),
        .rst(sys_rst),
        .stall(CONTROLLER_stall[2]),
        .bubble(CONTROLLER_bubble[3]),

        // IF -> ID
        .rs1_i(IF_rs1),
        .rs2_i(IF_rs2),
        .rd_i(IF_rd),
        .imm_i(IF_imm),
        .imm_en_i(IF_imm_en),
        

        .rs1_o(ID_rs1),
        .rs2_o(ID_rs2),
        .rd_o(ID_rd),
        .imm_o(ID_imm),
        .imm_en_o(ID_imm_en),

        // ID -> EXE
        .csr_addr_i(IF_csr_addr),
        .csr_opcode_i(IF_csr_opcode),
        .bc_op_i(IF_BC_op),
        .alu_op_i(IF_ALU_op),
        .alu_mux_a_ctr_i(IF_ALU_mux_a_ctr),
        .alu_mux_b_ctr_i(IF_ALU_mux_b_ctr),
        .pc_mux_ctr_i(IF_pc_mux_ctr),

        .instr_i(IF_instr),
        .query_exception_i(IF_query_exception),
        .query_exception_code_i(IF_query_exception_code),
        .illegal_instruction_i(IF_illegal_instruction),
        .query_exception_val_i(IF_query_exception_val),

        .csr_addr_o(ID_csr_addr),
        .csr_opcode_o(ID_csr_opcode),
        .bc_op_o(ID_BC_op),
        .alu_op_o(ID_ALU_op),
        .alu_mux_a_ctr_o(ID_ALU_mux_a_ctr),
        .alu_mux_b_ctr_o(ID_ALU_mux_b_ctr),
        .pc_mux_ctr_o(ID_pc_mux_ctr),

        .instr_o(ID_instr),
        .query_exception_o(ID_query_exception),
        .query_exception_code_o(ID_query_exception_code),
        .illegal_instruction_o(ID_illegal_instruction),
        .query_exception_val_o(ID_query_exception_val),


        // EXE -> MEM
        .pc_addr_i(IF_pc_addr),
        .dm_en_i(IF_dm_en),
        .dm_wen_i(IF_dm_wen),
        .dm_width_i(IF_dm_width),
        .dm_sign_ext_i(IF_dm_sign_ext),
        .dm_mux_ctr_i(IF_dm_mux_ctr),
        .tlb_flush_i(IF_tlb_flush),
        .drain_pipeline_i(IF_drain_pipeline),
        .fence_i_i(IF_fence_i),
        
        .pc_addr_o(ID_pc_addr),
        .dm_en_o(ID_dm_en),
        .dm_wen_o(ID_dm_wen),
        .dm_width_o(ID_dm_width),
        .dm_sign_ext_o(ID_dm_sign_ext),
        .dm_mux_ctr_o(ID_dm_mux_ctr),
        .tlb_flush_o(ID_tlb_flush),
        .drain_pipeline_o(ID_drain_pipeline),
        .fence_i_o(ID_fence_i),

        // MEM -> WB
        .wb_en_i(IF_wb_en),
        .wb_en_o(ID_wb_en)
    );

    logic [4:0] RF_rs1, RF_rs2;
    logic [4:0] RF_waddr;
    logic [DATA_WIDTH-1:0] RF_wdata;
    logic RF_wen;
    logic [DATA_WIDTH-1:0] ID_data_a, ID_data_b;
    logic [DATA_WIDTH-1:0] RF_data_a, RF_data_b;

    RegisterFile rf (
        .clk(sys_clk),
        .rst(sys_rst),

        .waddr(RF_waddr),
        .wdata(RF_wdata),
        .wen(RF_wen),

        .raddr_a(RF_rs1),
        .raddr_b(RF_rs2),

        .rdata_a(RF_data_a),
        .rdata_b(RF_data_b)
    );


    CONTROLLER_bypassing_unit controller_bypassing_unit (
        // IF_ID -> Bypassing Unit
        .req_rs1(ID_rs1),
        .req_rs2(ID_rs2),

        // Bypassing Unit -> ID_EXE
        .req_data1(ID_data_a),
        .req_data2(ID_data_b),

        // Bypassing Unit -> RF
        .rf_rs1(RF_rs1),
        .rf_rs2(RF_rs2),

        // RF -> Bypassing Unit
        .rf_data1(RF_data_a),
        .rf_data2(RF_data_b),

        // Bypassing Unit -> Controller
        .data_hazard(CONTROLLER_data_hazard),

        // EXE Stage -> Bypassing Unit
        .exe_dm_mux(EXE_dm_mux_ctr),
        .exe_wb_en(EXE_wb_en),
        .exe_rd(EXE_rd),
        .exe_bypassing_data_pc_addr(EXE_pc_addr),
        .exe_bypassing_data_alu(alu_o),

        // MEM Stage -> Bypassing Unit
        .mem_dm_mux(MEM_dm_mux_ctr),
        .mem_wb_en(MEM_wb_en),
        .mem_rd(MEM_rd),
        .mem_bypassing_data_pc_addr(MEM_pc_addr),
        .mem_bypassing_data_alu(MEM_alu),
        .mem_bypassing_data_dm(MEM_DM_data),
        .mem_bypassing_data_dm_valid(CONTROLLER_dm_ack),

        // WB Stage -> Bypassing Unit
        .wb_wb_en(RF_wen),
        .wb_rd(RF_waddr),
        .wb_bypassing_data(RF_wdata)
    );

    logic [DATA_WIDTH-1:0] EXE_data_a, EXE_data_b, EXE_imm;
    logic [`CSR_OP_WIDTH-1:0] EXE_csr_opcode;
    logic [`CSR_ADDR_WIDTH-1:0] EXE_csr_addr;
    logic [DATA_WIDTH-1:0] csr_transfer_data;
    logic EXE_imm_en;
    logic [`BC_OP_WIDTH-1:0] EXE_bc_op;
    logic [`ALU_OP_WIDTH-1:0] EXE_ALU_op;
    logic [`ALU_MUX_A_WIDTH-1:0] EXE_ALU_mux_a_ctr;
    logic [`ALU_MUX_B_WIDTH-1:0] EXE_ALU_mux_b_ctr;
    logic [`DM_MUX_WIDTH-1:0] EXE_dm_mux_ctr;
    logic [`PC_MUX_WIDTH-1:0] EXE_pc_mux_ctr;
    logic [ADDR_WIDTH-1:0] EXE_pc_addr;
    logic EXE_dm_en, EXE_dm_wen, EXE_wb_en;
    logic EXE_tlb_flush, EXE_drain_pipeline, EXE_fence_i;
    logic [2:0] EXE_dm_width; 
    logic EXE_dm_sign_ext;
    logic [4:0] EXE_rd;

    logic EXE_query_exception;
    logic [`MXLEN-2:0] EXE_query_exception_code;
    logic [DATA_WIDTH-1:0] EXE_query_exception_val;

    logic MEM_query_exception;
    logic [`MXLEN-2:0] MEM_query_exception_code;
    logic [DATA_WIDTH-1:0] MEM_query_exception_val;

    REG_ID_EXE reg_id_exe (
        .clk(sys_clk),
        .rst(sys_rst),

        .stall(CONTROLLER_stall[1]),
        .bubble(CONTROLLER_bubble[2]),

        .imm_i(ID_imm),
        .imm_en_i(ID_imm_en),
        .rd_i(ID_rd),
        .imm_o(EXE_imm),
        .imm_en_o(EXE_imm_en),
        .rd_o(EXE_rd),

        .csr_addr_i(ID_csr_addr),
        .csr_opcode_i(ID_csr_opcode),
        .rf_data_a_i(ID_data_a),
        .bc_op_i(ID_BC_op),
        .alu_op_i(ID_ALU_op),
        .alu_mux_a_ctr_i(ID_ALU_mux_a_ctr),
        .alu_mux_b_ctr_i(ID_ALU_mux_b_ctr),
        .pc_mux_ctr_i(ID_pc_mux_ctr),

        .instr_i(ID_instr),
        .query_exception_i(ID_query_exception),
        .query_exception_code_i(ID_query_exception_code),
        .illegal_instruction_i(ID_illegal_instruction),
        .query_exception_val_i(ID_query_exception_val),

        .csr_addr_o(EXE_csr_addr),
        .csr_opcode_o(EXE_csr_opcode),
        .rf_data_a_o(EXE_data_a),
        .bc_op_o(EXE_bc_op),
        .alu_op_o(EXE_ALU_op),
        .alu_mux_a_ctr_o(EXE_ALU_mux_a_ctr),
        .alu_mux_b_ctr_o(EXE_ALU_mux_b_ctr),
        .pc_mux_ctr_o(EXE_pc_mux_ctr),

        .query_exception_o(EXE_query_exception),
        .query_exception_code_o(EXE_query_exception_code),
        .query_exception_val_o(EXE_query_exception_val),

        .pc_addr_i(ID_pc_addr),
        .dm_en_i(ID_dm_en),
        .dm_wen_i(ID_dm_wen),
        .dm_width_i(ID_dm_width),
        .dm_sign_ext_i(ID_dm_sign_ext),
        .dm_mux_ctr_i(ID_dm_mux_ctr),
        .rf_data_b_i(ID_data_b),
        .tlb_flush_i(ID_tlb_flush),
        .drain_pipeline_i(ID_drain_pipeline),
        .fence_i_i(ID_fence_i),

        .pc_addr_o(EXE_pc_addr),
        .dm_en_o(EXE_dm_en),
        .dm_wen_o(EXE_dm_wen),
        .dm_width_o(EXE_dm_width),
        .dm_sign_ext_o(EXE_dm_sign_ext),
        .dm_mux_ctr_o(EXE_dm_mux_ctr),
        .rf_data_b_o(EXE_data_b),
        .tlb_flush_o(EXE_tlb_flush),
        .drain_pipeline_o(EXE_drain_pipeline),
        .fence_i_o(EXE_fence_i),


        .wb_en_i(ID_wb_en),
        .wb_en_o(EXE_wb_en)
    );

    
    EXE_csr_transfer exe_csr_transfer (

        .clk(sys_clk),
        .rst(sys_rst),

        .csr_addr(EXE_csr_addr),
        .zimm(EXE_imm),
        .csr_opcode(EXE_csr_opcode),
        .x_rs1(EXE_data_a),
        .csr_data(csr_transfer_data),
        
        .priviledge_mode_i(CONTROLLER_priviledge_mode_reg),
        .mtvec_i(CONTROLLER_mtvec_reg),
        .mscratch_i(CONTROLLER_mscratch_reg),
        .mepc_i(CONTROLLER_mepc_reg),
        .mcause_i(CONTROLLER_mcause_reg),
        .mstatus_i(CONTROLLER_mstatus_reg),
        .mie_i(CONTROLLER_mie_reg),
        .mip_i(CONTROLLER_mip_reg),
        .mtval_i(CONTROLLER_mtval_reg),
        .mideleg_i(CONTROLLER_mideleg_reg),
        .medeleg_i(CONTROLLER_medeleg_reg),
        .satp_i(CONTROLLER_satp_reg),
        .sepc_i(CONTROLLER_sepc_reg),
        .scause_i(CONTROLLER_scause_reg),
        .stval_i(CONTROLLER_stval_reg),
        .stvec_i(CONTROLLER_stvec_reg),
        .sscratch_i(CONTROLLER_sscratch_reg),

        .priviledge_mode_o(CONTROLLER_priviledge_mode_data_write),
        .mtvec_o(CONTROLLER_mtvec_data_write),
        .mscratch_o(CONTROLLER_mscratch_data_write),
        .mepc_o(CONTROLLER_mepc_data_write),
        .mcause_o(CONTROLLER_mcause_data_write),
        .mstatus_o(CONTROLLER_mstatus_data_write),
        .mie_o(CONTROLLER_mie_data_write),
        .mip_o(CONTROLLER_mip_data_write),
        .mtval_o(CONTROLLER_mtval_data_write),
        .mideleg_o(CONTROLLER_mideleg_data_write),
        .medeleg_o(CONTROLLER_medeleg_data_write),
        .satp_o(CONTROLLER_satp_data_write),
        .sepc_o(CONTROLLER_sepc_data_write),
        .scause_o(CONTROLLER_scause_data_write),
        .stval_o(CONTROLLER_stval_data_write),
        .stvec_o(CONTROLLER_stvec_data_write),
        .sscratch_o(CONTROLLER_sscratch_data_write),

        .priviledge_mode_wen(CONTROLLER_priviledge_mode_wen),
        .mtvec_wen(CONTROLLER_mtvec_wen),
        .mscratch_wen(CONTROLLER_mscratch_wen),
        .mepc_wen(CONTROLLER_mepc_wen),
        .mcause_wen(CONTROLLER_mcause_wen),
        .mstatus_wen(CONTROLLER_mstatus_wen),
        .mie_wen(CONTROLLER_mie_wen),
        .mip_wen(CONTROLLER_mip_wen),
        .mtval_wen(CONTROLLER_mtval_wen),
        .mideleg_wen(CONTROLLER_mideleg_wen),
        .medeleg_wen(CONTROLLER_medeleg_wen),
        .satp_wen(CONTROLLER_satp_wen),
        .sepc_wen(CONTROLLER_sepc_wen),
        .scause_wen(CONTROLLER_scause_wen),
        .stval_wen(CONTROLLER_stval_wen),
        .stvec_wen(CONTROLLER_stvec_wen),
        .sscratch_wen(CONTROLLER_sscratch_wen),

        .IF_pc_addr(IF_pc_addr),
        .ID_pc_addr(ID_pc_addr),
        .EXE_pc_addr(EXE_pc_addr),
        .MEM_pc_addr(MEM_pc_addr),

        .exe_exception(EXE_query_exception),
        .exe_exception_code(EXE_query_exception_code),
        .exe_exception_val(EXE_query_exception_val),

        .dm_ack(CONTROLLER_dm_ack),
        .dm_exception(MEM_query_exception),
        .dm_exception_code(MEM_query_exception_code),
        .dm_exception_val(MEM_query_exception_val),

        .state_o(CONTROLLER_csr_transfer_state),
        .pc_nxt_exception(pc_nxt_exception),

        .exception_controller(CONTROLLER_exception)
    );

    logic [DATA_WIDTH-1:0] alu_a, alu_b, alu_o;
    logic [DATA_WIDTH-1:0] alu_o_branch;

    always_comb begin
        alu_o_branch = alu_o;
        if (EXE_dm_en == 0 && EXE_dm_wen == 1) begin  // JALR
            alu_o_branch = alu_o & (~32'h1);
        end else if (CONTROLLER_csr_transfer_state == 2) begin
            alu_o_branch = pc_nxt_exception;
        end
    end

    EXE_alu_mux_a exe_alu_mux_a (
        .alu_mux_a_ctr_i(EXE_ALU_mux_a_ctr),
        .alu_mux_a_data(EXE_data_a),
        .alu_mux_a_pc(EXE_pc_addr),
        .alu_mux_a_csr(csr_transfer_data),
        .alu_mux_a_o(alu_a)
    );

    EXE_alu_mux_b exe_alu_mux_b (
        .alu_mux_b_ctr_i(EXE_ALU_mux_b_ctr),
        .alu_mux_b_data(EXE_data_b),
        .alu_mux_b_imm(EXE_imm),
        .alu_mux_b_bc_result(CONTROLLER_bc_cond),
        .alu_mux_b_o(alu_b)
    );

    ALU alu (
        .a(alu_a),
        .b(alu_b),
        .op(EXE_ALU_op),
        .y(alu_o)
    );

    logic [DATA_WIDTH-1:0] bc_data_b;
    always_comb begin
        bc_data_b = EXE_data_b;
        if (EXE_imm_en && EXE_pc_mux_ctr == `PC_MUX_INC && EXE_ALU_mux_b_ctr == `ALU_MUX_B_BC_RESULT) begin  // set less than immediate
            bc_data_b = EXE_imm;
        end
    end

    EXE_branch_comp exe_branch_comp (
        .bc_op (EXE_bc_op),
        .data_a(EXE_data_a),
        .data_b(bc_data_b),
        .cond(CONTROLLER_bc_cond)
    );

    logic [`DM_MUX_WIDTH-1:0] MEM_dm_mux_ctr;
    logic [ADDR_WIDTH-1:0] MEM_pc_addr;
    logic MEM_dm_en, MEM_dm_wen, MEM_wb_en;
    logic MEM_tlb_flush, MEM_drain_pipeline, MEM_fence_i;
    logic [2:0] MEM_dm_width; 
    logic MEM_dm_sign_ext;
    logic [4:0] MEM_rd;

    logic WB_drain_pipeline;

    logic [DATA_WIDTH-1:0] MEM_alu, MEM_data_b;

    REG_EXE_MEM reg_exe_mem (
        .clk(sys_clk),
        .rst(sys_rst),

        .stall(CONTROLLER_stall[0]),
        .bubble(CONTROLLER_bubble[1]),

        .rd_i(EXE_rd),
        .rd_o(MEM_rd),

        .pc_addr_i(EXE_pc_addr),
        .alu_out_i(alu_o),
        .dm_en_i(EXE_dm_en),
        .dm_wen_i(EXE_dm_wen),
        .dm_width_i(EXE_dm_width),
        .dm_sign_ext_i(EXE_dm_sign_ext),
        .dm_mux_ctr_i(EXE_dm_mux_ctr),
        .rf_data_b_i(EXE_data_b),
        .tlb_flush_i(EXE_tlb_flush),
        .drain_pipeline_i(EXE_drain_pipeline),
        .fence_i_i(EXE_fence_i),

        .pc_addr_o(MEM_pc_addr),
        .alu_out_o(MEM_alu),
        .dm_en_o(MEM_dm_en),
        .dm_wen_o(MEM_dm_wen),
        .dm_width_o(MEM_dm_width),
        .dm_sign_ext_o(MEM_dm_sign_ext),
        .dm_mux_ctr_o(MEM_dm_mux_ctr),
        .rf_data_b_o(MEM_data_b),
        .tlb_flush_o(MEM_tlb_flush),
        .drain_pipeline_o(MEM_drain_pipeline),
        .fence_i_o(MEM_fence_i),


        .wb_en_i(EXE_wb_en),
        .wb_en_o(MEM_wb_en)
    );

    logic [DATA_WIDTH-1:0] MEM_DM_data;
    logic [DATA_WIDTH-1:0] MEM_wb_data;

    logic [63:0] mtimer_mtime;
    logic [63:0] mtimer_mtimecmp;
    logic mtimer_mtime_wen, mtimer_mtimecmp_wen, mtimer_upper_wen;
    logic [31:0] mtimer_wdata;

    // wishbone master for DM
    logic wbm_cyc_dm;
    logic wbm_stb_dm;
    logic wbm_ack_dm;
    logic [ADDR_WIDTH-1:0] wbm_adr_dm;
    logic [DATA_WIDTH-1:0] wbm_dat_m2s_dm;  // master 2 slave
    logic [DATA_WIDTH-1:0] wbm_dat_s2m_dm;  // slave 2 master
    logic [DATA_WIDTH/8-1:0] wbm_sel_dm; 
    logic wbm_we_dm;

    CONTROLLER_mtimer controller_mtimer (
        .clk (sys_clk),
        .rst (sys_rst),

        .mtime(mtimer_mtime),
        .mtimecmp(mtimer_mtimecmp),
        .interrupt_timer(CONTROLLER_interrupt_timer),

        .mtime_wen(mtimer_mtime_wen),
        .mtimecmp_wen(mtimer_mtimecmp_wen),
        .upper_wen(mtimer_upper_wen),
        .mtimer_wdata(mtimer_wdata)
    );

    // MEM_dm data_fetcher (
    //     .clk (sys_clk),
    //     .rst (sys_rst),

    //     .dm_en(MEM_dm_en),
    //     .dm_wen(MEM_dm_wen),
    //     .dm_addr(MEM_alu),
    //     .dm_data_i(MEM_data_b),
    //     .dm_width(MEM_dm_width),
    //     .dm_sign_ext(MEM_dm_sign_ext),
    //     .dm_ack(CONTROLLER_dm_ack),
    //     .dm_data_o(MEM_DM_data),

    //     .wbm_cyc_o(wbm_cyc_dm),
    //     .wbm_stb_o(wbm_stb_dm),
    //     .wbm_ack_i(wbm_ack_dm),
    //     .wbm_adr_o(wbm_adr_dm),
    //     .wbm_dat_o(wbm_dat_m2s_dm),
    //     .wbm_dat_i(wbm_dat_s2m_dm),
    //     .wbm_sel_o(wbm_sel_dm),
    //     .wbm_we_o(wbm_we_dm),

    //     .mtimer_mtime(mtimer_mtime),
    //     .mtimer_mtimecmp(mtimer_mtimecmp),
    //     .mtimer_mtime_wen(mtimer_mtime_wen),
    //     .mtimer_mtimecmp_wen(mtimer_mtimecmp_wen),
    //     .mtimer_upper_wen(mtimer_upper_wen),
    //     .mtimer_wdata(mtimer_wdata)
    // );

    MEM_MMU data_fetcher (
        .clk (sys_clk),
        .rst (sys_rst),

        .mstatus_i(CONTROLLER_mstatus_reg),
        .priviledge_mode_i(CONTROLLER_priviledge_mode_reg),
        .satp_i(CONTROLLER_satp_reg),
        .tlb_flush(MEM_tlb_flush),
        .fence_i(MEM_fence_i),

        .dm_en(MEM_dm_en),
        .dm_wen(MEM_dm_wen),
        .dm_addr(MEM_alu),
        .dm_data_i(MEM_data_b),
        .dm_width(MEM_dm_width),
        .dm_sign_ext(MEM_dm_sign_ext),
        .dm_ack(CONTROLLER_dm_ack),
        .dm_data_o(MEM_DM_data),


        .query_exception(MEM_query_exception),
        .query_exception_code(MEM_query_exception_code),
        .query_exception_val(MEM_query_exception_val),

        .wbm_cyc_o(wbm_cyc_dm),
        .wbm_stb_o(wbm_stb_dm),
        .wbm_ack_i(wbm_ack_dm),
        .wbm_adr_o(wbm_adr_dm),
        .wbm_dat_o(wbm_dat_m2s_dm),
        .wbm_dat_i(wbm_dat_s2m_dm),
        .wbm_sel_o(wbm_sel_dm),
        .wbm_we_o(wbm_we_dm),

        .mtimer_mtime(mtimer_mtime),
        .mtimer_mtimecmp(mtimer_mtimecmp),
        .mtimer_mtime_wen(mtimer_mtime_wen),
        .mtimer_mtimecmp_wen(mtimer_mtimecmp_wen),
        .mtimer_upper_wen(mtimer_upper_wen),
        .mtimer_wdata(mtimer_wdata)
    );

    MEM_dm_mux mem_dm_mux (
        .dm_mux_ctr (MEM_dm_mux_ctr),
        .dm_mux_pc_addr (MEM_pc_addr),
        .dm_mux_alu (MEM_alu),
        .dm_mux_dm(MEM_DM_data),
        .dm_mux_o(MEM_wb_data)
    );

    REG_MEM_WB reg_mem_wb (
        .clk(sys_clk),
        .rst(sys_rst),
        .bubble(CONTROLLER_bubble[0]),

        .wb_en_i(MEM_wb_en),
        .wb_addr_i(MEM_rd),
        .wb_data_i(MEM_wb_data),
        .drain_pipeline_i(MEM_drain_pipeline),
        .fence_i_i(MEM_fence_i),
        .tlb_flush_i(MEM_tlb_flush),

        .wb_en_o(RF_wen),
        .wb_addr_o(RF_waddr),
        .wb_data_o(RF_wdata),
        .drain_pipeline_o(WB_drain_pipeline),
        .fence_i_o(WB_fence_i),
        .tlb_flush_o(WB_tlb_flush)
    );


    logic [ADDR_WIDTH-1:0]   wbs_adr_o;
    logic [DATA_WIDTH-1:0]   wbs_dat_i;
    logic [DATA_WIDTH-1:0]   wbs_dat_o;     // DAT_O() data out
    logic                    wbs_we_o;      // WE_O write enable output
    logic [3:0] wbs_sel_o;     // SEL_O() select output
    logic                    wbs_stb_o;     // STB_O strobe output
    logic                    wbs_ack_i;     // ACK_I acknowledge input
    logic                    wbs_err_i;     // ERR_I error input
    logic                    wbs_rty_i;     // RTY_I retry input
    logic                    wbs_cyc_o;      // CYC_O cycle output

    // Arbiter: 0 for DM, 1 for IM
    wb_arbiter_2 arbiter (
        .clk(sys_clk),
        .rst(sys_rst),

        .wbm0_adr_i(wbm_adr_dm),
        .wbm0_dat_i(wbm_dat_m2s_dm),
        .wbm0_dat_o(wbm_dat_s2m_dm),
        .wbm0_we_i(wbm_we_dm),
        .wbm0_sel_i(wbm_sel_dm),
        .wbm0_stb_i(wbm_stb_dm),
        .wbm0_ack_o(wbm_ack_dm),
        .wbm0_err_o(),  // not used
        .wbm0_rty_o(),  // not used
        .wbm0_cyc_i(wbm_cyc_dm),
        
        .wbm1_adr_i(wbm_adr_im),
        .wbm1_dat_i(wbm_dat_m2s_im),
        .wbm1_dat_o(wbm_dat_s2m_im),
        .wbm1_we_i(wbm_we_im),
        .wbm1_sel_i(wbm_sel_im),
        .wbm1_stb_i(wbm_stb_im),
        .wbm1_ack_o(wbm_ack_im),
        .wbm1_err_o(),  // not used
        .wbm1_rty_o(),  // not used
        .wbm1_cyc_i(wbm_cyc_im),

        .wbs_adr_o(wbs_adr_o),
        .wbs_dat_i(wbs_dat_o),
        .wbs_dat_o(wbs_dat_i),
        .wbs_we_o(wbs_we_o),
        .wbs_sel_o(wbs_sel_o),
        .wbs_stb_o(wbs_stb_o),
        .wbs_ack_i(wbs_ack_i),
        .wbs_err_i(wbs_err_i),
        .wbs_rty_i(wbs_rty_i),
        .wbs_cyc_o(wbs_cyc_o)
    );

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

    logic wbs3_cyc_o;
    logic wbs3_stb_o;
    logic wbs3_ack_i;
    logic [31:0] wbs3_adr_o;
    logic [31:0] wbs3_dat_o;
    logic [31:0] wbs3_dat_i;
    logic [3:0] wbs3_sel_o;
    logic wbs3_we_o;

    logic wbs4_cyc_o;
    logic wbs4_stb_o;
    logic wbs4_ack_i;
    logic [31:0] wbs4_adr_o;
    logic [31:0] wbs4_dat_o;
    logic [31:0] wbs4_dat_i;
    logic [3:0] wbs4_sel_o;
    logic wbs4_we_o;


    // Wishbone multiplexer
    wb_mux5 wb_mux (
        .clk(sys_clk),
        .rst(sys_rst),

        // Master interface (to arbiter)
        .wbm_adr_i(wbs_adr_o),
        .wbm_dat_i(wbs_dat_i),
        .wbm_dat_o(wbs_dat_o),
        .wbm_we_i (wbs_we_o),
        .wbm_sel_i(wbs_sel_o),
        .wbm_stb_i(wbs_stb_o),
        .wbm_ack_o(wbs_ack_i),
        .wbm_err_o(),
        .wbm_rty_o(),
        .wbm_cyc_i(wbs_cyc_o),

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
        .wbs2_cyc_o(wbs2_cyc_o),
        
        // Slave interface 3 (to VGA controller)
        // Address range: 0x8100_0000 ~ 0x8100_1FFF
        // 100 * 75 pixels * 8 bit color depth
        .wbs3_addr    (32'h8100_0000),
        .wbs3_addr_msk(32'hFFFF_E000),

        .wbs3_adr_o(wbs3_adr_o),
        .wbs3_dat_i(wbs3_dat_i),
        .wbs3_dat_o(wbs3_dat_o),
        .wbs3_we_o (wbs3_we_o),
        .wbs3_sel_o(wbs3_sel_o),
        .wbs3_stb_o(wbs3_stb_o),
        .wbs3_ack_i(wbs3_ack_i),
        .wbs3_err_i('0),
        .wbs3_rty_i('0),
        .wbs3_cyc_o(wbs3_cyc_o),


        // Slave interface 4 (to Flash controller)
        // Address range: 0x8080_0000 ~ 0x80FF_FFFF
        .wbs4_addr    (32'h8080_0000),
        .wbs4_addr_msk(32'hFFF8_0000),

        .wbs4_adr_o(wbs4_adr_o),
        .wbs4_dat_i(wbs4_dat_i),
        .wbs4_dat_o(wbs4_dat_o),
        .wbs4_we_o (wbs4_we_o),
        .wbs4_sel_o(wbs4_sel_o),
        .wbs4_stb_o(wbs4_stb_o),
        .wbs4_ack_i(wbs4_ack_i),
        .wbs4_err_i('0),
        .wbs4_rty_i('0),
        .wbs4_cyc_o(wbs4_cyc_o)

    );

    // Slaves
    /* verilator lint_off PINMISSING */
    // wb_dp_ram #(
    //     // .INIT_FILE ("/home/gaoha_bak15/cod-lab-ucore/labcodes_answer/lab8/bin/rbl.img")
    //     .INIT_FILE ("/home/gaoha_bak15/cod22-grp64/rbl.img")
    // ) sram_controller_base (
    //     .a_clk(sys_clk),
    //     .a_adr_i(wbs0_adr_o),
    //     .a_dat_i(wbs0_dat_o),
    //     .a_dat_o(wbs0_dat_i),
    //     .a_we_i(wbs0_we_o),
    //     .a_sel_i(wbs0_sel_o),
    //     .a_stb_i(wbs0_stb_o),
    //     .a_ack_o(wbs0_ack_i),
    //     .a_cyc_i(wbs0_cyc_o),

    //     .b_clk(1'b0)
    // );

    // wb_dp_ram #(
    //     // .INIT_FILE ("/home/gaoha_bak15/cod-lab-ucore/labcodes_answer/lab8/bin/ucore.img")
    //     .INIT_FILE ("/home/gaoha_bak15/cod22-grp64/ucore.img")
    // ) sram_controller_exe (
    //     .a_clk(sys_clk),
    //     .a_adr_i(wbs1_adr_o),
    //     .a_dat_i(wbs1_dat_o),
    //     .a_dat_o(wbs1_dat_i),
    //     .a_we_i(wbs1_we_o),
    //     .a_sel_i(wbs1_sel_o),
    //     .a_stb_i(wbs1_stb_o),
    //     .a_ack_o(wbs1_ack_i),
    //     .a_cyc_i(wbs1_cyc_o),

    //     .b_clk(1'b0)
    // );

    // fake_uart_controller uart_controller (
    //     .clk_i(sys_clk),
    //     .rst_i(sys_rst),

    //     .wb_cyc_i(wbs2_cyc_o),
    //     .wb_stb_i(wbs2_stb_o),
    //     .wb_ack_o(wbs2_ack_i),
    //     .wb_adr_i(wbs2_adr_o),
    //     .wb_dat_i(wbs2_dat_o),
    //     .wb_dat_o(wbs2_dat_i),
    //     .wb_sel_i(wbs2_sel_o),
    //     .wb_we_i (wbs2_we_o),

    //     .external_valid(data_valid),
    //     .external_data(dat_to_send)

    // );   
    // assign sys_clk = clk_50M;
    /* verilator lint_on PINMISSING */

    sram_controller_single #(
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

    sram_controller_single #(
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

    uart_controller #(
        .CLK_FREQ(20_000_000),
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
    assign sys_clk = clk_30M;

    vga vga (
        .clk_i        (sys_clk),
        .clk_50M      (clk_50M),
        .rst_i        (reset_of_sys_clk),
        .wb_cyc_i     (wbs3_cyc_o),
        .wb_stb_i     (wbs3_stb_o),
        .wb_ack_o     (wbs3_ack_i),
        .wb_adr_i     (wbs3_adr_o),
        .wb_dat_i     (wbs3_dat_o),
        // .wb_dat_o     (wbs3_dat_i),
        .wb_sel_i     (wbs3_sel_o),
        .wb_we_i      (wbs3_we_o),
        .video_red_o  (video_red),
        .video_green_o(video_green),
        .video_blue_o (video_blue),
        .video_hsync_o(video_hsync),
        .video_vsync_o(video_vsync),
        .video_de_o   (video_de)
    );
    assign wbs3_dat_i = 32'bz;
    assign video_clk = clk_50M;

    flash_controller flash_controller (
        .clk_i(sys_clk),
        .rst_i(sys_rst),

        .wb_cyc_i(wbs4_cyc_o),
        .wb_stb_i(wbs4_stb_o),
        .wb_ack_o(wbs4_ack_i),
        .wb_adr_i(wbs4_adr_o),
        .wb_dat_i(wbs4_dat_o),
        .wb_dat_o(wbs4_dat_i),
        .wb_sel_i(wbs4_sel_o),
        .wb_we_i (wbs4_we_o),

        .addr_o(flash_a),
        .data_io(flash_d),
        .rp_n_o(flash_rp_n),
        .vpen_o(flash_vpen),
        .ce_n_o(flash_ce_n),
        .oe_n_o(flash_oe_n),
        .we_n_o(flash_we_n),
        .byte_n_o(flash_byte_n)
    );


endmodule
