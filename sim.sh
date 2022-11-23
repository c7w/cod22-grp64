verilator -Wno-SYMRSVDWORD -Wno-CASEINCOMPLETE -Wno-UNSIGNED -Wno-TIMESCALEMOD \
        --timing\
        -Ithinpad_top.srcs/sources_1/new/ \
        -Iobj_dir/null_models \
        -Ithinpad_top.srcs/sources_1/new/headers/ \
        -Ithinpad_top.srcs/sources_1/new/arbiter/ \
        -Ithinpad_top.srcs/sources_1/new/lab4/ \
        -Ithinpad_top.srcs/sources_1/new/lab5/ \
        -Ithinpad_top.srcs/sources_1/new/pipeline/ \
        -Ithinpad_top.srcs/sources_1/ip/pll_example/ \
        -Ithinpad_top.srcs/sources_1/new/async.v \
        -Ithinpad_top.srcs/sim_1/new/ \
        -cc thinpad_top.srcs/sim_1/new/full_model.sv \
        -cc thinpad_top.srcs/sources_1/new/async.v \
        --exe obj_dir/testbench.cpp \
        --top-module full_model \
        --trace
          
make -C obj_dir -f Vfull_model.mk Vfull_model

obj_dir/Vfull_model > sim.out

vcd2fst -v waveform.vcd -f waveform.fst --parallel
rm waveform.vcd



# iverilog -g2012 -o test.out \
#         -Ithinpad_top.srcs/sources_1/new/headers/ \
#         thinpad_top.srcs/sources_1/new/ALU.sv \
#         thinpad_top.srcs/sources_1/new/RegisterFile.sv \
#         thinpad_top.srcs/sources_1/new/arbiter/* \
#         thinpad_top.srcs/sources_1/new/lab4/sram_controller_single.sv \
#         thinpad_top.srcs/sources_1/new/lab5/uart_controller.sv \
#         thinpad_top.srcs/sources_1/new/lab5/wb_mux_3.v \
#         thinpad_top.srcs/sources_1/new/pipeline/*\
#         thinpad_top.srcs/sources_1/ip/pll_example/pll_example.v \
#         thinpad_top.srcs/sources_1/ip/pll_example/pll_example_clk_wiz.v \
#         thinpad_top.srcs/sources_1/new/async.v \
#         obj_dir/null_models/* \
#         -Ithinpad_top.srcs/sim_1/new/ \
#         thinpad_top.srcs/sources_1/new/thinpad_top.sv
