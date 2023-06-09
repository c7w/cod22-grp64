`ifndef EXCEPTION_H

`define EXCEPTION_H
`define CSR_ADDR_WIDTH 12
`define MXLEN 32
`define MSTATUS_WRITE_MASK 32'b10000000011111111111100110111011
`define SSTATUS_WRITE_MASK 32'b1_00000000000_11_0_1111_0000_1_00_11_00_11

`define SIE_WRITE_MASK 32'b00000000000000000000001100110011
`define SIP_WRITE_MASK 32'b00000000000000000000001100110011


// CSRs
// Ref: https://www.five-embeddev.com/quickref/csrs.html

/* Start: Definition of CSRs */
typedef logic[1:0] priviledge_mode_t;
`define PRIVILEDGE_MODE_U 2'b00
`define PRIVILEDGE_MODE_S 2'b01
`define PRIVILEDGE_MODE_M 2'b11

`define CSR_MTVEC_ADDR `CSR_ADDR_WIDTH'h305
typedef struct packed {
    logic [`MXLEN-3:0] base;
    logic [1:0] mode;
} mtvec_t;

`define CSR_MSCRATCH_ADDR `CSR_ADDR_WIDTH'h340
typedef logic[`MXLEN-1:0] mscratch_t;

`define CSR_MEPC_ADDR `CSR_ADDR_WIDTH'h341
typedef logic[`MXLEN-1:0] mepc_t;

`define CSR_MCAUSE_ADDR `CSR_ADDR_WIDTH'h342
typedef struct packed {
    logic interrupt;
    logic[`MXLEN-2:0] exception_code;
} mcause_t;

`define CSR_MSTATUS_ADDR `CSR_ADDR_WIDTH'h300
`define CSR_SSTATUS_ADDR `CSR_ADDR_WIDTH'h100
typedef struct packed {
    logic sd; 
    logic[7:0] trash_0;
    logic tsr, tw, tvm, mxr, sum, mprv;
    logic[1:0] xs, fs, mpp, trash_1;
    logic spp, mpie, trash_2, spie, upie, mie, trash_3, sie, uie;
} mstatus_t;

`define CSR_MIE_ADDR `CSR_ADDR_WIDTH'h304
`define CSR_SIE_ADDR `CSR_ADDR_WIDTH'h104
typedef struct packed {
    logic[`MXLEN-13:0] trash_0;
    logic meie, trash_1, seie, ueie, mtie, trash_2, stie, utie, msie, trash_3, ssie, usie;
} mie_t;

`define CSR_MIP_ADDR `CSR_ADDR_WIDTH'h344
`define CSR_SIP_ADDR `CSR_ADDR_WIDTH'h144
typedef struct packed {
    logic[`MXLEN-13:0] trash_0;
    logic meip, trash_1, seip, ueip, mtip, trash_2, stip, utip, msip, trash_3, ssip, usip;
} mip_t;

`define CSR_MTVAL_ADDR `CSR_ADDR_WIDTH'h343
typedef logic[`MXLEN-1:0] mtval_t;

`define CSR_MIDELEG_ADDR `CSR_ADDR_WIDTH'h303
typedef logic[`MXLEN-1:0] mideleg_t;

`define CSR_MEDELEG_ADDR `CSR_ADDR_WIDTH'h302
typedef logic[`MXLEN-1:0] medeleg_t;

`define CSR_SATP_ADDR `CSR_ADDR_WIDTH'h180
typedef struct packed {
    logic mode;
    logic [8:0] asid;
    logic [21:0] ppn;
} satp_t;

`define CSR_SEPC_ADDR `CSR_ADDR_WIDTH'h141
typedef logic[`MXLEN-1:0] sepc_t;

`define CSR_SCAUSE_ADDR `CSR_ADDR_WIDTH'h142
typedef struct packed {
    logic interrupt;
    logic[`MXLEN-2:0] exception_code;
} scause_t;

