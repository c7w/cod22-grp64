`include "../headers/ctrl.vh"
`include "../headers/branch_comp.vh"

module CONTROLLER_pipeline #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire im_ack,
    input wire dm_ack,

    input wire data_hazard,
    input wire [4:0] ID_rs1,
    input wire [4:0] ID_rs2,
    input wire [4:0] EXE_rd,
    input wire EXE_wb_en,
    input wire [4:0] DM_rd,
    input wire DM_wb_en,
    input wire [4:0] WB_rd,
    input wire WB_wb_en,

    input wire [ADDR_WIDTH-1:0] pc_nxt_exception,
    input wire [3:0] CONTROLLER_csr_transfer_state,
    input wire bc_comp_result,
    input wire [ADDR_WIDTH-1:0] EXE_pc_addr,
    input wire [`PC_MUX_WIDTH-1:0] EXE_pc_mux_ctr,
    input wire [ADDR_WIDTH-1:0] EXE_pc_addr_calculated,  // ALU_out
    input wire [ADDR_WIDTH-1:0] ID_pc_addr, // ID_pc_addr
    input wire [ADDR_WIDTH-1:0] IF_pc_addr, // ID_pc_addr

    input wire IF_drain_pipeline,
    input wire ID_drain_pipeline,
    input wire EXE_drain_pipeline,
    input wire MEM_drain_pipeline,
    input wire WB_drain_pipeline,

    output logic branching,
    output logic[3:0] stall_o,
    output logic[3:0] bubble_o,
    output logic [ADDR_WIDTH-1:0] pc_addr_right
);

    // wire is_write_EXE;
    // assign is_write_EXE = EXE_wb_en && (EXE_rd != 0) && (EXE_rd == ID_rs1 || EXE_rd == ID_rs2);
    // wire is_write_DM;
    // assign is_write_DM = DM_wb_en && (DM_rd != 0) && (DM_rd == ID_rs1 || DM_rd == ID_rs2);
    // wire is_write_WB;
    // assign is_write_WB = WB_wb_en && (WB_rd != 0) && (WB_rd == ID_rs1 || WB_rd == ID_rs2);

    // wire stall_ID = is_write_EXE || is_write_DM || is_write_WB;
    wire stall_ID = data_hazard;
    
    // Stall the whole pipeline if DM is not responding
    wire stall_DM;
    assign stall_DM = ~dm_ack;

    wire stall_IM;
    assign stall_IM = ~im_ack;

    wire drain_pipeline;
    assign drain_pipeline = ID_drain_pipeline | EXE_drain_pipeline | MEM_drain_pipeline | WB_drain_pipeline;

    always_comb begin

        if (CONTROLLER_csr_transfer_state == 2) begin
            pc_addr_right = pc_nxt_exception;
        end

        else if ((EXE_pc_mux_ctr == `PC_MUX_BRANCH) && bc_comp_result) begin
            pc_addr_right = EXE_pc_addr_calculated;
        end

        else begin  
            pc_addr_right = EXE_pc_addr + 4;
        end
    end

    assign branching = ((EXE_pc_addr != 0) && ~( ID_pc_addr == pc_addr_right || (ID_pc_addr == 0 && IF_pc_addr == pc_addr_right) )) || (CONTROLLER_csr_transfer_state == 2);

    always_comb begin
        stall_o = 4'b0000;
        bubble_o = 4'b0000;


        if (CONTROLLER_csr_transfer_state == 1) begin
            // Drain the whole pipeline
            stall_o = 4'b1000;
            bubble_o = 4'b1100;
        end

        if (stall_DM) begin
            stall_o = 4'b1111;
            bubble_o = 4'b0001;
        end

        else if (branching) begin
            stall_o = 4'b0000;
            bubble_o = 4'b1100; // Bubble 
        end

        else if (stall_ID) begin
            stall_o = 4'b1100;
            bubble_o = 4'b0100;
        end

        else if (stall_IM) begin
            stall_o = 4'b1000;
            bubble_o = 4'b1000;

        end else if (drain_pipeline) begin
 
            stall_o = 4'b1000;
            bubble_o = 4'b1000;

        end

    end


endmodule