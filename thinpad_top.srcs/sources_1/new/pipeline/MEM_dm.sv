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
    output logic [DATA_WIDTH-1:0] dm_data_o,

    // Wishbone master
    output wire wbm_cyc_o,
    output reg wbm_stb_o,
    input wire wbm_ack_i,
    output reg[3:0] wbm_sel_o,
    output reg[ADDR_WIDTH-1:0] wbm_adr_o,
    input wire [DATA_WIDTH-1:0] wbm_dat_i,
    output reg[DATA_WIDTH-1:0] wbm_dat_o,
    output reg wbm_we_o,

    // mtimer
    input wire [63:0] mtimer_mtime,
    input wire [63:0] mtimer_mtimecmp,
    output logic mtimer_mtime_wen, 
    output logic mtimer_mtimecmp_wen, 
    output logic mtimer_upper_wen,
    output logic [31:0] mtimer_wdata
);

    assign wbm_cyc_o = wbm_stb_o;

    // State
    typedef enum logic[3:0] {
        STATE_IDLE,
        STATE_READ,
        STATE_WRITE
    } state_t;
    state_t state;

    logic dm_en_cached, dm_wen_cached, dm_sign_ext_cached;
    logic [ADDR_WIDTH-1:0] addr_cached;
    logic [DATA_WIDTH-1:0] dat_i_cached;
    logic [2:0] width_cached;

    wire same_request;
    assign same_request = (dm_en == dm_en_cached) && (dm_wen == dm_wen_cached) && (dm_sign_ext == dm_sign_ext_cached) && (dm_addr == addr_cached) && (dm_data_i == dat_i_cached) && (dm_width == width_cached);

    logic dm_ack_cache;

    logic mtimer_lock;  // reg
    logic [DATA_WIDTH-1:0] mtimer_rdata;  // comb

    // TODO: May be buggy?
    assign dm_ack = ((wbm_ack_i || dm_ack_cache) && same_request) || ~dm_en;

    
    // Start: Generate dm_data_o
    logic [DATA_WIDTH-1:0] dm_data_o_cached;
    always_comb begin
        if (wbm_ack_i) begin
            if (width_cached == 1) begin
                dm_data_o = {
                    {24{1'b0}}, 
                    data_shifted[7:0]
                };
            end else if (width_cached == 2) begin
                dm_data_o = {
                    {16{1'b0}}, 
                    data_shifted[15:0]
                };
            end else begin
                dm_data_o = data_shifted;
            end
        end else if (dm_ack) begin
            dm_data_o = dm_data_o_cached;
        end else begin
            dm_data_o = 32'h0;  // Check for this carefully
        end
    end
    // End: Generate dm_data_o

    
    wire [5:0] offset;
    assign offset = addr_cached & 32'h00000003;

    wire [DATA_WIDTH-1:0] data_shifted;
    assign data_shifted = wbm_dat_i >> (offset << 3);

    always_ff @ (posedge clk) begin
        if (rst) begin
            state <= STATE_IDLE;
            dm_ack_cache <= 0;

            dm_en_cached <= 0;
            dm_wen_cached <= 0;
            dm_sign_ext_cached <= 0;
            dat_i_cached <= 0;
            width_cached <= 0;
            addr_cached <= dm_addr;

            wbm_stb_o <= 0;
            wbm_adr_o <= 0;
            wbm_dat_o <= 0;
            wbm_sel_o <= 0;
            wbm_we_o <= 0;
            
            mtimer_lock <= 0;
            
        end

        else begin 
            case (state)
                STATE_IDLE: begin
                    if (dm_en) begin
                        
                        // Cache request body for debouncing
                        addr_cached <= dm_addr;
                        dm_en_cached <= dm_en;
                        dm_wen_cached <= dm_wen;
                        dm_sign_ext_cached <= dm_sign_ext;
                        dat_i_cached <= dm_data_i;
                        width_cached <= dm_width;

                        

                        // State transfer

                        if (dm_addr == 32'h200bff8 || dm_addr == 32'h200bffc || dm_addr == 32'h2004000 || dm_addr == 32'h2004004) begin
                            dm_ack_cache <= 1;

                            if (mtimer_lock == 0) begin
                                mtimer_lock <= 1;
                                dm_data_o_cached <= mtimer_rdata;

                            end else begin
                                mtimer_lock <= 0;
                            end
                            

                        end else begin
                            dm_ack_cache <= 0;
                            if (dm_wen) begin
                                // Write
                                state <= STATE_WRITE;

                                wbm_stb_o <= 1;
                                wbm_adr_o <= dm_addr;
                                wbm_dat_o <= dm_data_i;
                                wbm_we_o <= 1;

                                if (dm_width == 1) begin 
                                    wbm_sel_o <= (4'b0001 << (dm_addr & 2'h3));
                                end 
                                else if (dm_width == 2) begin 
                                    wbm_sel_o <= (4'b0011 << (dm_addr & 2'h3));
                                end
                                else begin
                                    wbm_sel_o <= 4'b1111;
                                end


                            end else begin
                                // Read
                                state <= STATE_READ;

                                wbm_stb_o <= 1;
                                wbm_adr_o <= dm_addr;
                                wbm_we_o <= 0;
                                wbm_sel_o <= 4'b1111;
                            end 
                        end
                    end
                end

                STATE_READ: begin
                    if (wbm_ack_i) begin
                        wbm_stb_o <= 0;
                        state <= STATE_IDLE;
                        dm_ack_cache <= dm_ack_cache || wbm_ack_i;

                        if (dm_sign_ext) begin
                            if (width_cached == 1) begin
                                dm_data_o_cached <= {
                                    {24{data_shifted[7]}}, 
                                    data_shifted[7:0]
                                };
                            end else if (width_cached == 2) begin
                                dm_data_o_cached <= {
                                    {16{data_shifted[15]}}, 
                                    data_shifted[15:0]
                                };
                            end else begin
                                dm_data_o_cached <= data_shifted;
                            end
                        end else begin
                            if (width_cached == 1) begin
                                dm_data_o_cached <= {
                                    {24{1'b0}}, 
                                    data_shifted[7:0]
                                };
                            end else if (width_cached == 2) begin
                                dm_data_o_cached <= {
                                    {16{1'b0}}, 
                                    data_shifted[15:0]
                                };
                            end else begin
                                dm_data_o_cached <= data_shifted;
                            end
                        end

                        
                    end
                end

                STATE_WRITE: begin
                    if (wbm_ack_i) begin
                        wbm_stb_o <= 0;
                        state <= STATE_IDLE;
                        dm_ack_cache <= dm_ack_cache || wbm_ack_i;
                    end  // else waiting
                end

            endcase

        end
    end

    always_comb begin
        // mtimer logic
        mtimer_rdata = 32'h0;
        mtimer_mtime_wen = 0;
        mtimer_mtimecmp_wen = 0;
        mtimer_upper_wen = 0;

        if (dm_wen) begin
            if (mtimer_lock == 0) begin
                case (dm_addr) 
                    32'h200bff8: mtimer_mtime_wen = 1;
                    32'h200bffc: begin 
                        mtimer_mtime_wen = 1;
                        mtimer_upper_wen = 1;
                    end
                    32'h2004000: mtimer_mtimecmp_wen = 1;
                    32'h2004004: begin
                        mtimer_mtimecmp_wen = 1;
                        mtimer_upper_wen = 1;
                    end
                endcase
            end
        end

        else begin

            case (dm_addr) 
                32'h200bff8: mtimer_rdata = mtimer_mtime[31:0];
                32'h200bffc: mtimer_rdata = mtimer_mtime[63:32];
                32'h2004000: mtimer_rdata = mtimer_mtimecmp[31:0];
                32'h2004004: mtimer_rdata = mtimer_mtimecmp[63:32];
            endcase
        end
    end

    assign mtimer_wdata = dm_data_i;


endmodule
