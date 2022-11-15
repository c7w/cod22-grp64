module MMU_cache #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input clk,
    input rst,

    // Cache -> TLB
    output logic cache_ack,
    output logic [DATA_WIDTH-1:0] data_o,

    // TLB -> Cache
    input wire cache_en,
    input wire cache_wen,
    input wire [ADDR_WIDTH-1:0] cache_addr,
    input wire [DATA_WIDTH-1:0] data_i,
    // TODO: add more control signal :)

    // Cache -> Wishbone Master
    output wire wb_cyc_o, 
    output logic wb_stb_o, 
    output logic [ADDR_WIDTH-1:0] wb_adr_o,
    output wire [DATA_WIDTH-1:0] wb_dat_o,
    output wire [DATA_WIDTH/8-1:0] wb_sel_o,
    output wire wb_we_o

    // Wishbone Master -> Cache
    input wire wb_ack_i,
    input wire [DATA_WIDTH-1:0] wb_dat_i
);

    // Buffer
    cache_entry_t cache_table [0:4095];

    // cast cache_addr (logic [31:0]) to cache_query(cache_query_t)
    wire cache_query_t cache_query;
    assign cache_query = cache_addr;

    cache_entry_t cache_entry;
    assign cache_entry = cache_table[cache_query.phys_tag];

    wire cache_hit;
    assign cache_hit = (cache_entry.phys_index == cache_query.phys_index) & cache_entry.valid;


    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < 4096; i = i + 1) begin
                cache_table[i] <= 0;
            end
        end

        else begin
            if (cache_hit) begin
                
            end else begin

            end
        end
    end

endmodule
