module IF_im #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk,
    input wire rst,

    input wire[ADDR_WIDTH-1:0] pc_addr,
    input wire branching,
    output logic [DATA_WIDTH-1:0] instr,
    output logic im_ack,

    // wishbone master
    output wire wb_cyc_o, 
    output logic wb_stb_o, 
    input wire wb_ack_i, 
    output logic [ADDR_WIDTH-1:0] wb_adr_o, 
    output wire [DATA_WIDTH-1:0] wb_dat_o, 
    input wire [DATA_WIDTH-1:0] wb_dat_i, 
    output wire [DATA_WIDTH/8-1:0] wb_sel_o, 
    output wire wb_we_o

);

    logic [ADDR_WIDTH-1:0] pc_addr_last;
    logic [DATA_WIDTH-1:0] instr_cached;

    logic im_ack_cache;
    logic wait_for_branching;
    logic init;


    always_ff @(posedge clk) begin
        if (rst) begin
            pc_addr_last <= 0;
            im_ack_cache <= 0;
            wait_for_branching <= 0;
            init <= 1;
        end

        else begin


            // if (branching) begin
            //     if (im_ack_no_branching) begin
            //         // Do nothing
            //     end else begin
            //         wait_for_branching <= 1;
            //     end
            // end

            // else begin

            if (wb_ack_i) begin
                // if (wait_for_branching) begin
                //     wait_for_branching <= 0;
                // end else begin
                //     im_ack_cache <= im_ack_cache || wb_ack_i;
                //     instr_cached <= wb_dat_i;
                // end
                if (pc_addr != pc_addr_last) begin
                    pc_addr_last <= pc_addr;
                    im_ack_cache <= 0;
                end else begin
                    im_ack_cache <= im_ack_cache || wb_ack_i;
                    instr_cached <= wb_dat_i;
                end
            end

            else if (pc_addr != pc_addr_last && (wb_ack_i || im_ack_cache || init)) begin
                // This indicates a new SEQ request
                pc_addr_last <= pc_addr;
                im_ack_cache <= 0;
                init <= 0;
            end

            // end


            
        end
    end


    // Assembling as a wishbone master driving Instruction Memory.
   
    always_comb begin
        if (wb_ack_i) begin
            instr = wb_dat_i;
        end else if (im_ack) begin
            instr = instr_cached;
        end else begin
            instr = 32'h0;  // Check for this carefully
        end
    end

    wire im_ack_no_branching;
    assign im_ack_no_branching = (wb_ack_i || im_ack_cache) && (pc_addr == pc_addr_last);

    assign im_ack = im_ack_no_branching && (~branching) && (~wait_for_branching);

    assign wb_stb_o = (~im_ack_cache) || (pc_addr != pc_addr_last);

    assign wb_cyc_o = wb_stb_o;
    assign wb_we_o = 1'b0;
    assign wb_dat_o = {DATA_WIDTH{1'b0}};
    assign wb_sel_o = 4'b1111;
    
    always_comb begin
        wb_adr_o = pc_addr_last;
        if (pc_addr != pc_addr_last && (wb_ack_i || im_ack_cache)) begin
            wb_adr_o = pc_addr;
        end
    end
    // always_comb begin
    //     wb_stb_o = (state == STATE_READ);
    //     im_ack = (state == STATE_IDLE);
    // end
    
endmodule
