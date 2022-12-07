`timescale 1ns / 1ps
//
// WIDTH: bits in register hdata & vdata
// HSIZE: horizontal size of visible field 
// HFP: horizontal front of pulse
// HSP: horizontal stop of pulse
// HMAX: horizontal max size of value
// VSIZE: vertical size of visible field 
// VFP: vertical front of pulse
// VSP: vertical stop of pulse
// VMAX: vertical max size of value
// HSPP: horizontal synchro pulse polarity (0 - negative, 1 - positive)
// VSPP: vertical synchro pulse polarity (0 - negative, 1 - positive)
//
module vga #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter RED_DEPTH = 3,
    parameter GREEN_DEPTH = 3,
    parameter BLUE_DEPTH = 2,
    parameter COLOR_DEPTH = RED_DEPTH + GREEN_DEPTH + BLUE_DEPTH,
    parameter WIDTH = 12,
    parameter HSIZE = 800,
    parameter HFP = 856,
    parameter HSP = 976,
    parameter HMAX = 1040,
    parameter VSIZE = 600,
    parameter VFP = 637,
    parameter VSP = 643,
    parameter VMAX = 666,
    parameter HSPP = 1,
    parameter VSPP = 1
) (
    input wire clk_i,
    input wire clk_50M,
    input wire rst_i,

    // Wishbone slave interface
    input wire wb_cyc_i,
    input wire wb_stb_i,
    output logic wb_ack_o,
    input wire [ADDR_WIDTH-1:0] wb_adr_i,
    input wire [DATA_WIDTH-1:0] wb_dat_i,
    // Write only
    // output reg [DATA_WIDTH-1:0] wb_dat_o,
    input wire [DATA_WIDTH/8-1:0] wb_sel_i,
    input wire wb_we_i,

    // VGA output interface
    output wire [RED_DEPTH-1:0]   video_red_o,
    output wire [GREEN_DEPTH-1:0] video_green_o,
    output wire [BLUE_DEPTH-1:0]  video_blue_o,
    output wire                   video_hsync_o,
    output wire                   video_vsync_o,
    output wire                   video_de_o
);
    reg [14:0] hdata, vdata;
    reg [14:0] addr;
    reg [31:0] dout;
    reg [7:0]  color;

    always_ff @ (posedge clk_50M) begin
        if (rst_i) begin
            hdata <= 0;
            vdata <= 0;
        end else begin
            hdata <= (hdata == (HMAX - 1)) ? 0 : hdata + 1;
            vdata <= (hdata == (HMAX - 1)) ? (vdata == (VMAX - 1) ? 0 : vdata + 1) : vdata;
        end
    end

    typedef enum logic {
        STATE_IDLE,
        STATE_WRITE
    } state_t;
    state_t state, next_state;

    always_comb begin
        next_state = STATE_IDLE;
        if (state == STATE_IDLE && wb_stb_i) begin
            next_state = STATE_WRITE;
        end else if (state == STATE_WRITE && wb_adr_i[14:0] == addr) begin
            next_state = STATE_WRITE;
        end
    end

    always_ff @ (posedge clk_i) begin
        if (rst_i) begin
            state <= STATE_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // 64 倍压缩分辨率
    assign addr = (hdata >> 3) + 14'd100 * (vdata >> 3);

    xpm_memory_dpdistram #(
        .ADDR_WIDTH_A(14),
        .ADDR_WIDTH_B(14),
        .BYTE_WRITE_WIDTH_A(32),
        .CLOCKING_MODE("independent_clock"),
        .MEMORY_INIT_FILE("none"),
        .MEMORY_INIT_PARAM("0"),
        .MEMORY_OPTIMIZATION("true"),
        .MEMORY_SIZE(524288),
        .MESSAGE_CONTROL(0),
        .READ_DATA_WIDTH_A(32),
        .READ_DATA_WIDTH_B(32),
        .READ_LATENCY_A(0),
        .READ_LATENCY_B(0),
        .READ_RESET_VALUE_A("0"),
        .READ_RESET_VALUE_B("0"),
        .RST_MODE_A("SYNC"),
        .RST_MODE_B("SYNC"),
        .SIM_ASSERT_CHK(0),
        .USE_EMBEDDED_CONSTRAINT(0),
        .USE_MEM_INIT(0),
        .WRITE_DATA_WIDTH_A(32)
    ) xpm_memory_dpdistram_inst (
        .doutb(dout),
        .addra({wb_adr_i[14:2], 2'b0}),
        .addrb({addr[14:2], 2'b0}),
        .clka(clk_i),
        .clkb(clk_50M),
        .dina(wb_dat_i),
        .ena(state == STATE_WRITE && next_state == STATE_IDLE),
        .enb(1'b1),
        .rsta(rst_i),
        .rstb(rst_i),
        .wea(wb_sel_i)
    );

    always_comb begin
        case (addr[1:0])
            2'b00: color = dout[7:0];
            2'b01: color = dout[15:8];
            2'b10: color = dout[23:16];
            2'b11: color = dout[31:24];
        endcase
    end

    // hsync & vsync & blank
    assign video_hsync_o = ((hdata >= HFP) && (hdata < HSP)) ? HSPP : !HSPP;
    assign video_vsync_o = ((vdata >= VFP) && (vdata < VSP)) ? VSPP : !VSPP;
    assign video_de_o    = ((hdata < HSIZE) & (vdata < VSIZE));
    assign video_red_o   = color[COLOR_DEPTH-1-:RED_DEPTH];
    assign video_green_o = color[COLOR_DEPTH-RED_DEPTH-1-:GREEN_DEPTH];
    assign video_blue_o  = color[BLUE_DEPTH-1:0];
    assign wb_ack_o      = state == STATE_WRITE && next_state == STATE_IDLE;

endmodule
