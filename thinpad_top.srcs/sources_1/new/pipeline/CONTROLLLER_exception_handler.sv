// csrs = ['priviledge_mode', 'mtvec', 'mscratch', 'mepc', 'mcause', 'mstatus', 'mie', 'mip', 'mtval', 'mideleg', 'medeleg', 'satp', 'sepc', 'scause', 'stval', 'stvec', 'sscratch']

module CONTROLLER_exception_handler #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (
    input clk,
    input rst,

    input wire priviledge_mode_wen,
    input wire mtvec_wen,
    input wire mscratch_wen,
    input wire mepc_wen,
    input wire mcause_wen,
    input wire mstatus_wen,
    input wire mie_wen,
    input wire mip_wen,
    input wire mtval_wen,
    input wire mideleg_wen,
    input wire medeleg_wen,
    input wire satp_wen,
    input wire sepc_wen,
    input wire scause_wen,
    input wire stval_wen,
    input wire stvec_wen,
    input wire sscratch_wen,

    input wire [1:0] priviledge_mode_i,
    input wire [31:0] mtvec_i,
    input wire [31:0] mscratch_i,
    input wire [31:0] mepc_i,
    input wire [31:0] mcause_i,
    input wire [31:0] mstatus_i,
    input wire [31:0] mie_i,
    input wire [31:0] mip_i,
    input wire [31:0] mtval_i,
    input wire [31:0] mideleg_i,
    input wire [31:0] medeleg_i,
    input wire [31:0] satp_i,
    input wire [31:0] sepc_i,
    input wire [31:0] scause_i,
    input wire [31:0] stval_i,
    input wire [31:0] stvec_i,
    input wire [31:0] sscratch_i,

    // To IF_decoder: bypassing enabled
    output logic [1:0] priviledge_mode_o,
    output mtvec_t mtvec_o,
    output mscratch_t mscratch_o,
    output mepc_t mepc_o,
    output mcause_t mcause_o,
    output mstatus_t mstatus_o,
    output mie_t mie_o,
    output mip_t mip_o,
    output mtval_t mtval_o,
    output mideleg_t mideleg_o,
    output medeleg_t medeleg_o,
    output satp_t satp_o,
    output sepc_t sepc_o,
    output scause_t scause_o,
    output stval_t stval_o,
    output stvec_t stvec_o,
    output sscratch_t sscratch_o,

    // To ID CSR Transfer: stable
    output logic [1:0] priviledge_mode_reg,
    output mtvec_t mtvec_reg,
    output mscratch_t mscratch_reg,
    output mepc_t mepc_reg,
    output mcause_t mcause_reg,
    output mstatus_t mstatus_reg,
    output mie_t mie_reg,
    output mip_t mip_reg,
    output mtval_t mtval_reg,
    output mideleg_t mideleg_reg,
    output medeleg_t medeleg_reg,
    output satp_t satp_reg,
    output sepc_t sepc_reg,
    output scause_t scause_reg,
    output stval_t stval_reg,
    output stvec_t stvec_reg,
    output sscratch_t sscratch_reg
);

    always_ff @( posedge clk ) begin

        if (rst) begin
            priviledge_mode_reg <= 2'b11;
            mtvec_reg <= 32'd0;
            mscratch_reg <= 32'd0;
            mepc_reg <= 32'd0;
            mcause_reg <= 32'd0;
            mstatus_reg <= 32'd0;
            mie_reg <= 32'd0;
            mip_reg <= 32'd0;
            mtval_reg <= 32'd0;
            mideleg_reg <= 32'd0;
            medeleg_reg <= 32'd0;
            satp_reg <= 32'd0;
            sepc_reg <= 32'd0;
            scause_reg <= 32'd0;
            stval_reg <= 32'd0;
            stvec_reg <= 32'd0;
            sscratch_reg <= 32'd0;
        end

        else begin

            if (priviledge_mode_wen) begin
                priviledge_mode_reg <= priviledge_mode_i;            
            end

            if (mtvec_wen) begin
                mtvec_reg <= mtvec_i;
            end

            if (mscratch_wen) begin
                mscratch_reg <= mscratch_i;
            end

            if (mepc_wen) begin
                mepc_reg <= mepc_i;
            end

            if (mcause_wen) begin
                mcause_reg <= mcause_i;
            end

            if (mstatus_wen) begin
                mstatus_reg <= mstatus_i;
            end

            if (mie_wen) begin
                mie_reg <= mie_i;
            end

            if (mip_wen) begin
                mip_reg <= mip_i;
            end

            if (mtval_wen) begin
                mtval_reg <= mtval_i;
            end

            if (mideleg_wen) begin
                mideleg_reg <= mideleg_i;
            end

            if (medeleg_wen) begin
                medeleg_reg <= medeleg_i;
            end

            if (satp_wen) begin
                satp_reg <= satp_i;
            end

            if (sepc_wen) begin
                sepc_reg <= sepc_i;
            end

            if (scause_wen) begin
                scause_reg <= scause_i;
            end

            if (stval_wen) begin
                stval_reg <= stval_i;
            end

            if (stvec_wen) begin
                stvec_reg <= stvec_i;
            end

            if (sscratch_wen) begin
                sscratch_reg <= sscratch_i;
            end

        end
        
    end

    // Reg data bypassing
    always_comb begin

        if (priviledge_mode_wen) begin
            priviledge_mode_o = priviledge_mode_i;
        end else begin
            priviledge_mode_o = priviledge_mode_reg;
        end

        if (mtvec_wen) begin
            mtvec_o = mtvec_i;
        end else begin
            mtvec_o = mtvec_reg;
        end

        if (mscratch_wen) begin
            mscratch_o = mscratch_i;
        end else begin
            mscratch_o = mscratch_reg;
        end

        if (mepc_wen) begin
            mepc_o = mepc_i;
        end else begin
            mepc_o = mepc_reg;
        end

        if (mcause_wen) begin
            mcause_o = mcause_i;
        end else begin
            mcause_o = mcause_reg;
        end

        if (mstatus_wen) begin
            mstatus_o = mstatus_i;
        end else begin
            mstatus_o = mstatus_reg;
        end

        if (mie_wen) begin
            mie_o = mie_i;
        end else begin
            mie_o = mie_reg;
        end

        if (mip_wen) begin
            mip_o = mip_i;
        end else begin
            mip_o = mip_reg;
        end

        if (mtval_wen) begin
            mtval_o = mtval_i;
        end else begin
            mtval_o = mtval_reg;
        end

        if (mideleg_wen) begin
            mideleg_o = mideleg_i;
        end else begin
            mideleg_o = mideleg_reg;
        end

        if (medeleg_wen) begin
            medeleg_o = medeleg_i;
        end else begin
            medeleg_o = medeleg_reg;
        end

        if (satp_wen) begin
            satp_o = satp_i;
        end else begin
            satp_o = satp_reg;
        end

        if (sepc_wen) begin
            sepc_o = sepc_i;
        end else begin
            sepc_o = sepc_reg;
        end

        if (scause_wen) begin
            scause_o = scause_i;
        end else begin
            scause_o = scause_reg;
        end

        if (stval_wen) begin
            stval_o = stval_i;
        end else begin
            stval_o = stval_reg;
        end

        if (stvec_wen) begin
            stvec_o = stvec_i;
        end else begin
            stvec_o = stvec_reg;
        end

        if (sscratch_wen) begin
            sscratch_o = sscratch_i;
        end else begin
            sscratch_o = sscratch_reg;
        end
    end


endmodule