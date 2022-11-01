module IF_pc (
    input wire clk,
    input wire rst,
    input wire stall,
    input wire[31:0] pc_nxt,
    output reg[31:0] pc_addr,
    output wire[31:0] pc_nxt_prediction
);

    logic [31:0] pc_nxt_prediction_comb;
    assign pc_nxt_prediction = pc_nxt_prediction_comb;

    always_comb begin
        // TODO: add branching prediction?
        pc_nxt_prediction_comb = pc_addr + 4;
    end

    always_ff @( clk ) begin
        if (rst) begin
            pc_addr <= 32'h80000000;
        end

        else begin
            if (~stall) begin
                pc_addr <= pc_nxt;    
            end
        end

    end


endmodule
