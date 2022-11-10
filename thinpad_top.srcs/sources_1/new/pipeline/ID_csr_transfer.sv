// TODO: buggy if u dont introduce data bypassing
`include "../headers/exception.svh"

module ID_csr_transfer #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(

    input wire clk,
    input wire rst,

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
    output logic sscratch_wen,


    input [ADDR_WIDTH-1:0] IF_pc_addr,
    input [ADDR_WIDTH-1:0] ID_pc_addr,
    input [ADDR_WIDTH-1:0] EXE_pc_addr,
    input [ADDR_WIDTH-1:0] MEM_pc_addr,

    // From IF::IM


    // From IF::Decoder

    // From EXE::ALU

    // From MEM::DM


    // From controller


    // Output Signals
    logic [3:0] state_o,
    logic [ADDR_WIDTH-1:0] pc_nxt_exception
);

    assign rs1_o = rs1_i;

    // If state == STATE_SEQ, signal_o = signal_o_normal (comb)
    // Elif state == STATE_BLOCK, write disabled
    // Elif state == STATE_CATCH, signal_o = signal_o_catch (reg)
    typedef enum logic [3:0] { 
        STATE_SEQ,
        STATE_BLOCK,
        STATE_CATCH
    } state_t;
    state_t state;
    assign state_o = state;

    priviledge_mode_t priviledge_mode_o_normal;
    mtvec_t mtvec_o_normal;
    mscratch_t mscratch_o_normal;
    mepc_t mepc_o_normal;
    mcause_t mcause_o_normal;
    mstatus_t mstatus_o_normal;
    mie_t mie_o_normal;
    mip_t mip_o_normal;
    mtval_t mtval_o_normal;
    mideleg_t mideleg_o_normal;
    medeleg_t medeleg_o_normal;
    satp_t satp_o_normal;
    sepc_t sepc_o_normal;
    scause_t scause_o_normal;
    stval_t stval_o_normal;
    stvec_t stvec_o_normal;
    sscratch_t sscratch_o_normal;

    logic priviledge_mode_wen_normal;
    logic mtvec_wen_normal;
    logic mscratch_wen_normal;
    logic mepc_wen_normal;
    logic mcause_wen_normal;
    logic mstatus_wen_normal;
    logic mie_wen_normal;
    logic mip_wen_normal;
    logic mtval_wen_normal;
    logic mideleg_wen_normal;
    logic medeleg_wen_normal;
    logic satp_wen_normal;
    logic sepc_wen_normal;
    logic scause_wen_normal;
    logic stval_wen_normal;
    logic stvec_wen_normal;
    logic sscratch_wen_normal;

    priviledge_mode_t priviledge_mode_o_catch;
    mtvec_t mtvec_o_catch;
    mscratch_t mscratch_o_catch;
    mepc_t mepc_o_catch;
    mcause_t mcause_o_catch;
    mstatus_t mstatus_o_catch;
    mie_t mie_o_catch;
    mip_t mip_o_catch;
    mtval_t mtval_o_catch;
    mideleg_t mideleg_o_catch;
    medeleg_t medeleg_o_catch;
    satp_t satp_o_catch;
    sepc_t sepc_o_catch;
    scause_t scause_o_catch;
    stval_t stval_o_catch;
    stvec_t stvec_o_catch;
    sscratch_t sscratch_o_catch;

    logic priviledge_mode_wen_catch;
    logic mtvec_wen_catch;
    logic mscratch_wen_catch;
    logic mepc_wen_catch;
    logic mcause_wen_catch;
    logic mstatus_wen_catch;
    logic mie_wen_catch;
    logic mip_wen_catch;
    logic mtval_wen_catch;
    logic mideleg_wen_catch;
    logic medeleg_wen_catch;
    logic satp_wen_catch;
    logic sepc_wen_catch;
    logic scause_wen_catch;
    logic stval_wen_catch;
    logic stvec_wen_catch;
    logic sscratch_wen_catch;

    // Multiplex selector
    always_comb begin

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

        case (state)
            STATE_SEQ: begin
                priviledge_mode_o = priviledge_mode_o_normal;
                mtvec_o = mtvec_o_normal;
                mscratch_o = mscratch_o_normal;
                mepc_o = mepc_o_normal;
                mcause_o = mcause_o_normal;
                mstatus_o = mstatus_o_normal;
                mie_o = mie_o_normal;
                mip_o = mip_o_normal;
                mtval_o = mtval_o_normal;
                mideleg_o = mideleg_o_normal;
                medeleg_o = medeleg_o_normal;
                satp_o = satp_o_normal;
                sepc_o = sepc_o_normal;
                scause_o = scause_o_normal;
                stval_o = stval_o_normal;
                stvec_o = stvec_o_normal;
                sscratch_o = sscratch_o_normal;

                priviledge_mode_wen = priviledge_mode_wen_normal;
                mtvec_wen = mtvec_wen_normal;
                mscratch_wen = mscratch_wen_normal;
                mepc_wen = mepc_wen_normal;
                mcause_wen = mcause_wen_normal;
                mstatus_wen = mstatus_wen_normal;
                mie_wen = mie_wen_normal;
                mip_wen = mip_wen_normal;
                mtval_wen = mtval_wen_normal;
                mideleg_wen = mideleg_wen_normal;
                medeleg_wen = medeleg_wen_normal;
                satp_wen = satp_wen_normal;
                sepc_wen = sepc_wen_normal;
                scause_wen = scause_wen_normal;
                stval_wen = stval_wen_normal;
                stvec_wen = stvec_wen_normal;
                sscratch_wen = sscratch_wen_normal;
            end

            STATE_CATCH: begin
                priviledge_mode_o = priviledge_mode_o_catch;
                mtvec_o = mtvec_o_catch;
                mscratch_o = mscratch_o_catch;
                mepc_o = mepc_o_catch;
                mcause_o = mcause_o_catch;
                mstatus_o = mstatus_o_catch;
                mie_o = mie_o_catch;
                mip_o = mip_o_catch;
                mtval_o = mtval_o_catch;
                mideleg_o = mideleg_o_catch;
                medeleg_o = medeleg_o_catch;
                satp_o = satp_o_catch;
                sepc_o = sepc_o_catch;
                scause_o = scause_o_catch;
                stval_o = stval_o_catch;
                stvec_o = stvec_o_catch;
                sscratch_o = sscratch_o_catch;

                priviledge_mode_wen = priviledge_mode_wen_catch;
                mtvec_wen = mtvec_wen_catch;
                mscratch_wen = mscratch_wen_catch;
                mepc_wen = mepc_wen_catch;
                mcause_wen = mcause_wen_catch;
                mstatus_wen = mstatus_wen_catch;
                mie_wen = mie_wen_catch;
                mip_wen = mip_wen_catch;
                mtval_wen = mtval_wen_catch;
                mideleg_wen = mideleg_wen_catch;
                medeleg_wen = medeleg_wen_catch;
                satp_wen = satp_wen_catch;
                sepc_wen = sepc_wen_catch;
                scause_wen = scause_wen_catch;
                stval_wen = stval_wen_catch;
                stvec_wen = stvec_wen_catch;
                sscratch_wen = sscratch_wen_catch;
            end
        endcase
    end
    
    
    // 1. Generate for normal condition: CSR operations
    logic [DATA_WIDTH-1:0] calc_result; // intermediate variable
    always_comb begin
        // Init
        priviledge_mode_o_normal = 0;
        mtvec_o_normal = 0;
        mscratch_o_normal = 0;
        mepc_o_normal = 0;
        mcause_o_normal = 0;
        mstatus_o_normal = 0;
        mie_o_normal = 0;
        mip_o_normal = 0;
        mtval_o_normal = 0;
        mideleg_o_normal = 0;
        medeleg_o_normal = 0;
        satp_o_normal = 0;
        sepc_o_normal = 0;
        scause_o_normal = 0;
        stval_o_normal = 0;
        stvec_o_normal = 0;
        sscratch_o_normal = 0;

        priviledge_mode_wen_normal = 0;
        mtvec_wen_normal = 0;
        mscratch_wen_normal = 0;
        mepc_wen_normal = 0;
        mcause_wen_normal = 0;
        mstatus_wen_normal = 0;
        mie_wen_normal = 0;
        mip_wen_normal = 0;
        mtval_wen_normal = 0;
        mideleg_wen_normal = 0;
        medeleg_wen_normal = 0;
        satp_wen_normal = 0;
        sepc_wen_normal = 0;
        scause_wen_normal = 0;
        stval_wen_normal = 0;
        stvec_wen_normal = 0;
        sscratch_wen_normal = 0;

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
                `CSR_MTVEC_ADDR: begin mtvec_o_normal = calc_result; mtvec_wen_normal = 1; end
                `CSR_MSCRATCH_ADDR: begin mscratch_o_normal = calc_result; mscratch_wen_normal = 1; end
                `CSR_MEPC_ADDR: begin mepc_o_normal = calc_result; mepc_wen_normal = 1; end
                `CSR_MCAUSE_ADDR: begin mcause_o_normal = calc_result; mcause_wen_normal = 1; end
                `CSR_MSTATUS_ADDR: begin mstatus_o_normal = calc_result; mstatus_wen_normal = 1; end
                `CSR_MIE_ADDR: begin mie_o_normal = calc_result; mie_wen_normal = 1; end
                `CSR_MIP_ADDR: begin mip_o_normal = calc_result; mip_wen_normal = 1; end
                `CSR_MTVAL_ADDR: begin mtval_o_normal = calc_result; mtval_wen_normal = 1; end
                `CSR_MIDELEG_ADDR: begin mideleg_o_normal = calc_result; mideleg_wen_normal = 1; end
                `CSR_MEDELEG_ADDR: begin medeleg_o_normal = calc_result; medeleg_wen_normal = 1; end
                `CSR_SATP_ADDR: begin satp_o_normal = calc_result; satp_wen_normal = 1; end
                `CSR_SEPC_ADDR: begin sepc_o_normal = calc_result; sepc_wen_normal = 1; end
                `CSR_SCAUSE_ADDR: begin scause_o_normal = calc_result; scause_wen_normal = 1; end
                `CSR_STVAL_ADDR: begin stval_o_normal = calc_result; stval_wen_normal = 1; end
                `CSR_STVEC_ADDR: begin stvec_o_normal = calc_result; stvec_wen_normal = 1; end
                `CSR_SSCRATCH_ADDR: begin sscratch_o_normal = calc_result; sscratch_wen_normal = 1; end
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


    // 2. Generate for exception or interrupt condition
    typedef enum logic [3:0] { 
        EXCEPTION_DM,
        EXCEPTION_EXE,
        EXCEPTION_ID,
        EXCEPTION_IF,
        INTERRUPT_TIMER, // async
        NORMAL
    } exception_stage_t;
    exception_stage_t exception_stage_reg;

    // intermediate variables
    logic [30:0] exception_operand_for_ecall_ebreak;

    always_ff @(posedge clk) begin

        if (rst) begin

            state <= STATE_SEQ;
            exception_stage_reg <= NORMAL;

            priviledge_mode_o_catch <= 0;
            mtvec_o_catch <= 0;
            mscratch_o_catch <= 0;
            mepc_o_catch <= 0;
            mcause_o_catch <= 0;
            mstatus_o_catch <= 0;
            mie_o_catch <= 0;
            mip_o_catch <= 0;
            mtval_o_catch <= 0;
            mideleg_o_catch <= 0;
            medeleg_o_catch <= 0;
            satp_o_catch <= 0;
            sepc_o_catch <= 0;
            scause_o_catch <= 0;
            stval_o_catch <= 0;
            stvec_o_catch <= 0;
            sscratch_o_catch <= 0;

            priviledge_mode_wen_catch <= 0;
            mtvec_wen_catch <= 0;
            mscratch_wen_catch <= 0;
            mepc_wen_catch <= 0;
            mcause_wen_catch <= 0;
            mstatus_wen_catch <= 0;
            mie_wen_catch <= 0;
            mip_wen_catch <= 0;
            mtval_wen_catch <= 0;
            mideleg_wen_catch <= 0;
            medeleg_wen_catch <= 0;
            satp_wen_catch <= 0;
            sepc_wen_catch <= 0;
            scause_wen_catch <= 0;
            stval_wen_catch <= 0;
            stvec_wen_catch <= 0;
            sscratch_wen_catch <= 0;

        end else begin

            if (state == STATE_SEQ || state == STATE_BLOCK) begin
                if ((csr_opcode == `CSR_OP_ECALL || csr_opcode == `CSR_OP_EBREAK) && EXCEPTION_ID < exception_stage_reg) begin
                    exception_stage_reg <= EXCEPTION_ID;

                    if (priviledge_mode_i <= `PRIVILEDGE_MODE_S && medeleg_i[exception_operand_for_ecall_ebreak]) begin // delegated to S level

                        sepc_o_catch <= ID_pc_addr; sepc_wen_catch <= 1;
                        pc_nxt_exception <= stvec_i;
                        scause_o_catch <= {1'b0, exception_operand_for_ecall_ebreak}; scause_wen_catch <= 1;
                        stval_o_catch <= 0; stval_wen_catch <= 1;
                        mstatus_o_catch <= {
                            mstatus_i[31:13],
                            mstatus_i.mpp,
                            mstatus_i.trash_1,
                            priviledge_mode_i[0],  // spp <= priv level
                            mstatus_i.mpie, 
                            mstatus_i.trash_2,
                            mstatus_i.sie, // spie <= sie
                            mstatus_i.upie, 
                            mstatus_i.mie,
                            mstatus_i.trash_3, 
                            1'b0,  // sie 
                            mstatus_i.uie
                        }; mstatus_wen_catch <= 1;

                        priviledge_mode_o_catch <= `PRIVILEDGE_MODE_S; priviledge_mode_wen_catch <= 1;

                    end else begin  // M level
                        
                        mepc_o_catch <= ID_pc_addr; mepc_wen_catch <= 1;
                        pc_nxt_exception <= mtvec_i;
                        mcause_o_catch <= {1'b0, exception_operand_for_ecall_ebreak}; mcause_wen_catch <= 1;
                        mtval_o_catch <= 0; mtval_wen_catch <= 1;
                        mstatus_o_catch <= {
                            mstatus_i[31:13],
                            priviledge_mode_i, // mpp
                            mstatus_i.trash_1,
                            mstatus_i.spp,
                            mstatus_i.mie,  // mpie <= mie
                            mstatus_i.trash_2,
                            mstatus_i.spie, mstatus_i.upie, 1'b0, // mie
                            mstatus_i.trash_3, mstatus_i.sie, mstatus_i.uie
                        }; mstatus_wen_catch <= 1;

                        priviledge_mode_o_catch <= `PRIVILEDGE_MODE_M; priviledge_mode_wen_catch <= 1;
                    end
                end

                else if ((csr_opcode == `CSR_OP_URET || csr_opcode == `CSR_OP_SRET || csr_opcode == `CSR_OP_MRET) && EXCEPTION_ID < exception_stage_reg) begin
                    exception_stage_reg <= EXCEPTION_ID;

                    if (csr_opcode == `CSR_OP_MRET) begin

                        // The MRET, SRET, or URET instructions are used to return from traps in M-mode, S-mode, or U-mode respectively. 
                        // When executing an xRET instruction, supposing xPP holds the value y, 
                        // xIE is set to xPIE; 
                        // the privilege mode is changed to y; 
                        // xPIE is set to 1; 
                        // and xPP is set to U (or M if user-mode is not supported).
                        pc_nxt_exception <= mepc_i;
                        mstatus_o_catch <= {
                            mstatus_i[31:13],
                            `PRIVILEDGE_MODE_U,  // mpp <= M 
                            mstatus_i.trash_1,
                            mstatus_i.spp,
                            1'b1,  // mpie <= mie
                            mstatus_i.trash_2,
                            mstatus_i.spie, mstatus_i.upie, 
                            mstatus_i.mpie, // mie <= mpie
                            mstatus_i.trash_3, mstatus_i.sie, mstatus_i.uie
                        }; mstatus_wen_catch <= 1;

                        priviledge_mode_o_catch <= mstatus_i.mpp; priviledge_mode_wen_catch <= 1;

                    end else if (csr_opcode == `CSR_OP_SRET) begin
                        pc_nxt_exception <= sepc_i;
                        mstatus_o_catch <= {
                            mstatus_i[31:13],
                            mstatus_i.mpp
                            mstatus_i.trash_1,
                            1'b0,  // spp <= U
                            mstatus_i.mpie
                            mstatus_i.trash_2,
                            1'b1,  // spie <= 1 
                            mstatus_i.upie, 
                            mstatus_i.mie,
                            mstatus_i.trash_3, 
                            mstatus_i.spie, // sie <= spie
                            mstatus_i.uie
                        }; mstatus_wen_catch <= 1;
                        priviledge_mode_o_catch <= {1'b0, mstatus_i.spp}; priviledge_mode_wen_catch <= 1;

                    end else if (csr_opcode == `CSR_OP_URET) begin
                        // No one cares you.
                        // Todo: raise IllegalInstructionException
                    end

                end


                else if (mip_i.mtip & mie_i.mtie) begin

                    // This interrupt cannot be delegated
                    if ( priviledge_mode_i < `PRIVILEDGE_MODE_M || (priviledge_mode_i == `PRIVILEDGE_MODE_M && mstatus_i.mie)) begin

                        cause_comb = {1'b1, `INTERRUPT_MACHINE_TIMER};


                    end

                    
                end

                else if (mip_i.stip & mie_i.stie) begin

                    // Forwarded exception
                    if (priviledge_mode_i < `PRIVILEDGE_MODE_S || (priviledge_mode_i == `PRIVILEDGE_MODE_S && mstatus_i.sie)) begin


                    end
                end
            end else begin
                // reset
                state <= STATE_SEQ;
                exception_stage_reg <= NORMAL;

                priviledge_mode_o_catch <= 0;
                mtvec_o_catch <= 0;
                mscratch_o_catch <= 0;
                mepc_o_catch <= 0;
                mcause_o_catch <= 0;
                mstatus_o_catch <= 0;
                mie_o_catch <= 0;
                mip_o_catch <= 0;
                mtval_o_catch <= 0;
                mideleg_o_catch <= 0;
                medeleg_o_catch <= 0;
                satp_o_catch <= 0;
                sepc_o_catch <= 0;
                scause_o_catch <= 0;
                stval_o_catch <= 0;
                stvec_o_catch <= 0;
                sscratch_o_catch <= 0;

                priviledge_mode_wen_catch <= 0;
                mtvec_wen_catch <= 0;
                mscratch_wen_catch <= 0;
                mepc_wen_catch <= 0;
                mcause_wen_catch <= 0;
                mstatus_wen_catch <= 0;
                mie_wen_catch <= 0;
                mip_wen_catch <= 0;
                mtval_wen_catch <= 0;
                mideleg_wen_catch <= 0;
                medeleg_wen_catch <= 0;
                satp_wen_catch <= 0;
                sepc_wen_catch <= 0;
                scause_wen_catch <= 0;
                stval_wen_catch <= 0;
                stvec_wen_catch <= 0;
                sscratch_wen_catch <= 0;
            end

        end

    end

    always_comb begin
        exception_operand_for_ecall_ebreak = 0;
        if (csr_opcode == `CSR_OP_ECALL) begin
            if (priviledge_mode_i == `PRIVILEDGE_MODE_U) begin
                exception_operand_for_ecall_ebreak = `EXCEPTION_ENVIRONMENT_CALL_U;
            end

            else if (priviledge_mode_i == `PRIVILEDGE_MODE_S) begin
                exception_operand_for_ecall_ebreak = `EXCEPTION_ENVIRONMENT_CALL_S;
            end

            else if (priviledge_mode_i == `PRIVILEDGE_MODE_M) begin
                exception_operand_for_ecall_ebreak = `EXCEPTION_ENVIRONMENT_CALL_M;
            end
        end else if (csr_opcode == `CSR_OP_EBREAK) begin
            exception_operand_for_ecall_ebreak = `EXCEPTION_BREAKPOINT;
        end
    end



endmodule