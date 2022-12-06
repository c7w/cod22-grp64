`include "../headers/mem.svh"
`include "../headers/exception.svh"

module MMU_tlb #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
) (

    input wire clk,
    input wire rst,

    // CPU -> TLB
    input wire mstatus_t mstatus_i,
    input wire priviledge_mode_t priviledge_mode_i,
    input wire satp_t satp_i,
    input wire query_en,
    input wire query_wen,
    input wire virt_addr_t virt_addr,
    input wire [DATA_WIDTH-1:0] query_data_i,
    input wire [2:0] query_width,
    input wire query_sign_ext,
    input wire tlb_flush,  // must ensure query_en = 1
    input wire fence_i,
    input wire fence_i_wb,  // can be used to identify IM or DM
                            // where IM needs execution permission

    // TLB -> CPU
    output logic query_ack,
    output logic [DATA_WIDTH-1:0] query_data_o,
    output logic query_exception,
    output logic [`MXLEN-2:0] query_exception_code,

    // Translation Unit -> TLB
    input wire translation_ack,
    input wire translation_error,
    input wire pte_t translation_result,

    // TLB -> Translation Unit
    output logic [DATA_WIDTH-1:0] satp_o,
    output logic translation_en,
    output virt_addr_t translation_addr,

    // Cache -> TLB
    input wire cache_ack,
    input wire [DATA_WIDTH-1:0] cache_data_i,

    // TLB -> Cache
    output logic cache_en,
    output logic cache_wen,
    output logic [2:0] cache_width,
    output logic cache_sign_ext,
    output logic [ADDR_WIDTH-1:0] cache_addr,  // phys addr
    output logic [DATA_WIDTH-1:0] cache_data_o,

    // TLB -> Wishbone master
    output logic master_owner

);
    // Buffer
    tlbe_t tlb_table [0:31];

    // cast virt_addr_t type to tlb_query_t type
    wire tlb_query_t tlb_query;
    assign tlb_query = virt_addr;

    // Whether enable virtual address or not
    tlbe_t tlb_entry;
    always_comb begin
        if (satp_i.mode & priviledge_mode_i != 2'b11) begin
            // Sv32
            tlb_entry = tlb_table[tlb_query.tlbt];
        end else begin
            // Must TLB Hit
            tlb_entry = {
                tlb_query.tlbi,
                satp_i.asid,
                2'b00, tlb_query.tlbi, tlb_query.tlbt, 2'b00,
                8'b00001111,
                1'b1
            };
        end
    end

    wire tlb_hit;
    assign tlb_hit = query_en & (tlb_entry.tlbi == tlb_query.tlbi) & (tlb_entry.asid == satp_i.asid || tlb_entry.pte.G) & tlb_entry.valid;

    logic [ADDR_WIDTH-1:0] tlb_phys_addr;
    always_comb begin
        if (tlb_hit) begin
            tlb_phys_addr = {tlb_entry.pte.ppn1[9:0], tlb_entry.pte.ppn0, virt_addr.offset};
        end
        else begin
            tlb_phys_addr = 32'hffffffff;  // Disabled
        end
    end

    logic [ADDR_WIDTH-1:0] trans_unit_phys_addr;
    always_comb begin
        if (translation_ack) begin
            trans_unit_phys_addr = {translation_result.ppn1[9:0], translation_result.ppn0, virt_addr.offset};
        end else begin
            trans_unit_phys_addr = 32'hffffffff;
            // trans_unit_phys_addr would be written in TLB the next time cycle, so no need to cache it
        end
    end


    // TLB -> CPU
    assign query_ack = (~query_en & ~fence_i) | (fence_i & cache_ack) | query_exception | (tlb_hit & cache_ack) | (tlb_flush & cache_ack);
    reg [DATA_WIDTH-1:0] query_data_o_reg;
    always_comb begin
        if (cache_ack) begin
            query_data_o = cache_data_i;
        end
        else begin
            query_data_o = query_data_o_reg;
        end
    end


    // TLB -> Translation unit
    assign satp_o = satp_i;
    always_comb begin
        if (satp_i.mode & ~tlb_hit & ~translation_ack & query_en) begin
            translation_en = 1;
            translation_addr = virt_addr;
        end else begin
            translation_en = 0;
            translation_addr = 32'hffffffff;
        end
    end


    // TLB -> cache
    always_comb begin
        cache_en = 0; cache_wen = 0;
        cache_addr = 0; cache_data_o = query_data_i;
        cache_width = query_width; cache_sign_ext = query_sign_ext;

        if (~query_en | query_exception) begin
            // Do nothing when not querying or raising exception
        end

        else if (tlb_hit) begin
            cache_en = 1; cache_wen = query_wen; cache_addr = tlb_phys_addr;
        end

        else begin
            if (translation_ack) begin
                cache_en = 1; cache_wen = query_wen; 
                cache_addr = trans_unit_phys_addr;
            end
        end
    end

    // TLB -> Wishbone master
    always_comb begin
        if (tlb_hit | translation_ack | fence_i) begin
            master_owner = 1'b0;  // cache, by default
        end
        else begin
            master_owner = 1'b1;  // translation unit
        end
    end


    // Whether it's exception? Pure combinational logic.
    always_comb begin
        query_exception = 0; query_exception_code = 0;
        // We consider the following situations.
        // 1. Attempting to fetch an instruction from a page that does not have execute permissions raises a fetch page-fault exception. 
        // 2. Attempting to execute a load or load-reserved instruction whose effective address lies within a page without read permissions raises a load page-fault exception.
        // 3. Attempting to execute a store, store-conditional (regardless of success), or AMO instruction whose effective address lies within a page without write permissions raises a store page-fault exception.
        // 4. The U bit indicates whether the page is accessible to user mode. If the SUM bit in the sstatus register is 0, S mode software may fault on accesses to user-mode pages. If the privilege mode is U but access page with no U enabled, a page fault is also given.
        // 5. Irrespective of SUM, the supervisor may not execute code on pages with U=1.

        if (~query_en) begin
            // Do nothing
        end

        else if (~fence_i_wb & translation_error) begin
            query_exception = 1; query_exception_code = `EXCEPTION_INSTRUCTION_PAGE_FAULT;
        end

        else if (fence_i_wb & translation_error & ~query_wen) begin
            query_exception = 1; query_exception_code = `EXCEPTION_LOAD_PAGE_FAULT;
        end

        else if (fence_i_wb & translation_error & query_wen) begin
            query_exception = 1; query_exception_code = `EXCEPTION_STORE_PAGE_FAULT;
        end

        else if ( ~fence_i_wb & tlb_hit & (~tlb_entry.pte.V | ~tlb_entry.pte.X )) begin
            query_exception = 1; query_exception_code = `EXCEPTION_INSTRUCTION_PAGE_FAULT;
        end

        else if (fence_i_wb & tlb_hit & ~query_wen & (~tlb_entry.pte.V | ~tlb_entry.pte.R )) begin
            query_exception = 1; query_exception_code = `EXCEPTION_LOAD_PAGE_FAULT;
        end

        else if (fence_i_wb & tlb_hit & query_wen & (~tlb_entry.pte.V | ~tlb_entry.pte.W) ) begin
            query_exception = 1; query_exception_code = `EXCEPTION_STORE_PAGE_FAULT;
        
        end else if (
            // Read / Write U page in S mode with SUM clear | Execute U page in S mode
            (priviledge_mode_i == `PRIVILEDGE_MODE_S & tlb_hit & tlb_entry.pte.U & (~mstatus_i.sum | ~fence_i_wb)) |
            (priviledge_mode_i == `PRIVILEDGE_MODE_U & tlb_hit & ~tlb_entry.pte.U)
        ) begin
            if (query_wen) begin
                query_exception = 1; query_exception_code = `EXCEPTION_STORE_PAGE_FAULT;
            end else if (~query_wen & fence_i_wb) begin
                query_exception = 1; query_exception_code = `EXCEPTION_LOAD_PAGE_FAULT;
            end else if (~query_wen & ~fence_i_wb) begin
                query_exception = 1; query_exception_code = `EXCEPTION_INSTRUCTION_PAGE_FAULT;
            end
        end
    end


    // Write
    always_ff @( posedge clk ) begin

        if (rst) begin

            tlb_table[0] <= 0;
            tlb_table[1] <= 0;
            tlb_table[2] <= 0;
            tlb_table[3] <= 0;
            tlb_table[4] <= 0;
            tlb_table[5] <= 0;
            tlb_table[6] <= 0;
            tlb_table[7] <= 0;
            tlb_table[8] <= 0;
            tlb_table[9] <= 0;
            tlb_table[10] <= 0;
            tlb_table[11] <= 0;
            tlb_table[12] <= 0;
            tlb_table[13] <= 0;
            tlb_table[14] <= 0;
            tlb_table[15] <= 0;
            tlb_table[16] <= 0;
            tlb_table[17] <= 0;
            tlb_table[18] <= 0;
            tlb_table[19] <= 0;
            tlb_table[20] <= 0;
            tlb_table[21] <= 0;
            tlb_table[22] <= 0;
            tlb_table[23] <= 0;
            tlb_table[24] <= 0;
            tlb_table[25] <= 0;
            tlb_table[26] <= 0;
            tlb_table[27] <= 0;
            tlb_table[28] <= 0;
            tlb_table[29] <= 0;
            tlb_table[30] <= 0;
            tlb_table[31] <= 0;

        end

        else begin

            if (tlb_flush) begin
                    // $display("FLUSH TLB");
                    tlb_table[0] <= 0;
                    tlb_table[1] <= 0;
                    tlb_table[2] <= 0;
                    tlb_table[3] <= 0;
                    tlb_table[4] <= 0;
                    tlb_table[5] <= 0;
                    tlb_table[6] <= 0;
                    tlb_table[7] <= 0;
                    tlb_table[8] <= 0;
                    tlb_table[9] <= 0;
                    tlb_table[10] <= 0;
                    tlb_table[11] <= 0;
                    tlb_table[12] <= 0;
                    tlb_table[13] <= 0;
                    tlb_table[14] <= 0;
                    tlb_table[15] <= 0;
                    tlb_table[16] <= 0;
                    tlb_table[17] <= 0;
                    tlb_table[18] <= 0;
                    tlb_table[19] <= 0;
                    tlb_table[20] <= 0;
                    tlb_table[21] <= 0;
                    tlb_table[22] <= 0;
                    tlb_table[23] <= 0;
                    tlb_table[24] <= 0;
                    tlb_table[25] <= 0;
                    tlb_table[26] <= 0;
                    tlb_table[27] <= 0;
                    tlb_table[28] <= 0;
                    tlb_table[29] <= 0;
                    tlb_table[30] <= 0;
                    tlb_table[31] <= 0;
 
            end else if (query_en) begin
                
                if (translation_ack) begin

                    tlb_table[tlb_query.tlbt] <= {
                        tlb_query.tlbi,
                        satp_i.asid,
                        translation_result,
                        1'b1
                    };

                end else if (cache_ack) begin
                    query_data_o_reg <= cache_data_i;
                end
            end

        end
        
    end

endmodule