`include "../headers/ctrl.vh"
module CONTROLLER_bypassing_unit #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    // Pure combinational

    // IF_ID -> Bypassing Unit
    input wire [4:0] req_rs1,
    input wire [4:0] req_rs2,

    // Bypassing Unit -> ID_EXE
    output logic [DATA_WIDTH-1:0] req_data1,
    output logic [DATA_WIDTH-1:0] req_data2,

    // Bypassing Unit -> RF
    output logic [4:0] rf_rs1,
    output logic [4:0] rf_rs2,

    // RF -> Bypassing Unit
    input wire [DATA_WIDTH-1:0] rf_data1,
    input wire [DATA_WIDTH-1:0] rf_data2,

    // Bypassing Unit -> Controller
    output logic data_hazard,  // If hazard, then stall the whole pipeline

    // EXE Stage -> Bypassing Unit
    input wire [`DM_MUX_WIDTH-1:0] exe_dm_mux,
    input wire exe_wb_en,
    input wire [4:0] exe_rd,
    input wire [DATA_WIDTH-1:0] exe_bypassing_data_pc_addr,
    input wire [DATA_WIDTH-1:0] exe_bypassing_data_alu,

    // MEM Stage -> Bypassing Unit
    input wire [`DM_MUX_WIDTH-1:0] mem_dm_mux,
    input wire mem_wb_en,
    input wire [4:0] mem_rd,
    input wire [DATA_WIDTH-1:0] mem_bypassing_data_pc_addr,
    input wire [DATA_WIDTH-1:0] mem_bypassing_data_alu,
    input wire [DATA_WIDTH-1:0] mem_bypassing_data_dm,
    input wire mem_bypassing_data_dm_valid,

    // WB Stage -> Bypassing Unit
    input wire wb_wb_en,
    input wire [4:0] wb_rd,
    input wire [DATA_WIDTH-1:0] wb_bypassing_data
);

    logic bypass_valid1, bypass_valid2;
    assign data_hazard = ~(bypass_valid1 & bypass_valid2);

    assign rf_rs1 = req_rs1;
    assign rf_rs2 = req_rs2;

    logic [DATA_WIDTH-1:0] exe_bypassing_data_pc_addr_inc;
    logic [DATA_WIDTH-1:0] mem_bypassing_data_pc_addr_inc;

    always_comb begin
        exe_bypassing_data_pc_addr_inc = exe_bypassing_data_pc_addr + 4;
        mem_bypassing_data_pc_addr_inc = mem_bypassing_data_pc_addr + 4;
    end

    always_comb begin
        bypass_valid1 = 1; req_data1 = rf_data1;

        if (req_rs1 == 0) begin
            bypass_valid1 = 1; req_data1 = 32'h0;
        end

        else if (req_rs1 == exe_rd & exe_wb_en) begin
            // Hazard in EXE stage
            if (exe_dm_mux == `DM_MUX_ALU) begin
                bypass_valid1 = 1; req_data1 = exe_bypassing_data_alu;
            end else if (exe_dm_mux == `DM_MUX_PC_INC) begin
                bypass_valid1 = 1; req_data1 = exe_bypassing_data_pc_addr_inc;
            end else if (exe_dm_mux == `DM_MUX_MEM) begin
                bypass_valid1 = 0;
            end else begin
                // What the heck?
                bypass_valid1 = 0;
            end
        end

        else if (req_rs1 == mem_rd & mem_wb_en) begin
            // Hazard in MEM stage
            if (mem_dm_mux == `DM_MUX_ALU) begin
                bypass_valid1 = 1; req_data1 = mem_bypassing_data_alu;
            end else if (mem_dm_mux == `DM_MUX_PC_INC) begin
                bypass_valid1 = 1; req_data1 = mem_bypassing_data_pc_addr_inc;
            end else if (mem_dm_mux == `DM_MUX_MEM) begin
                if (mem_bypassing_data_dm_valid) begin
                    bypass_valid1 = 1; req_data1 = mem_bypassing_data_dm;
                end else begin
                    bypass_valid1 = 0;
                end
            end else begin
                // What the heck?
                bypass_valid1 = 0;
            end
        end

        else if (req_rs1 == wb_rd & wb_wb_en) begin
            // Direct forwarding
            bypass_valid1 = 1; req_data1 = wb_bypassing_data;
        end

    end

    always_comb begin
        bypass_valid2 = 1; req_data2 = rf_data2;

        if (req_rs2 == 0) begin
            bypass_valid2 = 1; req_data2 = 32'h0;
        end

        else if (req_rs2 == exe_rd & exe_wb_en) begin
            // Hazard in EXE stage
            if (exe_dm_mux == `DM_MUX_ALU) begin
                bypass_valid2 = 1; req_data2 = exe_bypassing_data_alu;
            end else if (exe_dm_mux == `DM_MUX_PC_INC) begin
                bypass_valid2 = 2; req_data2 = exe_bypassing_data_pc_addr_inc;
            end else if (exe_dm_mux == `DM_MUX_MEM) begin
                bypass_valid2 = 0;
            end else begin
                // What the heck?
                bypass_valid2 = 0;
            end
        end

        else if (req_rs2 == mem_rd & mem_wb_en) begin
            // Hazard in MEM stage
            if (mem_dm_mux == `DM_MUX_ALU) begin
                bypass_valid2 = 1; req_data2 = mem_bypassing_data_alu;
            end else if (mem_dm_mux == `DM_MUX_PC_INC) begin
                bypass_valid2 = 1; req_data2 = mem_bypassing_data_pc_addr_inc;
            end else if (mem_dm_mux == `DM_MUX_MEM) begin
                if (mem_bypassing_data_dm_valid) begin
                    bypass_valid2 = 1; req_data2 = mem_bypassing_data_dm;
                end else begin
                    bypass_valid2 = 0;
                end
            end else begin
                // What the heck?
                bypass_valid2 = 0;
            end
        end

        else if (req_rs2 == wb_rd & wb_wb_en) begin
            // Direct forwarding
            bypass_valid2 = 1; req_data2 = wb_bypassing_data;
        end

    end

endmodule