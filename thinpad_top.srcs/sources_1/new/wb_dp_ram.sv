/*

Copyright (c) 2015-2016 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1ns / 1ps

/*
 * Wishbone dual port RAM
 */
module wb_dp_ram #
(
    parameter DATA_WIDTH = 32,                // width of data bus in bits (8, 16, 32, or 64)
    parameter ADDR_WIDTH = 32,                // width of address bus in bits
    parameter SELECT_WIDTH = 4,   // width of word select bus (1, 2, 4, or 8)
    parameter INIT_FILE = "/mnt/d/Project/rv-2022/asmcode/kernel_paging.bin"
)
(
    // port A
    input  wire                    a_clk,
    input  wire [ADDR_WIDTH-1:0]   a_adr_i,   // ADR_I() address
    input  wire [DATA_WIDTH-1:0]   a_dat_i,   // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   a_dat_o,   // DAT_O() data out
    input  wire                    a_we_i,    // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] a_sel_i,   // SEL_I() select input
    input  wire                    a_stb_i,   // STB_I strobe input
    output wire                    a_ack_o,   // ACK_O acknowledge output
    input  wire                    a_cyc_i,   // CYC_I cycle input

    output logic [DATA_WIDTH-1:0] mem_wire,

    // port B
    input  wire                    b_clk,
    input  wire [ADDR_WIDTH-1:0]   b_adr_i,   // ADR_I() address
    input  wire [DATA_WIDTH-1:0]   b_dat_i,   // DAT_I() data in
    output wire [DATA_WIDTH-1:0]   b_dat_o,   // DAT_O() data out
    input  wire                    b_we_i,    // WE_I write enable input
    input  wire [SELECT_WIDTH-1:0] b_sel_i,   // SEL_I() select input
    input  wire                    b_stb_i,   // STB_I strobe input
    output wire                    b_ack_o,   // ACK_O acknowledge output
    input  wire                    b_cyc_i    // CYC_I cycle input
);

// for interfaces that are more than one word wide, disable address lines
parameter VALID_ADDR_WIDTH = 20;
// width of data port in words (1, 2, 4, or 8)
parameter WORD_WIDTH = 4;
// size of words (8, 16, 32, or 64 bits)
parameter WORD_SIZE = 8;

reg [DATA_WIDTH-1:0] a_dat_o_reg = {DATA_WIDTH{1'b0}};
reg a_ack_o_reg = 1'b0;

reg [DATA_WIDTH-1:0] b_dat_o_reg = {DATA_WIDTH{1'b0}};
reg b_ack_o_reg = 1'b0;

// (* RAM_STYLE="BLOCK" *)
reg [DATA_WIDTH-1:0] mem[(2**VALID_ADDR_WIDTH)-1:0];


always_comb begin
    mem_wire = mem[32'h52];
end


/* verilator lint_off WIDTH */
wire [VALID_ADDR_WIDTH-1:0] a_adr_i_valid = (a_adr_i & 32'h003fffff) >> 2;
wire [VALID_ADDR_WIDTH-1:0] b_adr_i_valid = (b_adr_i & 32'h003fffff) >> 2;
/* verilator lint_on WIDTH */

assign a_dat_o = a_dat_o_reg;
assign a_ack_o = a_ack_o_reg;

assign b_dat_o = b_dat_o_reg;
assign b_ack_o = b_ack_o_reg;

integer i, j;

/* verilator lint_off WIDTH */
initial begin
    // // two nested loops for smaller number of iterations per loop
    // // workaround for synthesizer complaints about large loop counts
    // for (i = 0; i < 2**ADDR_WIDTH; i = i + 2**(ADDR_WIDTH/2)) begin
    //     for (j = i; j < i + 2**(ADDR_WIDTH/2); j = j + 1) begin
    //         mem[j] = 0;
    //     end
    // end
    reg [31:0] tmp_array[0:1048575];
    integer n_File_ID, n_Init_Size;
    n_File_ID = $fopen(INIT_FILE, "rb");
    if (!n_File_ID) begin
      n_Init_Size = 0;
      $display("Failed to open init file");
    end else begin
      n_Init_Size = $fread(tmp_array, n_File_ID);
      n_Init_Size = (n_Init_Size + 3) / 4;
      $fclose(n_File_ID);
    end
    $display("BaseRAM Init Size(words): %d", n_Init_Size);
    for (integer i = 0; i < n_Init_Size; i = i + 1) begin
      mem[i][31:24] = tmp_array[i][7:0];
      mem[i][23:16] = tmp_array[i][15:8];
      mem[i][15:8] = tmp_array[i][23:16];
      mem[i][7:0] = tmp_array[i][31:24];
    end
end
/* verilator lint_on WIDTH */

// port A
always @(posedge a_clk) begin
    a_ack_o_reg <= 1'b0;
    for (i = 0; i < WORD_WIDTH; i = i + 1) begin
        if (a_cyc_i & a_stb_i & ~a_ack_o) begin
            if (a_we_i & a_sel_i[i]) begin
                mem[a_adr_i_valid][WORD_SIZE*i +: WORD_SIZE] <= a_dat_i[WORD_SIZE*i +: WORD_SIZE];
            end else if (~a_we_i & a_sel_i[i]) begin
                a_dat_o_reg[WORD_SIZE*i +: WORD_SIZE] <= mem[a_adr_i_valid][WORD_SIZE*i +: WORD_SIZE];
            end
            a_ack_o_reg <= 1'b1;
        end
    end
end

// port B
always @(posedge b_clk) begin
    b_ack_o_reg <= 1'b0;
    for (i = 0; i < WORD_WIDTH; i = i + 1) begin
        if (b_cyc_i & b_stb_i & ~b_ack_o) begin
            if (b_we_i & b_sel_i[i]) begin
                mem[b_adr_i_valid][WORD_SIZE*i +: WORD_SIZE] <= b_dat_i[WORD_SIZE*i +: WORD_SIZE];
            end
            b_dat_o_reg[WORD_SIZE*i +: WORD_SIZE] <= mem[b_adr_i_valid][WORD_SIZE*i +: WORD_SIZE];
            b_ack_o_reg <= 1'b1;
        end
    end
end

endmodule