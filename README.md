## blabla

[X] 基本流水线

[ ] 数据旁路

[ ] 异常中断、S 态

[ ] 虚存

[ ] RV32I

[ ] 分支预测

[ ] VGA



## TODO

实现 csr 相关指令。使用 trivial 的实现方法：当decode到 7'b1110011 时，流水线暂时退化成多周期（PC stall，IF-ID 插 bubble），跑完这条指令再恢复，以支持“原子操作”

ID->EXE (csr_addr, csr_opcode)

CSR_transition(AllCSRs, csr_addr,  x[rs1], imm, csr_opcode; selected_val)

