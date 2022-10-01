module ALU(
    input wire[15:0] a,
    input wire[15:0] b,
    input wire[3:0] op,
    output reg[15:0] y
);

    integer i;
    
    always @(*) begin
        if (op == 1) begin
            y = a + b;
        end
        
        else if (op == 2) begin
            y = a - b;
        end
        
        else if (op == 3) begin
            y = a & b;
        end
        
        else if (op == 4) begin
            y = a | b;
        end
        
        else if (op == 5) begin
            y = a ^ b;
        end
        
        else if (op == 6) begin
            y = ~a;
        end
        
        else if (op == 7) begin
            y = a << (b & 15);
        end
        
        else if (op == 8) begin
           y = a >> (b & 15);
        end
        
        else if (op == 9) begin
            y = signed'(a) >>> (b & 15);
        end
        
        else if (op == 10) begin
          y =  32'hFFFF & (a << (b & 15)) | (a >> (16 - (b & 15)));
        end
        
        else begin
            y = 0;
        end
    end    

endmodule