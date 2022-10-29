module sram_controller #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,

    parameter SRAM_ADDR_WIDTH = 20,
    parameter SRAM_DATA_WIDTH = 32,

    localparam SRAM_BYTES = SRAM_DATA_WIDTH / 8,
    localparam SRAM_BYTE_WIDTH = $clog2(SRAM_BYTES)
) (
    // clk and reset
    input wire clk_i,  // Use 50M clock! => 20ns
    input wire rst_i,

    // wishbone slave interface
    input wire wb_cyc_i,
    input wire wb_stb_i,
    output reg wb_ack_o,
    input wire [ADDR_WIDTH-1:0] wb_adr_i,
    input wire [DATA_WIDTH-1:0] wb_dat_i,
    output reg [DATA_WIDTH-1:0] wb_dat_o,
    input wire [DATA_WIDTH/8-1:0] wb_sel_i,
    input wire wb_we_i,

    // sram interface
    output reg [SRAM_ADDR_WIDTH-1:0] sram_addr,
    inout wire [SRAM_DATA_WIDTH-1:0] sram_data,
    output reg sram_ce_n,
    output reg sram_oe_n,
    output reg sram_we_n,
    output reg [SRAM_BYTES-1:0] sram_be_n
);

    wire [31:0] sram_data_i;
    wire [31:0] sram_data_o;
    logic [31:0] sram_data_o_reg;
    wire sram_data_t;
    logic sram_data_t_reg;

    assign sram_data = sram_data_t ? 32'bz : sram_data_o;
    assign sram_data_o = sram_data_o_reg;
    assign sram_data_i = sram_data;
    assign sram_data_t = sram_data_t_reg;

    typedef enum logic [2:0] {
        STATE_IDLE = 0,
        STATE_READ = 1,
        STATE_READ_2 = 2,
        STATE_WRITE = 3,
        STATE_WRITE_2 = 4,
        STATE_WRITE_3 = 5,
        STATE_DONE = 6
    } state_t;
    
    state_t state;

    logic [ADDR_WIDTH-1:0] wb_adr_i_cache;
    logic [DATA_WIDTH-1:0] wb_dat_i_cache;
    logic [DATA_WIDTH/8-1:0] wb_sel_i_cache;
    logic wb_we_i_cache;

    always @(posedge clk_i, posedge rst_i) begin
        if (rst_i) begin
            state <= STATE_IDLE;
        
            wb_ack_o <= 0;
            wb_dat_o <= 0; 
            sram_addr <= 0;
            sram_ce_n <= 1;
            sram_oe_n <= 1;
            sram_we_n <= 1;
            sram_be_n <= 0;

            wb_adr_i_cache <= 0;
            wb_dat_i_cache <= 0;
            wb_sel_i_cache <= 0;
            wb_we_i_cache <= 0;

        end else begin
            case (state) 
                STATE_IDLE: begin
                    if (wb_stb_i && wb_cyc_i) begin

                        if ((wb_adr_i == wb_adr_i_cache) && (wb_dat_i == wb_dat_i_cache) && (wb_sel_i == wb_sel_i_cache) && (wb_we_i == wb_we_i_cache)) begin
                            // Same request. Ignore it.
                        end else begin

                            if(wb_we_i) begin
                                state <= STATE_WRITE;
                                sram_be_n <= ~wb_sel_i;
                                sram_data_o_reg <= wb_dat_i;  
                                sram_data_t_reg <= 0;
                            end else if (~wb_we_i) begin
                                state <= STATE_READ;
                                sram_oe_n <= 0;
                                sram_be_n <= 0; 
                                sram_data_t_reg <= 1;
                            end
                            sram_addr <= wb_adr_i >> 2; 
                            sram_ce_n <= 0;

                            // Save request body for debouncing
                            wb_adr_i_cache <= wb_adr_i;
                            wb_dat_i_cache <= wb_dat_i;
                            wb_sel_i_cache <= wb_sel_i;
                            wb_we_i_cache <= wb_we_i;
                            
                            // Start to request!
                            wb_ack_o <= 0;
                        end

                    end else begin
                        wb_ack_o <= 0;
                    end
                
                end
                
                STATE_READ: begin
                    state <= STATE_READ_2; // Wait
                end
                
                STATE_READ_2: begin
                    wb_dat_o <= sram_data_i; 
                    wb_ack_o <= 1;
                    sram_ce_n <= 1;
                    sram_oe_n <= 1;
                    state <= STATE_IDLE;
                end
                
                STATE_WRITE: begin
                    state <= STATE_WRITE_2;
                    sram_we_n <= 0;
                end
                
                STATE_WRITE_2: begin
                    state <= STATE_WRITE_3;
                    sram_we_n <= 1;
                end
                
                STATE_WRITE_3: begin
                    sram_ce_n <= 1;
                    wb_ack_o <= 1;
                    state <= STATE_IDLE;
                end
            
            endcase
        end
    
    end
endmodule
