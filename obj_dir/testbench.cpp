#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfull_model.h"
#include "Vfull_model___024unit.h"

#define MAX_RST_TIME ((vluint64_t)(100'000))

#define RECORD_START ((vluint64_t)(1'500'000'000'000))
#define RECORD_END ((vluint64_t)(1'550'000'000'000))
#define MAX_SIM_TIME ((vluint64_t)(2'500'000'000'000))
#define INTERVAL ((vluint64_t)(10'000))
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Vfull_model *dut = new Vfull_model;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");



    while (sim_time < MAX_SIM_TIME) {
        

        if (sim_time % 10'000'000'000 == 0) {
            printf("Current Time: %lld ms\n", sim_time / 1'000'000'000);
        }

        if (sim_time < MAX_RST_TIME) {
            dut->reset_btn = 1;
        } else {
            dut->reset_btn = 0;
        }

        if (sim_time % INTERVAL == 0) {
            dut->clk_50M ^= 1;
            dut->eval();
            if (RECORD_START <= sim_time && sim_time < RECORD_END)
                m_trace->dump(sim_time);
        }

        sim_time += 5'000;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}