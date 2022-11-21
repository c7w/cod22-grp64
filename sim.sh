verilator -Ithinpad_top.srcs/sources_1/new/ \
          -Iobj_dir/null_models \
          -Ithinpad_top.srcs/sources_1/new/headers/ \
          -Ithinpad_top.srcs/sources_1/new/arbiter/ \
          -Ithinpad_top.srcs/sources_1/new/lab4/ \
          -Ithinpad_top.srcs/sources_1/new/lab5/ \
          -Ithinpad_top.srcs/sources_1/new/pipeline/ \
          -Ithinpad_top.srcs/sources_1/ip/pll_example/ \
          -cc thinpad_top.srcs/sources_1/new/async.v thinpad_top.srcs/sources_1/new/thinpad_top.sv \
          