`define CSR_STVAL_ADDR `CSR_ADDR_WIDTH'h143
typedef logic[`MXLEN-1:0] stval_t;

`define CSR_STVEC_ADDR `CSR_ADDR_WIDTH'h105
typedef struct packed {
    logic [`MXLEN-3:0] base;
    logic [1:0] mode;
} stvec_t;

`define CSR_SSCRATCH_ADDR `CSR_ADDR_WIDTH'h140
typedef logic[`MXLEN-1:0] sscratch_t;
/* End: Definition of CSRs */


/* Start: Definition for opcodes of CSR management instructions */
`define CSR_OP_WIDTH 4
`define CSR_OP_CSRRW `CSR_OP_WIDTH'd0
`define CSR_OP_CSRRS `CSR_OP_WIDTH'd1
`define CSR_OP_CSRRC `CSR_OP_WIDTH'd2
`define CSR_OP_CSRRWI `CSR_OP_WIDTH'd3
`define CSR_OP_CSRRSI `CSR_OP_WIDTH'd4
`define CSR_OP_CSRRCI `CSR_OP_WIDTH'd5
`define CSR_OP_ECALL `CSR_OP_WIDTH'd6
`define CSR_OP_EBREAK `CSR_OP_WIDTH'd7
`define CSR_OP_URET `CSR_OP_WIDTH'd8
`define CSR_OP_SRET `CSR_OP_WIDTH'd9
`define CSR_OP_MRET `CSR_OP_WIDTH'd10
typedef enum logic [`CSR_OP_WIDTH-1:0] {
    CSR_OP_CSRRW,
    CSR_OP_CSRRS,
    CSR_OP_CSRRC,
    CSR_OP_CSRRWI,
    CSR_OP_CSRRSI,
    CSR_OP_CSRRCI,
    CSR_OP_ECALL,
    CSR_OP_EBREAK,
    CSR_OP_URET,
    CSR_OP_SRET,
    CSR_OP_MRET,
    CSR_OP_UNKNOWN=15
} csr_op_t;
/* End: Definition for opcodes of CSR management instructions */


/* Start: Definition of constants */
`define INTERRUPT_SUPERVISOR_TIMER 31'd5
`define INTERRUPT_MACHINE_TIMER 31'd7
`define INTERRUPT_UNKNOWN {31{1'b1}}

`define EXCEPTION_ILLEGAL_INSTRUCTION 31'd2  // mtval <= instr
`define EXCEPTION_BREAKPOINT 31'd3  // mtval <= pc_addr

`define EXCEPTION_ENVIRONMENT_CALL_U 31'd8
`define EXCEPTION_ENVIRONMENT_CALL_S 31'd9
`define EXCEPTION_ENVIRONMENT_CALL_M 31'd11

// mtval <= virt_addr
`define EXCEPTION_INSTRUCTION_PAGE_FAULT 31'd12
`define EXCEPTION_LOAD_PAGE_FAULT 31'd13
`define EXCEPTION_STORE_PAGE_FAULT 31'd15

`define EXCEPTION_INSTRUCTION_ADDRESS_MISALIGNED 31'h0
`define EXCEPTION_LOAD_ADDRESS_MISALIGNED 31'h4
`define EXCEPTION_STORE_ADDRESS_MISALIGNED 31'h6

/* End: Definition of constants */


/* Start: Definition of BTB Table */
// I'm too lazy to create a new file for this :(
`define BTBO_WIDTH 2
`define BTBI_WIDTH 4  // TLB Index. 16 Entries.
`define BTBT_WIDTH 32-`BTBI_WIDTH-`BTBO_WIDTH  // TLB Tag

typedef struct packed {
    logic [`BTBT_WIDTH-1:0] tag_from;
    logic valid;
    logic [`BTBT_WIDTH-1:0] tag_to;
    logic [`BTBI_WIDTH-1:0] index_to;
} btbe_t;

typedef struct packed {
    logic [`BTBT_WIDTH-1:0] tag;
    logic [`BTBI_WIDTH-1:0] index;
    logic [`BTBO_WIDTH-1:0] offset;
} btb_query_t; 

/* End: Definition of BTB Table */


`endif