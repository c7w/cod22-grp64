module lab5_master #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input wire clk_i,
    input wire rst_i,
    output logic[15:0] leds_o,

    // TODO: ������Ҫ�Ŀ����źţ����簴�����أ�
    input wire [ADDR_WIDTH-1:0] addr_i,

    // wishbone master
    output reg wb_cyc_o,
    output reg wb_stb_o,
    input wire wb_ack_i,
    output reg [ADDR_WIDTH-1:0] wb_adr_o,
    output reg [DATA_WIDTH-1:0] wb_dat_o,
    input wire [DATA_WIDTH-1:0] wb_dat_i,
    output reg [DATA_WIDTH/8-1:0] wb_sel_o,
    output reg wb_we_o
);


    assign wb_cyc_o = wb_stb_o;

  // TODO: ʵ��ʵ�� 5 ���ڴ�+���� Master
    typedef enum logic [2:0] {
        STATE_IDLE = 0,
        STATE_READ_UART = 1,
        STATE_WRITE_SRAM = 2,
        STATE_WRITE_UART = 3,
        STATE_DONE = 4
    } state_t;
    state_t state;
    logic [3:0] state_step;
    
    logic [3:0] try_cnt;
    logic [ADDR_WIDTH-1:0] addr;

    logic [DATA_WIDTH-1:0] temp_data;
    
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state <= STATE_IDLE;
            state_step <= 0;

            addr <= addr_i;
            try_cnt <= 0;

            wb_stb_o <= 0;
            wb_adr_o <= 0;
            wb_dat_o <= 0;
            wb_sel_o <= 0;
            wb_we_o <= 0;
            
            leds_o <= 0;

            
        end else begin
        
            case (state) 

                STATE_IDLE: begin
                    if (try_cnt < 10) begin
                        state <= STATE_READ_UART;
                        state_step <= 0;
                        try_cnt <= try_cnt + 1;
                        
                        wb_stb_o <= 1;
                        wb_adr_o <= 32'h10000005;
                        wb_we_o <= 0;
                        wb_sel_o <= 4'b1111;
                        leds_o <= 1;
                    end
                end
                
                STATE_READ_UART: begin
                    if (state_step == 0) begin
                        // Reading State Reg
                        if (wb_ack_i) begin
                            wb_stb_o <= 0;
                            state_step <= 1;
                        end  // else waiting
                        leds_o <= 2;
                    end 
                    
                    else if (state_step == 1) begin
                        // Already read state reg
                        if (wb_dat_i[0]) begin
                            wb_stb_o <= 1;
                            wb_adr_o <= 32'h10000000;
                            wb_we_o <= 0;
                            wb_sel_o <= 4'b1111;
                            state_step <= 2;
                        end
                        else begin
                            state_step <= 0; // TODO: ???

                            wb_stb_o <= 1;
                            wb_adr_o <= 32'h10000005;
                            wb_we_o <= 0;
                            wb_sel_o <= 4'b1111;
                        end
                        leds_o <= 3;
                    end
                    
                    else if (state_step == 2) begin
                        // Reading data reg
                        if (wb_ack_i) begin
                            wb_stb_o <= 0;
                            state_step <= 3;
                            temp_data <= wb_dat_i;
                            wb_dat_o <= wb_dat_i;
                        end  // else waiting
                        leds_o <= 4;
                    end

                    else if (state_step == 3) begin

                        state <= STATE_WRITE_SRAM;
                        state_step <= 0;

                        wb_stb_o <= 1;
                        wb_adr_o <= addr + 4 * (try_cnt - 1);
                        wb_we_o <= 1;
                        wb_sel_o <= (4'b0001 << ((addr + 4 * (try_cnt - 1)) & 2'b11) );
                        leds_o <= 5;
                    end
                end


                STATE_WRITE_SRAM: begin
                    if (state_step == 0) begin
                        if (wb_ack_i) begin
                            wb_stb_o <= 0;
                            state_step <= 1;
                        end  // else waiting
                        leds_o <= 6;
                    end

                    else if (state_step == 1) begin
                        state <= STATE_WRITE_UART;
                        state_step <= 0;

                        wb_stb_o <= 1;
                        wb_adr_o <= 32'h10000005;
                        wb_we_o <= 0;
                        wb_sel_o <= 4'b1111;
                        leds_o <= 7;
                    end
                end

                STATE_WRITE_UART: begin
                    if (state_step == 0) begin
                        // Reading State Reg
                        if (wb_ack_i) begin
                            wb_stb_o <= 0;
                            wb_dat_o <= temp_data;
                            state_step <= 1;
                        end  // else waiting
                        leds_o <= 8;
                    end 

                    else if (state_step == 1) begin
                        // Already read state reg
                        if (wb_dat_i[5]) begin
                            wb_stb_o <= 1;
                            wb_adr_o <= 32'h10000000;
                            wb_we_o <= 1;
                            wb_sel_o <= 4'b0001;
                            state_step <= 2;
                        end
                        else begin
                            state_step <= 0;  // TODO: ???
                           
                            wb_stb_o <= 1;
                            wb_adr_o <= 32'h10000005;
                            wb_we_o <= 0;
                            wb_sel_o <= 4'b1111;
                        end
                        
                        leds_o <= 9;
                    end

                    else if (state_step == 2) begin
                        // Reading State Reg
                        if (wb_ack_i) begin
                            wb_stb_o <= 0;

                            state <= STATE_DONE;
                            state_step <= 0;
                        end  // else waiting
                        
                        leds_o <= 10;
                    end
                end

                STATE_DONE: begin
                    state <= STATE_IDLE;
                    state_step <= 0;
                    leds_o <= 11;
                end

            endcase

        
        end
    
    end
  

endmodule
