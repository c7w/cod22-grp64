00000000 <usr-0x44>:
   0:   80003537                lui     a0,0x80003
   4:   800045b7                lui     a1,0x80004
   8:   34051573                csrrw   a0,mscratch,a0
   c:   340595f3                csrrw   a1,mscratch,a1
  10:   00000417                auipc   s0,0x80000
  14:   04440413                addi    s0,s0,68 # 54 <ecall_handler>
  18:   30541473                csrrw   s0,mtvec,s0
  1c:   00000417                auipc   s0,0x80000
  20:   02840413                addi    s0,s0,40 # 44 <usr>
  24:   34141473                csrrw   s0,mepc,s0
  28:   00010637                lui     a2,0x10
  2c:   fff60613                addi    a2,a2,-1 # ffff <__global_pointer$+0xe77b>
  30:   340626f3                csrrs   a3,mscratch,a2
  34:   34063773                csrrc   a4,mscratch,a2
  38:   c01027f3                rdtime  a5
  3c:   c8102873                rdtimeh a6
  40:   30200073                mret

00000044 <usr>:
  44:   3e800493                li      s1,1000
  48:   3e700913                li      s2,999
  4c:   3e600993                li      s3,998
  50:   00000073                ecall

00000054 <ecall_handler>:
  54:   100002b7                lui     t0,0x10000

00000058 <.TESTW1>:
  58:   00528303                lb      t1,5(t0) # 10000005 <__global_pointer$+0xfffe781>
  5c:   02037313                andi    t1,t1,32
  60:   fe030ce3                beqz    t1,58 <.TESTW1>
  64:   06400513                li      a0,100
  68:   00a28023                sb      a0,0(t0)

0000006c <.TESTW2>:
  6c:   00528303                lb      t1,5(t0)
  70:   02037313                andi    t1,t1,32
  74:   fe030ce3                beqz    t1,6c <.TESTW2>
  78:   06f00513                li      a0,111
  7c:   00a28023                sb      a0,0(t0)

00000080 <end>:
  80:   00000063                beqz    zero,80 <end>