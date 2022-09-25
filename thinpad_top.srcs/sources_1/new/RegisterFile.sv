module RegisterFile(
    input wire clk,
    input wire rst,
    input wire[4:0] waddr,
    input wire[15:0] wdata,
    input wire wen,
    input wire[4:0] raddr_a,
    output reg[15:0] rdata_a,
    input wire[4:0] raddr_b,
    output reg[15:0] rdata_b
);

    reg [16:0] data [0:32];
    integer i;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            rdata_a <= 0;
            rdata_b <= 0;
            
            for (i = 0; i < 32; i = i + 1) begin
                data[i] <= 0;
            end

        end else begin
            // Read
            rdata_a <= data[raddr_a];
            rdata_b <= data[raddr_b];
                        
            // Write
            if (wen && waddr != 0) begin
                data[waddr] <= wdata;
            end
        end
    end

    
endmodule
