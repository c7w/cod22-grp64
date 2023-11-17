# Repo 总不能叫 cod22-grp64 吧

[ [Video](https://www.bilibili.com/video/BV1J24y1Q7s2/) | [uCore](https://github.com/c7w/ucore-cod22-grp64) ]


## 实验过程
- Week 0: 我们要写 NPU，rv32f 硬件加速神经网络训练
- Week 1: 难，那我们写 GPIO，USB， VGA，Flash，整摆年好活
- Week 2: 至少也要把 uCore 跑通吧
- Week 3: 有空吗？跑一下监控程序？

## 心得体会
- 我爱计算机组成原理 —— 高焕昂
- 我也爱计算机组成原理 —— 刘明道
- 我们都爱计算机组成原理 —— 安一帆

## 其它

仿真 Powered by Verilator，在 obj_dir 里有写好的 testbench，Verilator 救我狗命

然后考试寄了等级吃灰，讲真的你们赶紧搞个龙芯杯一口气刷过计原 + 体系结构吧（

## Updated 23/11/17

提几点小小的建议。

- 当时还把 指令译码器 放在 IF 阶段，感觉蠢哭了
- 精确异常，精确异常，精确异常，如果 uCore 起不来可能是因为这个
    - 现在这个异常处理模块的位置放的也不好，最好是放在 WB 阶段，然后一旦有异常就冲刷流水线
    - 但是要注意不要让前面的 MEM 阶段的指令被“提前”执行（说的就是你 lw a5, 0(a5)）
- 当时还试着去优化 Wishbone 总线的状态转移，现在看实在是没必要，写 Cache 就够了，性能测试的测例过于水
- 走过路过给个 Star，方便查重（什么
