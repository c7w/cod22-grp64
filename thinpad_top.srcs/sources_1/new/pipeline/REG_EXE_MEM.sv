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
    input wire [2:0] dm_width_i,
    input wire dm_sign_ext_i,
    input wire [`DM_MUX_WIDTH-1:0] dm_mux_ctr_i,
    input wire [DATA_WIDTH-1:0] rf_data_b_i,
    input wire tlb_flush_i,
    input wire drain_pipeline_i,
    input wire fence_i_i,
    
    output reg [ADDR_WIDTH-1:0] pc_addr_o,
    output reg [DATA_WIDTH-1:0] alu_out_o,
    output reg dm_en_o,
    output reg dm_wen_o,
    output reg [2:0] dm_width_o,
    output reg dm_sign_ext_o,
    output reg [`DM_MUX_WIDTH-1:0] dm_mux_ctr_o,
    output reg [DATA_WIDTH-1:0] rf_data_b_o,
    output reg tlb_flush_o,
    output reg drain_pipeline_o,
    output reg fence_i_o,

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
            dm_en_o <= 0; dm_wen_o <= 0; 
            dm_width_o <= 4; dm_sign_ext_o <= 1;
            dm_mux_ctr_o <= `DM_MUX_ALU; 
            rf_data_b_o <= 0;
            tlb_flush_o <= 0; drain_pipeline_o <= 0; fence_i_o <= 0;

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
                    dm_width_o <= 4; dm_sign_ext_o <= 1;
                    dm_en_o <= 0; dm_wen_o <= 0; dm_mux_ctr_o <= `DM_MUX_ALU; rf_data_b_o <= 0;

                    tlb_flush_o <= 0; drain_pipeline_o <= 0; fence_i_o <= 0;

                    wb_en_o <= 0; // wb_addr_o <= 0; wb_data_o <= 0;
                end else begin

                    rd_o <= rd_i;

                    // normal
                    pc_addr_o <= pc_addr_i;
                    alu_out_o <= alu_out_i;
                    dm_en_o <= dm_en_i;
                    dm_wen_o <= dm_wen_i;
                    dm_width_o <= dm_width_i;
                    dm_sign_ext_o <= dm_sign_ext_i;
                    dm_mux_ctr_o <= dm_mux_ctr_i;
                    rf_data_b_o <= rf_data_b_i;
                    wb_en_o <= wb_en_i;


                    tlb_flush_o <= tlb_flush_i; 
                    drain_pipeline_o <= drain_pipeline_i; 
                    fence_i_o <= fence_i_i;

                    // wb_addr_o <= wb_addr_i;
                    // wb_data_o <= wb_data_i;
                end
            end

        end
        
    end

    

endmodule
