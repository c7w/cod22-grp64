module trigger (
  input wire clk,
  input wire in,
  output reg out
);
    reg last_in;
    
    always @(posedge clk) begin
        last_in <= in;
        if (last_in == 0 && in == 1) begin
            out <= 1;
        end else begin
            out <= 0;
        end
    
    end
    
endmodule
