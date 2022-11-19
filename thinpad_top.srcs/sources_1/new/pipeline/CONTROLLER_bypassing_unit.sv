module CONTROLLER_bypassing_unit #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    // Pure combinational

    // IF_ID -> Bypassing Unit
    input wire [4:0] req_rs1,
    input wire [4:0] req_rs2,

    // Bypassing Unit -> RF
    output logic [4:0] rf_rs1,
    output logic [4:0] rf_rs2,

    // RF -> Bypassing Unit
    input wire [DATA_WIDTH-1:0] rf_data1,
    input wire [DATA_WIDTH-1:0] rf_data2,

    // Bypassing Unit -> Controller
    output logic data_hazard,  // If hazard, then stall the whole pipeline


);

endmodule