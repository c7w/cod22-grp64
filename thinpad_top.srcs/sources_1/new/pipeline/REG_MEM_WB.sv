module REG_MEM_WB #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    input wire bubble, // freeze status

    // MEM -> WB
    input wire wb_en_i, // write back enabled
    input wire[4:0] wb_addr_i,
    input wire[DATA_WIDTH-1:0] wb_data_i,
    input wire drain_pipeline_i,
    input wire fence_i_i,


    output reg wb_en_o,
    output reg[4:0] wb_addr_o,
    output reg[DATA_WIDTH-1:0] wb_data_o,
    output reg drain_pipeline_o,
    output reg fence_i_o
);

    always_ff @( posedge clk ) begin : blockName
        if (rst) begin
            // NOP
            wb_en_o <= 0;
            wb_addr_o <= 0;
            wb_data_o <= 0;
            drain_pipeline_o <= 0;
            fence_i_o <= 0;
        end
        else begin
            if (~bubble) begin
                wb_en_o <= wb_en_i;
                wb_addr_o <= wb_addr_i;
                wb_data_o <= wb_data_i;
                drain_pipeline_o <= drain_pipeline_i;   
                fence_i_o <= fence_i_i;         
            end else begin
                wb_en_o <= 0;
                wb_addr_o <= 0;
                wb_data_o <= 0;
                drain_pipeline_o <= 0;
                fence_i_o <= 0;
            end
        end
    end



endmodule