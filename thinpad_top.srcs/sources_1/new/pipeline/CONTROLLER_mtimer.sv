`define INC_INTERVAL 64'h100

module mtimer (
    input wire clk,
    input wire rst,

    output reg [63:0] mtime,
    output reg [63:0] mtimecmp,
    output logic interrupt_timer,

    // Write
    input wire mtime_wen,
    input wire mtimecmp_wen,
    input wire upper_wen,  // whether write 63:32 or 31:0
    input wire [31:0] mtimer_wdata
);

    logic [63:0] internel_counter;

    always_comb begin
        interrupt_timer = 0;
        if (mtime >= mtimecmp) begin
            interrupt_timer = 1;
        end
    end

    always_ff @( posedge clk ) begin
        if (rst) begin
            mtime <= 0;
            mtimecmp <= 64'd1145141919810;
            internel_counter <= 1;
        end

        else begin
            if (mtime_wen) begin

                if (upper_wen) begin
                    mtime <= {mtimer_wdata, mtime[31:0]};
                end
                else begin
                    mtime <= { mtime[63:32], mtimer_wdata };
                end

            end else if (mtimecmp_wen) begin
            
                if (upper_wen) begin
                    mtimecmp <= {mtimer_wdata, mtimecmp[31:0]}
                end else begin
                    mtimecmp <= {mtimecmp[63:32], mtimer_wdata}
                end

            end else begin

                if (internel_counter >= INC_INTERVAL) begin
                    internel_counter <= 1;
                    mtime <= mtime + 1;
                end
                else begin
                    internel_counter <= internel_counter + 1;
                end

            end

        end
    end


endmodule