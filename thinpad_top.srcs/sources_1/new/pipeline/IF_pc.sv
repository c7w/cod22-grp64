module IF_pc (
    input wire clk,
    input wire rst,
    input wire stall,
    input wire[31:0] pc_nxt,
    output reg[31:0] pc_addr
);

    always_ff @( posedge clk ) begin
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
