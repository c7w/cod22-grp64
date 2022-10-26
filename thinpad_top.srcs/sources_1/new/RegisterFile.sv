module RegisterFile(
    input wire clk,
    input wire rst,
    input wire[4:0] waddr,
    input wire[15:0] wdata,
    input wire wen,
    input wire[4:0] raddr_a,
    output wire[15:0] rdata_a,
    input wire[4:0] raddr_b,
    output wire[15:0] rdata_b
);

    reg [15:0] data [0:31];

    assign rdata_a = data[raddr_a];
    assign rdata_b = data[raddr_b];

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            
            for (integer i = 0; i < 32; i = i + 1) begin
                data[i] <= 0;
            end

        end else begin
                        
            // Write
            if (wen && waddr != 0) begin
                data[waddr] <= wdata;
            end
        end
    end

    
endmodule
