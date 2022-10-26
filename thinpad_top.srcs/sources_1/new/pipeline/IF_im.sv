module IF_im #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    input wire[ADDR_WIDTH-1:0] pc_addr,
    output wire [DATA_WIDTH-1:0] instr,
    output wire ack,

    // wishbone master
    output wire wb_cyc_o, // done
    output wire wb_stb_o, // done
    input wire wb_ack_i, // done
    output wire [ADDR_WIDTH-1:0] wb_adr_o, // done
    output wire [DATA_WIDTH-1:0] wb_dat_o, // done
    input wire [DATA_WIDTH-1:0] wb_dat_i, // done
    output wire [DATA_WIDTH/8-1:0] wb_sel_o, // done
    output wire wb_we_o // done

);
    // Assembling as a wishbone master driving Instruction Memory.
    assign instr = wb_dat_i;
    assign ack = wb_ack_i;
   
    assign wb_cyc_o = wb_stb_o;
    assign wb_we_o = 1'b0;
    assign wb_dat_o = DATA_WIDTH{1'b0};
    assign wb_sel_o = 4'b1111;
    assign wb_adr_o = pc_addr;

    always_comb begin
        wb_stb_o = ~wb_ack_i;
    end
    
endmodule
