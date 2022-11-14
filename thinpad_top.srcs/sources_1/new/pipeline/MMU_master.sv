module MMU_master #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    // TLB -> Wishbone master
    input wire master_owner,

    // Cache -> Wishbone master
    input  wire [ADDR_WIDTH-1:0]   wbm0_adr_o,    // ADR_I() address input
    input  wire [DATA_WIDTH-1:0]   wbm0_dat_o,    // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wbm0_dat_i,    // DAT_O() data out
    input  wire                    wbm0_we_o,     // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wbm0_sel_o,    // SEL_I() select input
    input  wire                    wbm0_stb_o,    // STB_I strobe input
    output wire                    wbm0_ack_i,    // ACK_O acknowledge output
    input  wire                    wbm0_cyc_o,    // CYC_I cycle input
    
    // Translation Unit -> Wishbone master
    input  wire [ADDR_WIDTH-1:0]   wbm1_adr_o,    // ADR_I() address input
    input  wire [DATA_WIDTH-1:0]   wbm1_dat_o,    // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   wbm1_dat_i,    // DAT_O() data out
    input  wire                    wbm1_we_o,     // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] wbm1_sel_o,    // SEL_I() select input
    input  wire                    wbm1_stb_o,    // STB_I strobe input
    output wire                    wbm1_ack_i,    // ACK_O acknowledge output
    input  wire                    wbm1_cyc_o,    // CYC_I cycle input

    // Wishbone master -> Wishbone arbiter
    output wire wb_cyc_o, 
    output logic wb_stb_o, 
    input wire wb_ack_i, 
    output logic [ADDR_WIDTH-1:0] wb_adr_o,
    output wire [DATA_WIDTH-1:0] wb_dat_o,
    input wire [DATA_WIDTH-1:0] wb_dat_i,
    output wire [DATA_WIDTH/8-1:0] wb_sel_o,
    output wire wb_we_o
);

    always_comb begin

        wbm0_dat_i = 0; wbm0_ack_i = 0;
        wbm1_dat_i = 0; wbm1_ack_i = 0;

        if (master_owner == 1'b0) begin
            // Cache
            wb_cyc_o = wbm0_cyc_o;
            wb_stb_o = wbm0_stb_o;
            wbm0_ack_i = wb_ack_i;
            wb_adr_o = wbm0_adr_o;
            wb_dat_o = wbm0_dat_o;
            wbm0_dat_i = wb_dat_i;
            wb_sel_o = wbm0_sel_o;
            wb_we_o = wbm0_we_o;

        end else begin
            // Translation Unit
            wb_cyc_o = wbm1_cyc_o;
            wb_stb_o = wbm1_stb_o;
            wbm1_ack_i = wb_ack_i;
            wb_adr_o = wbm1_adr_o;
            wb_dat_o = wbm1_dat_o;
            wbm1_dat_i = wb_dat_i;
            wb_sel_o = wbm1_sel_o;
            wb_we_o = wbm1_we_o;

        end
    end

endmodule