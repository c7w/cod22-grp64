module RegisterFile(
    input wire clk,
    input wire rst,
    input wire[4:0] waddr,
    input wire[31:0] wdata,
    input wire wen,
    
    // Read
    input wire[4:0] raddr_a,
    output logic[31:0] rdata_a,
    input wire[4:0] raddr_b,
    output logic[31:0] rdata_b,
    input wire [4:0] raddr_csr,
    output logic[31:0] rdata_csr
);

    reg [31:0] data [0:31];

    // Bypassing when reading
    // TODO: add bypassing wires from ALU stage and DM stage
    always_comb begin
        if (raddr_a == waddr && wen) begin
            rdata_a = wdata;
        end else begin
            rdata_a = data[raddr_a];
        end
        if (raddr_b == waddr && wen) begin
            rdata_b = wdata;
        end else begin
            rdata_b = data[raddr_b];
        end
        if (raddr_csr == waddr && wen) begin
            rdata_csr = wdata;
        end else begin
            rdata_csr = data[raddr_csr];
        end

    end


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
