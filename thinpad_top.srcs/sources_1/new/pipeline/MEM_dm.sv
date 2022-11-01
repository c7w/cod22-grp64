// TODO: Review this file
module MEM_dm #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    // data memory
    input wire dm_en,
    input wire dm_wen,
    input wire [ADDR_WIDTH-1:0] dm_addr,
    output wire dm_ack,
    output wire dm_data,  // TODO : ?

    // Wishbone master
    output wire wbm_cyc_o,
    output wire wbm_stb_o,
    input wire wbm_ack_i,
    output wire[3:0] wbm_sel_o,
    output wire[ADDR_WIDTH-1:0] wbm_adr_o,
    input wire [DATA_WIDTH-1:0] wbm_dat_i,
    output wire[DATA_WIDTH-1:0] wbm_dat_o,
    output wire wbm_wen,
    output wire [DATA_WIDTH-1:0] wbm_dat_o
);

    assign wbm_cyc_o = wbm_stb_o;
    assign dm_data = wbm_dat_i;

    reg [ADDR_WIDTH-1:0] dm_addr_cache;
    reg [DATA_WIDTH-1:0] dm_data_cache;

    typedef enum logic[3:0] { 
        STATE_IDLE,
        STATE_READ_SRAM,
        STATE_WRITE_SRAM,
        STATE_READ_UART,
        STATE_WRITE_UART
    } state_t;
    state_t state;

    always_ff @ (posedge clk) begin
        if (rst) begin
            state <= STATE_IDLE;
            dm_addr_cache <= 0;
            dm_data_cache <= 0;
        end

        else begin 
            case (state)
                STATE_IDLE: begin
                    if (dm_en) begin
                        dm_addr_cache <= dm_addr;
                        if (dm_wen) begin
                            // Write
                            if (dm_addr[ADDR_WIDTH-1] == 1'b1) begin
                                // SRAM
                                state <= STATE_WRITE_SRAM;
                            end else begin
                                // UART
                                state <= STATE_WRITE_UART;
                            end

                        end else begin
                            // Read
                            if (dm_addr[ADDR_WIDTH-1] == 1'b1) begin
                                // SRAM
                                state <= STATE_READ_SRAM;
                            end else begin
                                // UART
                                state <= STATE_READ_UART;
                            end
                        end
                    end
                end
            endcase

        end
    end

    always_comb begin
        dm_data_o = DATA_WIDTH'h0;
        dm_ack_o = 0;

        case (state)
            STATE_IDLE: begin
                dm_ack_o = 1;
                dm_data_o = dm_data_cache;
            end

            // STATE
            // TODO
        endcase

    end


endmodule