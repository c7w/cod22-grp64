module CONTROLLER_pipeline #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
)(

    input wire dm_ack,

    input wire [4:0] ID_rs1,
    input wire [4:0] ID_rs2,
    input wire [4:0] EXE_rd,
    input wire EXE_wb_en,
    input wire [4:0] DM_rd,
    input wire DM_wb_en,
    input wire [4:0] WB_rd,
    input wire WB_wb_en,

    input wire bc_comp_result,
    input wire [ADDR_WIDTH-1:0] EXE_pc_addr,
    input wire [ADDR_WIDTH-1:0] EXE_pc_addr_calculated,  // ALU_out
    input wire [ADDR_WIDTH-1:0] EXE_pc_addr_predicted, // ID_pc_addr

    output wire branching,
    output wire[3:0] stall_o,
    output wire[3:0] bubble_o
);

    wire is_write_EXE = EXE_wb_en && (EXE_rd != 0) && (EXE_rd == ID_rs1 || EXE_rd == ID_rs2);
    wire is_write_DM = DM_wb_en && (DM_rd != 0) && (DM_rd == ID_rs1 || DM_rd == ID_rs2);
    wire is_write_WB = WB_wb_en && (WB_rd != 0) && (WB_rd == ID_rs1 || WB_rd == ID_rs2);

    wire stall_ID = is_write_EXE || is_write_DM || is_write_WB;
    
    // Stall the whole pipeline if DM is not responding
    wire stall_DM = ~dm_ack;

    wire [ADDR_WIDTH-1:0] pc_addr_right;

    always_comb begin
        if (bc_comp_result) begin
            pc_addr_right = EXE_pc_addr_calculated;
        end

        else begin  
            pc_addr_right = EXE_pc_addr + 4;
        end
    end

    assign branching = (pc_addr_right != EXE_pc_addr_predicted);

    always_comb begin
        stall_o = 4'b0000;
        bubble_o = 4'b0000;

        if (stall_DM) begin
            stall_o = 4'b1111;
            bubble_o = 0001;
        end

        else if (stall_ID) begin
            stall_o = 4'b1100;
            bubble_o = 4'b0100;
        end

        else if (branching) begin
            stall_o = 4'b0000;
            bubble_o = 4'b1110; // Bubble 
        end

    end


endmodule