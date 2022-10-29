module CONTROLLER_pipeline #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
)(
    output wire[3:0] stall_o,
    output wire[3:0] bubble_o,
    
    
    output wire pc_mux_en, // 1 for jal, 0 for PC+4 or branching prediction
);


endmodule