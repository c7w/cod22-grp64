module IF_im #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    input wire[ADDR_WIDTH-1:0] pc_addr,
    output reg [DATA_WIDTH-1:0] instr,
    output logic im_ack,

    // wishbone master
    output wire wb_cyc_o, 
    output logic wb_stb_o, 
    input wire wb_ack_i, 
    output wire [ADDR_WIDTH-1:0] wb_adr_o, 
    output wire [DATA_WIDTH-1:0] wb_dat_o, 
    input wire [DATA_WIDTH-1:0] wb_dat_i, 
    output wire [DATA_WIDTH/8-1:0] wb_sel_o, 
    output wire wb_we_o 

);

    logic [ADDR_WIDTH-1:0] pc_addr_last;

    typedef enum logic [3:0] { 
        STATE_IDLE,
        STATE_READ
    } state_t;
    state_t state;


    always_ff @(posedge clk) begin
        if (rst) begin
            pc_addr_last <= 0;
            state <= STATE_IDLE;
        end

        else begin
            case (state) 
                STATE_IDLE: begin
                    if (pc_addr != pc_addr_last) begin
                        pc_addr_last <= pc_addr;
                        state <= STATE_READ;
                    end
                end

                STATE_READ: begin
                    if (wb_ack_i) begin
                        instr <= wb_dat_i;
                        state <= STATE_IDLE;
                    end
                end
            endcase
        end
    end


    // Assembling as a wishbone master driving Instruction Memory.
    assign instr = wb_dat_i;
    assign ack = wb_ack_i;
   
    assign wb_cyc_o = wb_stb_o;
    assign wb_we_o = 1'b0;
    assign wb_dat_o = {DATA_WIDTH{1'b0}};
    assign wb_sel_o = 4'b1111;
    assign wb_adr_o = pc_addr_last;

    always_comb begin
        wb_stb_o = (state == STATE_READ);
        im_ack = (state == STATE_IDLE);
    end
    
endmodule
