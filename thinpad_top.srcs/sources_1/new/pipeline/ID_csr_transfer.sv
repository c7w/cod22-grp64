`include "../headers/exception.svh"

module ID_csr_transfer #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input wire [`CSR_ADDR_WIDTH-1:0] csr_addr,
    input wire [4:0] rs1_i,
    input wire [DATA_WIDTH-1:0] zimm,
    input wire [`CSR_OP_WIDTH-1:0] csr_opcode,

    input wire [DATA_WIDTH-1:0] x_rs1,  // from RF
    output logic [4:0] rs1_o,  // to RF

    output logic [DATA_WIDTH-1:0] csr_data,  // to EXE
    
    // From CSR transfer
    input wire priviledge_mode_t priviledge_mode_i,
    input wire mtvec_t mtvec_i,
    input wire mscratch_t mscratch_i,
    input wire mepc_t mepc_i,
    input wire mcause_t mcause_i,
    input wire mstatus_t mstatus_i,
    input wire mie_t mie_i,
    input wire mip_t mip_i,
    input wire mtval_t mtval_i,
    input wire mideleg_t mideleg_i,
    input wire medeleg_t medeleg_i,
    input wire satp_t satp_i,
    input wire sepc_t sepc_i,
    input wire scause_t scause_i,
    input wire stval_t stval_i,
    input wire stvec_t stvec_i,
    input wire sscratch_t sscratch_i,

    output priviledge_mode_t priviledge_mode_o,
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

    output logic priviledge_mode_wen,
    output logic mtvec_wen,
    output logic mscratch_wen,
    output logic mepc_wen,
    output logic mcause_wen,
    output logic mstatus_wen,
    output logic mie_wen,
    output logic mip_wen,
    output logic mtval_wen,
    output logic mideleg_wen,
    output logic medeleg_wen,
    output logic satp_wen,
    output logic sepc_wen,
    output logic scause_wen,
    output logic stval_wen,
    output logic stvec_wen,
    output logic sscratch_wen

);

    assign rs1_o = rs1_i;

    logic [DATA_WIDTH-1:0] calc_result;

    always_comb begin
        // Default settings
        priviledge_mode_wen = 0;
        mtvec_wen = 0;
        mscratch_wen = 0;
        mepc_wen = 0;
        mcause_wen = 0;
        mstatus_wen = 0;
        mie_wen = 0;
        mip_wen = 0;
        mtval_wen = 0;
        mideleg_wen = 0;
        medeleg_wen = 0;
        satp_wen = 0;
        sepc_wen = 0;
        scause_wen = 0;
        stval_wen = 0;
        stvec_wen = 0;
        sscratch_wen = 0;

        priviledge_mode_o = 0;
        mtvec_o = 0;
        mscratch_o = 0;
        mepc_o = 0;
        mcause_o = 0;
        mstatus_o = 0;
        mie_o = 0;
        mip_o = 0;
        mtval_o = 0;
        mideleg_o = 0;
        medeleg_o = 0;
        satp_o = 0;
        sepc_o = 0;
        scause_o = 0;
        stval_o = 0;
        stvec_o = 0;
        sscratch_o = 0;

        if (0 <= csr_opcode && csr_opcode < 6) begin
            case (csr_opcode) 
                CSR_OP_CSRRW: calc_result = x_rs1;
                CSR_OP_CSRRS: calc_result = csr_addr | x_rs1;
                CSR_OP_CSRRC: calc_result = csr_addr & ~x_rs1;
                CSR_OP_CSRRWI: calc_result = zimm;
                CSR_OP_CSRRSI: calc_result = csr_addr | zimm;
                CSR_OP_CSRRCI: calc_result = csr_addr & ~zimm;
            endcase

            case (csr_addr) 
                // CSR_PRIVILEDGE_MODE_ADDR: begin priviledge_mode_o = calc_result; priviledge_mode_wen = 1; end // not exists
                `CSR_MTVEC_ADDR: begin mtvec_o = calc_result; mtvec_wen = 1; end
                `CSR_MSCRATCH_ADDR: begin mscratch_o = calc_result; mscratch_wen = 1; end
                `CSR_MEPC_ADDR: begin mepc_o = calc_result; mepc_wen = 1; end
                `CSR_MCAUSE_ADDR: begin mcause_o = calc_result; mcause_wen = 1; end
                `CSR_MSTATUS_ADDR: begin mstatus_o = calc_result; mstatus_wen = 1; end
                `CSR_MIE_ADDR: begin mie_o = calc_result; mie_wen = 1; end
                `CSR_MIP_ADDR: begin mip_o = calc_result; mip_wen = 1; end
                `CSR_MTVAL_ADDR: begin mtval_o = calc_result; mtval_wen = 1; end
                `CSR_MIDELEG_ADDR: begin mideleg_o = calc_result; mideleg_wen = 1; end
                `CSR_MEDELEG_ADDR: begin medeleg_o = calc_result; medeleg_wen = 1; end
                `CSR_SATP_ADDR: begin satp_o = calc_result; satp_wen = 1; end
                `CSR_SEPC_ADDR: begin sepc_o = calc_result; sepc_wen = 1; end
                `CSR_SCAUSE_ADDR: begin scause_o = calc_result; scause_wen = 1; end
                `CSR_STVAL_ADDR: begin stval_o = calc_result; stval_wen = 1; end
                `CSR_STVEC_ADDR: begin stvec_o = calc_result; stvec_wen = 1; end
                `CSR_SSCRATCH_ADDR: begin sscratch_o = calc_result; sscratch_wen = 1; end
            endcase
        end

    end

    always_comb begin
        case (csr_addr) 
            // CSR_PRIVILEDGE_MODE_ADDR: csr_data = priviledge_mode_i;
            `CSR_MTVEC_ADDR: csr_data = mtvec_i;
            `CSR_MSCRATCH_ADDR: csr_data = mscratch_i;
            `CSR_MEPC_ADDR: csr_data = mepc_i;
            `CSR_MCAUSE_ADDR: csr_data = mcause_i;
            `CSR_MSTATUS_ADDR: csr_data = mstatus_i;
            `CSR_MIE_ADDR: csr_data = mie_i;
            `CSR_MIP_ADDR: csr_data = mip_i;
            `CSR_MTVAL_ADDR: csr_data = mtval_i;
            `CSR_MIDELEG_ADDR: csr_data = mideleg_i;
            `CSR_MEDELEG_ADDR: csr_data = medeleg_i;
            `CSR_SATP_ADDR: csr_data = satp_i;
            `CSR_SEPC_ADDR: csr_data = sepc_i;
            `CSR_SCAUSE_ADDR: csr_data = scause_i;
            `CSR_STVAL_ADDR: csr_data = stval_i;
            `CSR_STVEC_ADDR: csr_data = stvec_i;
            `CSR_SSCRATCH_ADDR: csr_data = sscratch_i;
        endcase
    end


endmodule