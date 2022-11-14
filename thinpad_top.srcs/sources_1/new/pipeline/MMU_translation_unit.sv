module MMU_translation_unit #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input clk,
    input rst,

    // Translation Unit -> TLB
    output logic translation_ack,
    output logic pte_t translation_result,

    // TLB -> Translation Unit
    input satp_t satp,
    input wire translation_en,
    input wire virt_addr_t translation_addr,


    // Translation Unit -> Wishbone master
    output wire wb_cyc_o, 
    output logic wb_stb_o, 
    output logic [ADDR_WIDTH-1:0] wb_adr_o,
    output wire [DATA_WIDTH-1:0] wb_dat_o,
    output wire [DATA_WIDTH/8-1:0] wb_sel_o,
    output wire wb_we_o

    // Wishbone master -> Translation Unit
    input wire wb_ack_i,
    input wire [DATA_WIDTH-1:0] wb_dat_i
);

    // Translation can be slow. But it wont affect final perf :)


    // PTE Addr calculation
    reg pte_t pte1, pte2;
    wire [ADDR_WIDTH-1:0] pte1_addr, pte2_addr, pte3_addr;

    always_comb begin
        pte1_addr = {satp.ppn[19:0], virt_addr.vpn1[9:0], 2'b00};
        pte2_addr = {pte1.ppn1[9:0], pte1.ppn0[9:0], virt_addr.vpn0[9:0], 2'b00};
        pte3_addr = {pte2.ppn1[9:0], pte2.ppn0[9:0], virt_addr.offset[11:0]};
    end


    typedef enum logic [3:0] { 
        STATE_IDLE,
        STATE_READ1,
        STATE_READ1_NXT,
        STATE_READ2,
        STATE_READ2_NXT,
        STATE_WAIT
    } state_t;
    state_t state, state_nxt;

    reg virt_addr translation_addr_cache;

    // Translation Unit -> TLB

    // Translation Unit -> Wishbone master
    assign wb_cyc_o = wb_stb_o;
    assign wb_we_o = 1'b0;
    assign wb_dat_o = {DATA_WIDTH{1'b0}};
    assign wb_sel_o = 4'b1111;


    always_ff @(posedge clk) begin
        if (rst) begin
            state <= STATE_IDLE;
            pte1 <= 0; pte2 <= 0;
        end

        else begin
            case (state) 
                STATE_IDLE: begin
                    translation_ack <= 0;
                    if (translation_en) begin
                        translation_addr_cache <= translation_addr;
                        state <= STATE_READ1;

                        wb_stb_o <= 1;
                        wb_adr_o <= pte1_addr;
                    end
                end

                STATE_READ1: begin
                    if (wb_ack_i) begin
                        pte1 <= wb_dat_i;
                        wb_stb_o <= 0;
                        state <= STATE_READ1_NXT;
                    end
                end

                STATE_READ1_NXT: begin
                    wb_stb_o <= 1;
                    wb_adr_o <= pte2_addr;
                    state <= STATE_READ2;
                end

                STATE_READ2: begin
                    if (wb_ack_i) begin
                        pte2 <= wb_dat_i;
                        wb_stb_o <= 0;
                        state <= STATE_READ2_NXT;
                    end
                end

                STATE_READ2_NXT: begin
                    wb_stb_o <= 1;
                    wb_adr_o <= pte3_addr;
                    state <= STATE_WAIT;
                end

                STATE_WAIT: begin
                    if (wb_ack_i) begin
                        translation_result <= wb_dat_i;
                        translation_ack <= 1;

                        wb_stb_o <= 0;
                        state <= STATE_IDLE;
                    end
                end
            endcase

        end
    end

endmodule
