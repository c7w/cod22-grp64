`ifndef MEM_H
`define MEM_H

// Virtual Address (VA)
`define OFFSET_WIDTH 12
typedef struct packed {
    logic [9:0] vpn1;
    logic [9:0] vpn0;
    logic [`OFFSET_WIDTH-1:0] offset;
} virt_addr_t;

// Page Table Entry (Sv32)
typedef struct packed {
    logic [11:0] ppn1;
    logic [9:0] ppn0;
    logic [1:0] rsw;  // Reserved for supervisor
    logic D, A, G, U, X, W, R, V;
} pte_t;


// TLB Entry
`define TLBT_WIDTH 5  // TLB Tag
`define TLBI_WIDTH 32-`TLBT_WIDTH-`OFFSET_WIDTH  // TLB Index
typedef struct packed {
    logic [`TLBI_WIDTH-1:0] tlbi;
    logic [8:0] asid;
    logic pte_t pte;
    logic valid;
} tlbe_t;

typedef struct packed {
    logic [`TLBI_WIDTH-1:0] tlbi;
    logic [`TLBT_WIDTH-1:0] tlbt;
    logic [`OFFSET_WIDTH-1:0] offset;
} tlb_query_t; 


// Cache
`define CACHE_TAG_WIDTH 12
typedef struct packed {
    logic [32-`CACHE_TAG_WIDTH-1:0] phys_index;
    logic [31:0] data;
    logic dirty;
    logic valid;
} cache_entry_t;

typedef struct packed {
    logic [32-`CACHE_TAG_WIDTH-1:0] phys_index;
    logic [`CACHE_TAG_WIDTH-1:0] phys_tag;
} cache_query_t;
`endif