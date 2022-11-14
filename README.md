## blabla

[X] 基本流水线

[ ] 数据旁路

[ ] 异常中断、S 态

[ ] 虚存

[ ] RV32I

[ ] 分支预测

[ ] VGA



## 异常中断

实现 csr 相关指令。使用 trivial 的实现方法：当decode到 7'b1110011 时，流水线暂时退化成多周期（PC stall，IF-ID 插 bubble），跑完这条指令再恢复，以支持“原子操作”

ID->EXE (csr_addr, csr_opcode)

CSR_transition(AllCSRs, csr_addr,  x[rs1], imm, csr_opcode; selected_val)



这些指令做什么？

ecall

ebreak

mret

+ **xRET** sets the pc to the value stored in the **xepc** register  



When a trap occurs (or delegates to mode X):

+ the xcause register is written with the trap cause  
+ the xepc register is written with the virtual address of the instruction that took the trap
+ the xtval register is written with an exception-specific datum 
+ the xPP field of mstatus is written with the active privilege mode at the time of the trap
+ the xPIE field of mstatus is written with the value of the xIE field at the time of the trap
+ and the xIE field of mstatus is cleared  



An interrupt i will be taken if bit i is set in both mip and mie, and **if interrupts are globally enabled**. 

By default, M-mode interrupts are globally enabled if the hart’s current privilege mode is less than M, or if the current privilege mode is M and the MIE bit in the mstatus register is set.  

priviledge_mode < M || (priviledge_mode == M && mstatus.mie)

If bit i in mideleg is set, however, interrupts are considered to be globally enabled if the hart’s current privilege mode equals the delegated privilege mode (S or U) and that mode’s interrupt enable bit (SIE or UIE in mstatus) is set, or if the current privilege mode is less than the delegated privilege mode.  

priviledge_mode_i < S || (priviledge_mode_i == S && mstatus.sie)

if (mideleg[i]) begin

​    priviledge_mode

end



给 decode 阶段加线

## 页表


实现三种 page fault 异常：

Attempting to fetch an instruction from a page that does not have execute permissions raises a fetch page-fault exception. 

Attempting to execute a load or load-reserved instruction whose effective address lies within a page without read permissions raises a load page-fault exception. 

Attempting to execute a store, store-conditional (regardless of success), or AMO instruction whose effective address lies within a page without write permissions raises a store page-fault exception.