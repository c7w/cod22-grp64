module MMU_cache #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter CACHE_SIZE = 64
) (
    input wire clk,
    input wire rst,

    // Cache -> TLB
    output logic cache_ack,
    output logic [DATA_WIDTH-1:0] data_o,

    // TLB -> Cache
    input wire cache_en,
    input wire cache_wen,
    input wire [2:0] cache_width,
    input wire cache_sign_ext,
    input wire [ADDR_WIDTH-1:0] cache_addr,
    input wire [DATA_WIDTH-1:0] data_i,

    input wire fence_i,
    input wire fence_i_wb,


    // Cache -> Translation Unit
    input wire [ADDR_WIDTH-1:0] translation_unit_request_addr,

    // Translation Unit -> Cache
    output logic translation_unit_request_valid,
    output logic [DATA_WIDTH-1:0] translation_unit_request_data,


    // Cache -> Wishbone Master
    output wire wb_cyc_o, 
    output logic wb_stb_o, 
    output logic [ADDR_WIDTH-1:0] wb_adr_o,
    output logic [DATA_WIDTH-1:0] wb_dat_o,
    output logic [DATA_WIDTH/8-1:0] wb_sel_o,
    output logic wb_we_o,

    // Wishbone Master -> Cache
    input wire wb_ack_i,
    input wire [DATA_WIDTH-1:0] wb_dat_i
);

    // Buffer
    cache_entry_t cache_table [0:CACHE_SIZE-1];

    // cast cache_addr (logic [31:0]) to cache_query(cache_query_t)
    cache_query_t cache_query, translation_query, wb_adr_o_query;
    assign cache_query = cache_addr;
    assign translation_query = translation_unit_request_addr;
    assign wb_adr_o_query = wb_adr_o;

    cache_entry_t cache_entry, translation_entry;
    assign cache_entry = cache_table[cache_query.phys_tag];
    assign translation_entry = cache_table[translation_query.phys_tag];

    wire cache_hit;
    assign cache_hit = (cache_entry.phys_index == cache_query.phys_index) & cache_entry.valid;
    
    assign translation_unit_request_valid = (translation_entry.phys_index == translation_query.phys_index) & translation_entry.valid;
    assign translation_unit_request_data = translation_entry.data; 

    // Phys addr for cache_entry
    logic [ADDR_WIDTH-1:0] cache_entry_phys_addr;
    always_comb begin
        cache_entry_phys_addr = {cache_entry.phys_index, cache_query.phys_tag, 2'b00};
    end


    // Addr offset
    wire [5:0] offset;
    assign offset = cache_addr[5:0] & 6'h03;

    logic [DATA_WIDTH-1:0] hit_dat_i_shifted;
    always_comb begin
        if (wb_ack_i) begin
            hit_dat_i_shifted = wb_dat_i >> (offset << 3);
        end else if (cache_hit) begin
            hit_dat_i_shifted = cache_entry.data >> (offset << 3);
        end else begin
            hit_dat_i_shifted = 32'hffffffff;
        end
    end

    // Assemble data from hit data, cache_width and cache_sign_ext (Read)
    logic [DATA_WIDTH-1:0] hit_dat_i_assembled;
    always_comb begin
        case (cache_width)
            1: begin
                if (cache_sign_ext) begin
                    hit_dat_i_assembled = {{24{hit_dat_i_shifted[7]}}, hit_dat_i_shifted[7:0]};
                end else begin
                    hit_dat_i_assembled = {{24{1'b0}}, hit_dat_i_shifted[7:0]};
                end
            end
            2: begin
                if (cache_sign_ext) begin
                    hit_dat_i_assembled = {{16{hit_dat_i_shifted[15]}}, hit_dat_i_shifted[15:0]};
                end else begin
                    hit_dat_i_assembled = {{16{1'b0}}, hit_dat_i_shifted[15:0]};
                end
            end
            4: begin
                hit_dat_i_assembled = {hit_dat_i_shifted[31:0]};
            end
            default: begin
                hit_dat_i_assembled = 32'hbcbcbcbc;
            end
        endcase
    end

    // Assemble data for writing to cache (when write back, just give a sel_o 1111)
    logic [DATA_WIDTH-1:0] dat_to_save;
    always_comb begin
        if (cache_en & cache_wen & cache_hit) begin
            case (cache_width) 
                1: begin
                    case (offset) 
                        0: begin
                            dat_to_save = {cache_entry.data[31:8], data_i[7:0]};
                        end
                        1: begin
                            dat_to_save = {cache_entry.data[31:16], data_i[7:0], cache_entry.data[7:0]};
                        end
                        2: begin
                            dat_to_save = {cache_entry.data[31:24], data_i[7:0], cache_entry.data[15:0]};
                        end
                        3: begin
                            dat_to_save = {data_i[7:0], cache_entry.data[23:0]};
                        end
                    endcase
                end
                2: begin
                    if (offset == 0) begin
                        dat_to_save = {cache_entry.data[31:16], data_i[15:0]};
                    end else if (offset == 2) begin
                        dat_to_save = {data_i[15:0], cache_entry.data[15:0]};
                    end else begin
                        // Raise exception: alignment
                        // Well, may do this check in ID stage :)
                    end
                end
                4: begin
                    dat_to_save = data_i;
                end
                default: begin
                    dat_to_save = 32'hffffffff;
                end
            endcase
        end else begin
            dat_to_save = 32'hffffffff;
        end
    end

    logic cache_ack_fence_i;
    logic [7:0] fence_i_stage;

    // Cache -> TLB
    always_comb begin
        cache_ack = 1'b0; data_o = 32'hadadadad;
        
        if (fence_i) begin
            if (~fence_i_wb) begin
                cache_ack = 1'b1;
            end else begin
                cache_ack = cache_ack_fence_i;
            end

        end else if (~cache_en) begin
            cache_ack = 1'b1;
        end else begin
            if (~cache_wen) begin
                cache_ack = cache_hit | (wb_ack_i & state != STATE_WRITE_BACK & (wb_adr_o == cache_addr));
                data_o = hit_dat_i_assembled;
            end else begin
                cache_ack = cache_hit;
            end
        end
    end


    // Cache -> Wishbone master
    typedef enum logic [3:0] { 
        STATE_IDLE,
        STATE_WRITE_BACK,
        STATE_WRITE_BACK_NXT,
        STATE_LOAD,
        STATE_LOAD_NXT,
        STATE_WRITE_BACK_FENCE,
        STATE_WRITE_BACK_FENCE_NXT
    } state_t;
    state_t state;

    assign wb_cyc_o = wb_stb_o;  
    // output logic wb_stb_o, // reg 
    // output logic [ADDR_WIDTH-1:0] wb_adr_o,  // reg
    // output wire [DATA_WIDTH-1:0] wb_dat_o,  // reg
    assign wb_sel_o = 4'b1111;
    //  wb_we_o // reg


    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < CACHE_SIZE; i = i + 1) begin
                cache_table[i] <= 0;
            end
            state <= STATE_IDLE;
            wb_stb_o <= 0;
            wb_adr_o <= 0;
            wb_dat_o <= 0;
            wb_we_o <= 0;

            cache_ack_fence_i <= 0;
            fence_i_stage <= 0;
        end
 
        else begin

            if (fence_i & ~cache_ack_fence_i) begin
                if (~fence_i_wb) begin
                    // Reset cache table
                    for (integer i = 0; i < CACHE_SIZE; i = i + 1) begin
                        cache_table[i] <= 0;
                    end
                end else begin

                    if (fence_i_stage == CACHE_SIZE) begin
                        fence_i_stage <= 0;
                        cache_ack_fence_i <= 1;
                    end else begin

                        if (state == STATE_IDLE) begin
                            /* verilator lint_off WIDTH */
                            if (cache_table[fence_i_stage].valid & cache_table[fence_i_stage].dirty) begin
                            /* verilator lint_on WIDTH */
                                state <= STATE_WRITE_BACK_FENCE;
                                wb_stb_o <= 1;
                                wb_adr_o <= {
                                    /* verilator lint_off WIDTH */
                                    cache_table[fence_i_stage].phys_index, 
                                    /* verilator lint_on WIDTH */
                                    fence_i_stage[5:0], 
                                    2'b00};
                                    
                                /* verilator lint_off WIDTH */
                                wb_dat_o <= cache_table[fence_i_stage].data;
                                /* verilator lint_on WIDTH */
                                wb_we_o <= 1;
                            end else begin 
                                // Go to next index
                                fence_i_stage <= fence_i_stage + 1;
                            end
                        end else if (state == STATE_WRITE_BACK_FENCE) begin
                            if (wb_ack_i) begin
                                wb_stb_o <= 0;
                                state <= STATE_IDLE;
                                /* verilator lint_off WIDTH */
                                cache_table[fence_i_stage].dirty <= 0;
                                /* verilator lint_on WIDTH */
                                fence_i_stage <= fence_i_stage + 1;
                            end
                        end

                        
                    end

                end
            end

            else begin

                cache_ack_fence_i <= 0;

                if (state == STATE_IDLE) begin
                    if (cache_en) begin

                        if (cache_hit && cache_wen) begin
                            cache_table[cache_query.phys_tag].data <= dat_to_save;
                            cache_table[cache_query.phys_tag].dirty <= 1'b1;
                        
                        end else if (~cache_hit) begin

                            // Replace cache
                            if (cache_entry.valid && cache_entry.dirty) begin
                                // Write Back
                                state <= STATE_WRITE_BACK;
                                wb_stb_o <= 1;
                                wb_adr_o <= cache_entry_phys_addr & ~32'h3;
                                wb_dat_o <= cache_entry.data;
                                wb_we_o <= 1;

                            end else begin
                                // Reload
                                state <= STATE_LOAD;
                                wb_stb_o <= 1;
                                wb_adr_o <= cache_addr & ~32'h3;
                                wb_dat_o <= 32'hacacacac;
                                wb_we_o <= 0;
                            end

                        end

                    end
                end

                else if (state == STATE_WRITE_BACK) begin
                    if (wb_ack_i) begin
                        wb_stb_o <= 0;
                        state <= STATE_WRITE_BACK_NXT;
                    end
                end

                else if (state == STATE_WRITE_BACK_NXT) begin
                    wb_stb_o <= 1;
                    wb_adr_o <= cache_addr & ~32'h3;
                    wb_dat_o <= 32'hacacacac;
                    wb_we_o <= 0;
                    state <= STATE_LOAD;
                end

                else if (state == STATE_LOAD) begin
                    if (wb_ack_i) begin


                        cache_table[wb_adr_o_query.phys_tag].valid <= 1'b1;
                        cache_table[wb_adr_o_query.phys_tag].data <= wb_dat_i;
                        cache_table[wb_adr_o_query.phys_tag].dirty <= 1'b0;
                        cache_table[wb_adr_o_query.phys_tag].phys_index <= wb_adr_o_query.phys_index;

                        wb_stb_o <= 0;
                        state <= STATE_IDLE;

                    end
                end

            end


        end


    end

endmodule
