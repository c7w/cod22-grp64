`include "../headers/exception.svh"
module IF_BTB #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    // Read
    input wire [ADDR_WIDTH-1:0] curr_pc_addr,
    output logic [ADDR_WIDTH-1:0] predicted_pc_addr,

    // Write
    input wire [ADDR_WIDTH-1:0] exe_pc_addr,
    input wire [ADDR_WIDTH-1:0] target_pc_addr,
    input wire branching
);

    btbe_t btb_table [0:15];  // branch target buffer table

    // Read
    btb_query_t read_query;
    assign read_query = curr_pc_addr;
    
    btbe_t read_entry;
    assign read_entry = btb_table[read_query.index];
    
    wire read_hit;
    assign read_hit = read_entry.valid & (read_entry.tag_from == read_query.tag);

    // Write
    btb_query_t write_query;
    assign write_query = exe_pc_addr;
    
    btb_query_t target_key;
    assign target_key = target_pc_addr;
    

    always_comb begin
        predicted_pc_addr = curr_pc_addr + 4;
        if (read_hit) begin
            predicted_pc_addr = {read_entry.tag_to, read_entry.index_to, 2'b00};
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            for (integer i = 0; i < 16; i = i + 1) begin
                btb_table[i] <= 0;
            end
        end

        else begin

            if (branching) begin
                // Write
                btb_table[write_query.index].tag_from <= write_query.tag;
                btb_table[write_query.index].tag_to <= target_key.tag;
                btb_table[write_query.index].index_to <= target_key.index;
                btb_table[write_query.index].valid <= 1;
            end

        end
    end

endmodule