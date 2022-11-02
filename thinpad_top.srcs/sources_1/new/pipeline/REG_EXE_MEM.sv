module REG_EXE_MEM #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    input wire stall, // freeze status
    input wire bubble, // bubble status
    
    input wire [4:0] rd_i,
    output reg [4:0] rd_o, 

    // EXE -> MEM
    input wire[ADDR_WIDTH-1:0] pc_addr_i,
    input wire [DATA_WIDTH-1:0] alu_out_i,
    input wire dm_en_i,
    input wire dm_wen_i,
    input wire [`DM_MUX_WIDTH-1:0] dm_mux_ctr_i,
    input wire [DATA_WIDTH-1:0] rf_data_b_i,
    
    output reg [ADDR_WIDTH-1:0] pc_addr_o,
    output reg [DATA_WIDTH-1:0] alu_out_o,
    output reg dm_en_o,
    output reg dm_wen_o,
    output reg [`DM_MUX_WIDTH-1:0] dm_mux_ctr_o,
    output reg [DATA_WIDTH-1:0] rf_data_b_o,


    // MEM -> WB
    input wire wb_en_i, // write back enabled
    // input wire[ADDR_WIDTH-1:0] wb_addr_i,
    // input wire[DATA_WIDTH-1:0] wb_data_i,

    output reg wb_en_o
    // output reg[ADDR_WIDTH-1:0] wb_addr_o,
    // output reg[DATA_WIDTH-1:0] wb_data_o
);
    
    always_ff @(posedge clk) begin
        if (rst) begin
            
            rd_o <= 0;

            // bubble : mem
            pc_addr_o <= 0; alu_out_o <= 0;
            dm_en_o <= 0; dm_wen_o <= 0; dm_mux_ctr_o <= `DM_MUX_ALU; 
            rf_data_b_o <= 0;
            
            // bubble : wb
            wb_en_o <= 0; // wb_addr_o <= 0; wb_data_o <= 0;
        end

        else begin

            if (stall) begin
                // stall: lock state
                // do nothing :)
            end else begin
                if (bubble) begin

                    rd_o <= 0;

                    // bubble
                    pc_addr_o <= 0; alu_out_o <= 0;
                    dm_en_o <= 0; dm_wen_o <= 0; dm_mux_ctr_o <= `DM_MUX_ALU; rf_data_b_o <= 0;
                    wb_en_o <= 0; // wb_addr_o <= 0; wb_data_o <= 0;
                end else begin

                    rd_o <= rd_i;

                    // normal
                    pc_addr_o <= pc_addr_i;
                    alu_out_o <= alu_out_i;
                    dm_en_o <= dm_en_i;
                    dm_wen_o <= dm_wen_i;
                    dm_mux_ctr_o <= dm_mux_ctr_i;
                    rf_data_b_o <= rf_data_b_i;
                    wb_en_o <= wb_en_i;
                    // wb_addr_o <= wb_addr_i;
                    // wb_data_o <= wb_data_i;
                end
            end

        end
        
    end

    

endmodule
