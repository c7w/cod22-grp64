module fake_uart_controller #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk_i,
    input wire rst_i,

    // Wishbone Slave
    input wire wb_cyc_i,
    input wire wb_stb_i,
    output reg wb_ack_o,
    input wire [ADDR_WIDTH-1:0] wb_adr_i,
    input wire [DATA_WIDTH-1:0] wb_dat_i,
    output reg [DATA_WIDTH-1:0] wb_dat_o,
    input wire [DATA_WIDTH/8-1:0] wb_sel_i,
    input wire wb_we_i,

    // External
    input wire external_valid,
    input wire [7:0] external_data

);

    localparam REG_DATA = 8'h00;
    localparam REG_STATUS = 8'h05;


    // Read Buffer
    logic read_wait;
    logic [7:0] received [0:63];
    logic [5:0] s1, s2;  // Index. [s1, s2) is valid.
    assign read_wait = s1 != s2;

    // Write Buffer
    wire write_wait = 1;
    wire [7:0] reg_status = {2'b0, write_wait, 4'b0, read_wait};

    
    /*-- wishbone fsm --*/
    always_ff @(posedge clk_i) begin
        if (rst_i)
            wb_ack_o <= 0;
        
        else
        // every request get ACK-ed immediately
        if (wb_ack_o) begin
            wb_ack_o <= 0;
        end else begin
            wb_ack_o <= wb_stb_i;
        end
    end

    // write logic
    logic lock_write;
    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            lock_write <= 0;
        end else if (wb_stb_i && wb_we_i) begin
            
            if (~lock_write) begin
                case (wb_adr_i[7:0])
                    REG_DATA: begin
                        if (wb_sel_i[0]) begin
                            
                            $write("[%0t]: fake uart received 0x%02x", $time, wb_dat_i[7:0]);
                            
                            if (wb_dat_i[7:0] >= 8'h21 && wb_dat_i[7:0] <= 8'h7E)
                                $write(", ASCII: %c\n", wb_dat_i[7:0]);
                            else
                                $write("\n");

                            lock_write <= 1;
                            
                        end
                    end

                    default: ;  // do nothing
                endcase
            end

        end else begin
            lock_write <= 0;
        end
    end

    logic read_lock;
    always_ff @ (posedge clk_i) begin
        if (rst_i) begin
            s1 <= 0;
            for (integer i = 0; i < 64; i = i + 1) begin
                received[i] <= 0;
            end
            read_lock <= 0;
        end

        else begin

            if(wb_stb_i && !wb_we_i) begin

                if (~read_lock) begin

                    case (wb_adr_i[7:0])
                        REG_DATA: begin
                            if (wb_sel_i[0]) wb_dat_o[7:0] <= received[s1];
                            if (wb_sel_i[1]) wb_dat_o[15:8] <= received[s1];
                            if (wb_sel_i[2]) wb_dat_o[23:16] <= received[s1];
                            if (wb_sel_i[3]) wb_dat_o[31:24] <= received[s1];

                            s1 <= s1 + 1;
                            read_lock <= 1;
                        end

                        REG_STATUS: begin
                            if (wb_sel_i[0]) wb_dat_o[7:0] <= reg_status;
                            if (wb_sel_i[1]) wb_dat_o[15:8] <= reg_status;
                            if (wb_sel_i[2]) wb_dat_o[23:16] <= reg_status;
                            if (wb_sel_i[3]) wb_dat_o[31:24] <= reg_status;
                        end

                        default: ;  // do nothing
                    endcase

                end


            end else begin
                read_lock <= 0;
            end
        end
    end

    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            s2 <= 0;
        end

        else begin

            if (external_valid) begin
                $display("Fake uart sent 0x%02x", external_data);
                received[s2] <= external_data;
                s2 <= s2 + 1;
            end
 
        end
    end

endmodule