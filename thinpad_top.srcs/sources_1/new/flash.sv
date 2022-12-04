module flash_controller #(
    parameter FLASH_ADDR_WIDTH = 32,
    parameter FLASH_DATA_WIDTH = 32,
    parameter COUNTER_WIDTH    = 3,
    parameter BUFFER_CLK   = 3,  // >= 120 ns 
    parameter INNER_CLK    = 1,  // >= 25 ns
    parameter POST_RST_CLK = 4   // >= 180 ns
) (
    // clk and reset
    input wire clk_i,
    input wire rst_i,

    // wishbone slave interface
    input wire wb_cyc_i,
    input wire wb_stb_i,
    output reg wb_ack_o,
    input wire [FLASH_ADDR_WIDTH-1:0] wb_adr_i,
    input wire [FLASH_DATA_WIDTH-1:0] wb_dat_i,
    output wire [FLASH_DATA_WIDTH-1:0] wb_dat_o,
    input wire [FLASH_DATA_WIDTH/8-1:0] wb_sel_i,
    input wire wb_we_i,

    // flash interface
    output wire [22:0] addr_o,
    inout  wire [15:0] data_io,
    output wire        rp_n_o,
    output wire        vpen_o,
    output wire        ce_n_o,
    output wire        oe_n_o,
    output wire        we_n_o,
    output wire        byte_n_o
);

logic prev_page_valid;
logic [19:0] prev_page;
logic [FLASH_DATA_WIDTH-1:0] data;
logic [COUNTER_WIDTH-1:0] counter;
logic [22:0] addr;

assign byte_n_o = 1;     // x16 mode
assign vpen_o = 0;       // read only
assign we_n_o = 1;       // read only
assign oe_n_o = 0;       // out enable
assign ce_n_o = 0;       // chip enable
assign rp_n_o = ~rst_i;  // reset

assign addr_o = addr;    // hold page address
assign wb_dat_o = data;  // hold data

typedef enum logic [3:0] { 
    POST_RST,
    IDLE,
    PAGE_BUFFER_WAIT,
    INNER_WAIT_LO,  // read the 1st word
    INNER_WAIT_HI,  // read the 2nd word
    ACK
} state_t;
/*
* Default sequence
* IDLE -> PAGE_BUFFER_WAIT -> INNER_WAIT_LO -> INNER_WAIT_HI -> ACK
*/

state_t state;


always_comb begin 
    wb_ack_o = 0;
    addr[1] = 0;
    case (state)
        INNER_WAIT_LO:
            addr[1] = 0;
        INNER_WAIT_HI:
            addr[1] = 1;
        ACK: 
            wb_ack_o = 1;
    endcase
end

always_ff @( posedge clk_i ) begin 
    if (rst_i) begin
        state <= POST_RST;
        prev_page_valid <= 0;
        counter <= 1;
    end else begin
        case (state)
            POST_RST: begin
                if (counter == POST_RST_CLK) begin
                    state <= IDLE;
                end else begin
                    counter <= counter + 1;
                end
            end

            IDLE: begin
                if (wb_stb_i && wb_cyc_i) begin
                    if (!(wb_sel_i[3] | wb_sel_i[2] | wb_sel_i[1] | wb_sel_i[0])) begin
                        state <= ACK;
                    end else begin
                        addr[22:2] <= wb_adr_i[22:2];
                        if (prev_page_valid && (prev_page == wb_adr_i[22:3])) begin  // read in the same page, skip page buffer
                            counter <= 1;
                            if (wb_sel_i[1] | wb_sel_i[0]) begin
                                state <= INNER_WAIT_LO;
                            end else if (wb_sel_i[2] | wb_sel_i[3]) begin
                                state <= INNER_WAIT_HI;
                            end
                        end else begin  // read new page
                            counter <= 1;
                            state <= PAGE_BUFFER_WAIT;
                        end
                    end
                end
            end

            PAGE_BUFFER_WAIT: begin
                // before 1st read, need BUFFER_CLK clks
                // extra 1 clk for setup
                // reamaining buffer waiting time assigned to inner wait
                if (counter >= (BUFFER_CLK - INNER_CLK + 1)) begin  // begin read word (16bit)
                    prev_page_valid <= 1;
                    prev_page <= addr[22:3];
                    counter <= 1;
                    if (wb_sel_i[1] | wb_sel_i[0]) begin
                        state <= INNER_WAIT_LO;
                    end else if (wb_sel_i[2] | wb_sel_i[3]) begin
                        state <= INNER_WAIT_HI;
                    end
                end else begin
                    counter <= counter + 1;
                end
            end

            INNER_WAIT_LO: begin
                if (counter == INNER_CLK) begin
                    counter <= 1;
                    data[15:0] <= data_io;
                    if (wb_sel_i[2] | wb_sel_i[3]) begin
                        state <= INNER_WAIT_HI;
                    end else begin
                        state <= ACK;
                    end
                end else begin
                    counter <= counter + 1;
                end
            end

            INNER_WAIT_HI: begin
                if (counter == INNER_CLK) begin
                    counter <= 1;
                    data[31:16] <= data_io;
                    state <= ACK;
                end else begin
                    counter <= counter + 1;
                end
            end

            ACK: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule