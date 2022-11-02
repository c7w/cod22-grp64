// TODO: Review this file
module MEM_dm #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,  // clk with 50M frequency
    input wire rst,

    // data memory
    input wire dm_en,
    input wire dm_wen,
    input wire [ADDR_WIDTH-1:0] dm_addr,
    input wire [DATA_WIDTH-1:0] dm_data_i,
    input wire [2:0] dm_width, // can be either 1, 2 or 4
    input wire dm_sign_ext,
    output wire dm_ack,
    output reg dm_data_o,

    // Wishbone master
    output wire wbm_cyc_o,
    output reg wbm_stb_o,
    input wire wbm_ack_i,
    output reg[3:0] wbm_sel_o,
    output reg[ADDR_WIDTH-1:0] wbm_adr_o,
    input wire [DATA_WIDTH-1:0] wbm_dat_i,
    output reg[DATA_WIDTH-1:0] wbm_dat_o,
    output reg wbm_we_o
);

    assign wbm_cyc_o = wbm_stb_o;

    // State
    typedef enum logic[3:0] { 
        STATE_IDLE,
        STATE_READ_SRAM,
        STATE_WRITE_SRAM,
        STATE_READ_UART,
        STATE_WRITE_UART
    } state_t;
    state_t state;
    logic [3:0] state_step;

    assign dm_ack = (state == STATE_IDLE);

    logic dm_en_cached, dm_wen_cached, dm_sign_ext_cached;
    logic [ADDR_WIDTH-1:0] addr_cached;
    logic [DATA_WIDTH-1:0] dat_i_cached;
    logic [2:0] width_cached;

    wire same_request;
    assign same_request = (dm_en == dm_en_cached) && (dm_wen == dm_wen_cached) && (dm_sign_ext == dm_sign_ext_cached) && (dm_addr == addr_cached) && (dm_data_i == dat_i_cached) && (dm_width == width_cached);

    always_ff @ (posedge clk) begin
        if (rst) begin
            state <= STATE_IDLE;
            state_step <= 0;

            dm_en_cached <= 0;
            dm_wen_cached <= 0;
            dm_sign_ext_cached <= 0;
            dat_i_cached <= 0;
            width_cached <= 0;
            addr_cached <= dm_addr;

            wb_stb_o <= 0;
            wb_adr_o <= 0;
            wb_dat_o <= 0;
            wb_sel_o <= 0;
            wb_we_o <= 0;
            
        end

        else begin 
            case (state)
                STATE_IDLE: begin
                    if (dm_en && (~same_request)) begin
                        
                        // Cache request body for debouncing
                        addr_cached <= dm_addr;
                        dm_en_cached <= dm_en;
                        dm_wen_cached <= dm_wen;
                        dm_sign_ext_cached <= dm_sign_ext;
                        dat_i_cached <= dm_data_i;
                        width_cached <= dm_width;

                        // State transfer
                        if (dm_wen) begin
                            // Write
                            if (dm_addr[ADDR_WIDTH-1] == 1'b1) begin
                                // SRAM
                                state <= STATE_WRITE_SRAM;

                                wbm_stb_o <= 1;
                                wbm_adr_o <= addr_cached;
                                wbm_we_o <= 1;

                                if (dm_width == 1) begin 
                                    wbm_sel_o <= (4'b0001 << (wbm_dat_i >> (addr_cached & 32'h3)));
                                end 
                                else if (dm_width == 2) begin 
                                    wbm_sel_o <= (4'b0011 << (wbm_dat_i >> (addr_cached & 32'h3)));
                                end
                                else begin
                                    wbm_sel_o <= 4'b1111;
                                end

                            end else begin
                                // UART
                                state <= STATE_WRITE_UART;

                                // Write UART acquire lock
                                wbm_stb_o <= 1;
                                wbm_adr_o <= 32'h10000005;
                                wbm_we_o <= 0;
                                wbm_sel_o <= 4'b1111;
                            end

                        end else begin
                            // Read
                            if (dm_addr[ADDR_WIDTH-1] == 1'b1) begin
                                // SRAM
                                state <= STATE_READ_SRAM;

                                wbm_stb_o <= 1;
                                wbm_adr_o <= addr_cached;
                                wbm_we_o <= 0;
                                wbm_sel_o <= 4'b1111;
                            end else begin
                                // UART
                                state <= STATE_READ_UART;
                                
                                // Read UART acquire lock
                                wbm_stb_o <= 1;
                                wbm_adr_o <= 32'h10000005;
                                wbm_we_o <= 0;
                                wbm_sel_o <= 4'b1111;
                            end
                        end
                    end
                end

                STATE_READ_UART: begin
                    if (state_step == 0) begin
                        // Reading State Reg
                        if (wbm_ack_i) begin
                            wbm_stb_o <= 0;
                            state_step <= 1;
                        end  // else waiting
                    end 
                    
                    else if (state_step == 1) begin
                        // Already read state reg
                        if (wb_dat_i[0]) begin
                            wbm_stb_o <= 1;
                            wbm_adr_o <= 32'h10000000;
                            wbm_we_o <= 0;
                            wbm_sel_o <= 4'b1111;
                            state_step <= 2;
                        end
                        else begin
                            state_step <= 0;
                            wbm_stb_o <= 1;
                            wbm_adr_o <= 32'h10000005;
                            wbm_we_o <= 0;
                            wbm_sel_o <= 4'b1111;
                        end
                    end
                    
                    else if (state_step == 2) begin
                        // Reading data reg
                        if (wbm_ack_i) begin
                            wbm_stb_o <= 0;

                            state <= STATE_IDLE;
                            state_step <= 0;

                            dm_data_o <= wbm_dat_i;
                        end  // else waiting
                    end

                end

                STATE_WRITE_UART: begin
                    if (state_step == 0) begin
                        // Reading State Reg
                        if (wbm_ack_i) begin
                            wbm_stb_o <= 0;
                            wbm_dat_o <= dm_data_i;
                            state_step <= 1;
                        end  // else waiting
                    end 

                    else if (state_step == 1) begin
                        // Already read state reg
                        if (wbm_dat_i[5]) begin
                            wbm_stb_o <= 1;
                            wbm_adr_o <= 32'h10000000;
                            wbm_we_o <= 1;
                            wbm_sel_o <= 4'b0001;
                            state_step <= 2;
                        end
                        else begin
                            state_step <= 0;
                           
                            wbm_stb_o <= 1;
                            wbm_adr_o <= 32'h10000005;
                            wbm_we_o <= 0;
                            wbm_sel_o <= 4'b1111;
                        end
                    end

                    else if (state_step == 2) begin
                        // Reading State Reg
                        if (wbm_ack_i) begin
                            wbm_stb_o <= 0;

                            state <= STATE_IDLE;
                            state_step <= 0;
                        end  // else waiting
                    end
                end

                STATE_READ_SRAM: begin
                    if (wbm_ack_i) begin
                        wbm_stb_o <= 0;
                        state <= STATE_IDLE;
                        state_step <= 0;

                        if (dm_sign_ext) begin
                            if (dm_width == 1) begin
                                dm_data_o <= {
                                    {24{(wbm_dat_i >> (addr_cached & 32'h3))[7]}}, 
                                    (wbm_dat_i >> (addr_cached & 32'h3))[7:0]
                                };
                            end else if (dm_width == 2) begin
                                dm_data_o <= {
                                    {16{(wbm_dat_i >> (addr_cached & 32'h3))[15]}}, 
                                    (wbm_dat_i >> (addr_cached & 32'h3))[15:0]
                                };
                            end else begin
                                dm_data_o <= wbm_dat_i >> (addr_cached & 32'h3);
                            end
                        end else begin
                            if (dm_width == 1) begin
                                dm_data_o <= {
                                    {24{1'b0}}, 
                                    (wbm_dat_i >> (addr_cached & 32'h3))[7:0]
                                };
                            end else if (dm_width == 2) begin
                                dm_data_o <= {
                                    {16{1'b0}}, 
                                    (wbm_dat_i >> (addr_cached & 32'h3))[15:0]
                                };
                            end else begin
                                dm_data_o <= wbm_dat_i >> (addr_cached & 32'h3);
                            end
                        end

                        
                    end
                end

                STATE_WRITE_SRAM: begin
                    if (state_step == 0) begin
                        if (wbm_ack_i) begin
                            wbm_stb_o <= 0;
                            state_step <= 1;
                        end  // else waiting
                    end

                    else if (state_step == 1) begin
                        state <= STATE_IDLE;
                        state_step <= 0;
                    end
                end

            endcase

        end
    end


endmodule