module MEM_dm_mux #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire [`DM_MUX_WIDTH-1:0] dm_mux_ctr,
    input wire [ADDR_WIDTH-1:0] dm_mux_pc_addr,
    input wire [DATA_WIDTH-1:0] dm_mux_alu,
    input wire [DATA_WIDTH-1:0] dm_mux_dm,
    output wire [DATA_WIDTH-1:0] dm_mux_o
);

    always_comb begin
        dm_mux_o = 0;
        case (dm_mux_ctr) 
            `DM_MUX_PC_INC : begin
                dm_mux_o = dm_mux_pc_addr + 4;
            end

            `DM_MUX_ALU : begin
                dm_mux_o = dm_mux_alu;
            end

            `DM_MUX_MEM : begin
                dm_mux_o = dm_mux_dm;
            end
        endcase
    end

endmodule