module wb_master (
    parameter DATA_WIDTH = 32,                    // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                    // width of address bus in bits
    parameter SELECT_WIDTH = (DATA_WIDTH/8)      // width of word select bus (1, 2, 4, or 8)
)(
    input  wire                    clk,
    input  wire                    rst,
    input  wire [ADDR_WIDTH-1:0]   wbm_adr_i,    // ADR_I() address input
    input  wire [DATA_WIDTH-1:0]   wbm_dat_i,    // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wbm_dat_o,    // DAT_O() data out
    input  wire                    wbm_we_i,     // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wbm_sel_i,    // SEL_I() select input
    input  wire                    wbm_stb_i,    // STB_I strobe input
    output wire                    wbm_ack_o,    // ACK_O acknowledge output
    output wire                    wbm_rty_o,    // RTY_O retry output
    input  wire                    wbm_cyc_i,    // CYC_I cycle input
);



endmodule