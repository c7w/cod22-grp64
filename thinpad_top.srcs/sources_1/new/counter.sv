`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/09/19 18:15:49
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter (
  input wire clk,
  input wire reset,
  input wire trigger,
  output wire [3:0] count
);
    reg[3:0] count_reg;
    
//    always @(posedge clk, posedge reset) begin
//      if (reset) begin
//        count_reg <= 0;
//      end else begin
//        if (trigger && count < 15) begin
//            count_reg <= count_reg + 1;
//        end
//      end
//    end
    
    always @(posedge trigger, posedge reset) begin
      if (reset) begin
        count_reg <= 0;
      end else begin
        if (count < 15) begin
            count_reg <= count_reg + 1;
        end
      end
    end
    
    assign count = count_reg;
endmodule
