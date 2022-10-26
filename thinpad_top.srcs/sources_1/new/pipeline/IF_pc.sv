module IF_pc (
    input clk,
    input rst,
    input stall,
    input wire[31:0] pc_nxt,
    output reg[31:0] pc_addr,
    output wire[31:0] pc_nxt_prediction
);

    always_comb begin
        // TODO: add branching prediction?
        pc_nxt_prediction = pc_addr + 4;
    end

    always_ff @( clk ) begin
        if (rst) begin
            pc_addr <= 0x80000000;
        end

        else begin
            if (~stall) begin
                pc_addr <= pc_nxt;    
            end
        end

    end


endmodule
