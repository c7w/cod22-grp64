
rbl:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <boot>:
80000000:	00000093          	li	ra,0
80000004:	00000113          	li	sp,0
80000008:	00000193          	li	gp,0
8000000c:	00000213          	li	tp,0
80000010:	00000293          	li	t0,0
80000014:	00000313          	li	t1,0
80000018:	00000393          	li	t2,0
8000001c:	00000413          	li	s0,0
80000020:	00000493          	li	s1,0
80000024:	00000613          	li	a2,0
80000028:	00000693          	li	a3,0
8000002c:	00000713          	li	a4,0
80000030:	00000793          	li	a5,0
80000034:	00000813          	li	a6,0
80000038:	00000893          	li	a7,0
8000003c:	00000913          	li	s2,0
80000040:	00000993          	li	s3,0
80000044:	00000a13          	li	s4,0
80000048:	00000a93          	li	s5,0
8000004c:	00000b13          	li	s6,0
80000050:	00000b93          	li	s7,0
80000054:	00000c13          	li	s8,0
80000058:	00000c93          	li	s9,0
8000005c:	00000d13          	li	s10,0
80000060:	00000d93          	li	s11,0
80000064:	00000e13          	li	t3,0
80000068:	00000e93          	li	t4,0
8000006c:	00000f13          	li	t5,0
80000070:	00000f93          	li	t6,0
80000074:	00f00293          	li	t0,15
80000078:	3a029073          	csrw	pmpcfg0,t0
8000007c:	fff00293          	li	t0,-1
80000080:	3b029073          	csrw	pmpaddr0,t0
80000084:	34001073          	csrw	mscratch,zero

80000088 <.Lpcrel_hi0>:
80000088:	00001297          	auipc	t0,0x1
8000008c:	de828293          	addi	t0,t0,-536 # 80000e70 <trap_vector>
80000090:	30529073          	csrw	mtvec,t0

80000094 <try>:
80000094:	30502373          	csrr	t1,mtvec
80000098:	fe629ee3          	bne	t0,t1,80000094 <try>

8000009c <.Lpcrel_hi1>:
8000009c:	00007117          	auipc	sp,0x7
800000a0:	f6410113          	addi	sp,sp,-156 # 80007000 <ebss>
800000a4:	34011073          	csrw	mscratch,sp
800000a8:	00051463          	bnez	a0,800000b0 <other_hart>
800000ac:	6ed0006f          	j	80000f98 <boot_first_hart>

800000b0 <other_hart>:
800000b0:	10500073          	wfi
800000b4:	ffdff06f          	j	800000b0 <other_hart>

800000b8 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcadb6d49bd44a02dE>:
800000b8:	00052503          	lw	a0,0(a0)
800000bc:	00001317          	auipc	t1,0x1
800000c0:	66830067          	jr	1640(t1) # 80001724 <_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h4ed6c1d285e05647E>

800000c4 <_ZN4core3ptr30drop_in_place$LT$$RF$usize$GT$17hc49211082c03af35E>:
800000c4:	00008067          	ret

800000c8 <_ZN50_$LT$$RF$mut$u20$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h6ea4b4a24160c4f1E>:
800000c8:	f7010113          	addi	sp,sp,-144
800000cc:	08112623          	sw	ra,140(sp)
800000d0:	08812423          	sw	s0,136(sp)
800000d4:	08912223          	sw	s1,132(sp)
800000d8:	09212023          	sw	s2,128(sp)
800000dc:	07312e23          	sw	s3,124(sp)
800000e0:	07412c23          	sw	s4,120(sp)
800000e4:	07512a23          	sw	s5,116(sp)
800000e8:	07612823          	sw	s6,112(sp)
800000ec:	07712623          	sw	s7,108(sp)
800000f0:	07812423          	sw	s8,104(sp)
800000f4:	07912223          	sw	s9,100(sp)
800000f8:	07a12023          	sw	s10,96(sp)
800000fc:	05b12e23          	sw	s11,92(sp)
80000100:	00052403          	lw	s0,0(a0)
80000104:	00058513          	mv	a0,a1
80000108:	00440d13          	addi	s10,s0,4
8000010c:	00840c93          	addi	s9,s0,8
80000110:	00c40c13          	addi	s8,s0,12
80000114:	01040b93          	addi	s7,s0,16
80000118:	01440b13          	addi	s6,s0,20
8000011c:	01840a93          	addi	s5,s0,24
80000120:	01c40a13          	addi	s4,s0,28
80000124:	02040993          	addi	s3,s0,32
80000128:	02440913          	addi	s2,s0,36
8000012c:	02840493          	addi	s1,s0,40
80000130:	02c40d93          	addi	s11,s0,44
80000134:	03040593          	addi	a1,s0,48
80000138:	00b12023          	sw	a1,0(sp)
8000013c:	03440593          	addi	a1,s0,52
80000140:	00b12223          	sw	a1,4(sp)
80000144:	03840593          	addi	a1,s0,56
80000148:	00b12423          	sw	a1,8(sp)
8000014c:	03c40593          	addi	a1,s0,60
80000150:	00b12623          	sw	a1,12(sp)
80000154:	04040593          	addi	a1,s0,64
80000158:	00b12823          	sw	a1,16(sp)
8000015c:	04440593          	addi	a1,s0,68
80000160:	00b12a23          	sw	a1,20(sp)
80000164:	04840593          	addi	a1,s0,72
80000168:	00b12c23          	sw	a1,24(sp)
8000016c:	04c40593          	addi	a1,s0,76
80000170:	00b12e23          	sw	a1,28(sp)
80000174:	05040593          	addi	a1,s0,80
80000178:	02b12023          	sw	a1,32(sp)
8000017c:	05440593          	addi	a1,s0,84
80000180:	02b12223          	sw	a1,36(sp)
80000184:	05840593          	addi	a1,s0,88
80000188:	02b12423          	sw	a1,40(sp)
8000018c:	05c40593          	addi	a1,s0,92
80000190:	02b12623          	sw	a1,44(sp)
80000194:	06040593          	addi	a1,s0,96
80000198:	02b12823          	sw	a1,48(sp)
8000019c:	06440593          	addi	a1,s0,100
800001a0:	02b12a23          	sw	a1,52(sp)
800001a4:	06840593          	addi	a1,s0,104
800001a8:	02b12c23          	sw	a1,56(sp)
800001ac:	06c40593          	addi	a1,s0,108
800001b0:	02b12e23          	sw	a1,60(sp)
800001b4:	07040593          	addi	a1,s0,112
800001b8:	04b12023          	sw	a1,64(sp)
800001bc:	07440593          	addi	a1,s0,116
800001c0:	04b12223          	sw	a1,68(sp)
800001c4:	07840593          	addi	a1,s0,120
800001c8:	04b12423          	sw	a1,72(sp)
800001cc:	07c40593          	addi	a1,s0,124
800001d0:	04b12623          	sw	a1,76(sp)
800001d4:	800045b7          	lui	a1,0x80004
800001d8:	5e058593          	addi	a1,a1,1504 # 800045e0 <ebss+0xffffd5e0>
800001dc:	00900613          	li	a2,9
800001e0:	00003097          	auipc	ra,0x3
800001e4:	d6c080e7          	jalr	-660(ra) # 80002f4c <_ZN4core3fmt9Formatter12debug_struct17ha7b4d14b3b78e6a4E>
800001e8:	04b12a23          	sw	a1,84(sp)
800001ec:	04a12823          	sw	a0,80(sp)
800001f0:	04812c23          	sw	s0,88(sp)
800001f4:	80004537          	lui	a0,0x80004
800001f8:	5e950593          	addi	a1,a0,1513 # 800045e9 <ebss+0xffffd5e9>
800001fc:	80004537          	lui	a0,0x80004
80000200:	5ec50413          	addi	s0,a0,1516 # 800045ec <ebss+0xffffd5ec>
80000204:	05010513          	addi	a0,sp,80
80000208:	00200613          	li	a2,2
8000020c:	05810693          	addi	a3,sp,88
80000210:	00040713          	mv	a4,s0
80000214:	00002097          	auipc	ra,0x2
80000218:	ae0080e7          	jalr	-1312(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
8000021c:	05a12c23          	sw	s10,88(sp)
80000220:	80004537          	lui	a0,0x80004
80000224:	5fc50593          	addi	a1,a0,1532 # 800045fc <ebss+0xffffd5fc>
80000228:	05010513          	addi	a0,sp,80
8000022c:	00200613          	li	a2,2
80000230:	05810693          	addi	a3,sp,88
80000234:	00040713          	mv	a4,s0
80000238:	00002097          	auipc	ra,0x2
8000023c:	abc080e7          	jalr	-1348(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000240:	05912c23          	sw	s9,88(sp)
80000244:	80004537          	lui	a0,0x80004
80000248:	5fe50593          	addi	a1,a0,1534 # 800045fe <ebss+0xffffd5fe>
8000024c:	05010513          	addi	a0,sp,80
80000250:	00200613          	li	a2,2
80000254:	05810693          	addi	a3,sp,88
80000258:	00040713          	mv	a4,s0
8000025c:	00002097          	auipc	ra,0x2
80000260:	a98080e7          	jalr	-1384(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000264:	05812c23          	sw	s8,88(sp)
80000268:	80004537          	lui	a0,0x80004
8000026c:	60050593          	addi	a1,a0,1536 # 80004600 <ebss+0xffffd600>
80000270:	05010513          	addi	a0,sp,80
80000274:	00200613          	li	a2,2
80000278:	05810693          	addi	a3,sp,88
8000027c:	00040713          	mv	a4,s0
80000280:	00002097          	auipc	ra,0x2
80000284:	a74080e7          	jalr	-1420(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000288:	05712c23          	sw	s7,88(sp)
8000028c:	80004537          	lui	a0,0x80004
80000290:	60250593          	addi	a1,a0,1538 # 80004602 <ebss+0xffffd602>
80000294:	05010513          	addi	a0,sp,80
80000298:	00200613          	li	a2,2
8000029c:	05810693          	addi	a3,sp,88
800002a0:	00040713          	mv	a4,s0
800002a4:	00002097          	auipc	ra,0x2
800002a8:	a50080e7          	jalr	-1456(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800002ac:	05612c23          	sw	s6,88(sp)
800002b0:	80004537          	lui	a0,0x80004
800002b4:	60450593          	addi	a1,a0,1540 # 80004604 <ebss+0xffffd604>
800002b8:	05010513          	addi	a0,sp,80
800002bc:	00200613          	li	a2,2
800002c0:	05810693          	addi	a3,sp,88
800002c4:	00040713          	mv	a4,s0
800002c8:	00002097          	auipc	ra,0x2
800002cc:	a2c080e7          	jalr	-1492(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800002d0:	05512c23          	sw	s5,88(sp)
800002d4:	80004537          	lui	a0,0x80004
800002d8:	60650593          	addi	a1,a0,1542 # 80004606 <ebss+0xffffd606>
800002dc:	05010513          	addi	a0,sp,80
800002e0:	00200613          	li	a2,2
800002e4:	05810693          	addi	a3,sp,88
800002e8:	00040713          	mv	a4,s0
800002ec:	00002097          	auipc	ra,0x2
800002f0:	a08080e7          	jalr	-1528(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800002f4:	05412c23          	sw	s4,88(sp)
800002f8:	80004537          	lui	a0,0x80004
800002fc:	60850593          	addi	a1,a0,1544 # 80004608 <ebss+0xffffd608>
80000300:	05010513          	addi	a0,sp,80
80000304:	00200613          	li	a2,2
80000308:	05810693          	addi	a3,sp,88
8000030c:	00040713          	mv	a4,s0
80000310:	00002097          	auipc	ra,0x2
80000314:	9e4080e7          	jalr	-1564(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000318:	05312c23          	sw	s3,88(sp)
8000031c:	80004537          	lui	a0,0x80004
80000320:	60a50593          	addi	a1,a0,1546 # 8000460a <ebss+0xffffd60a>
80000324:	05010513          	addi	a0,sp,80
80000328:	00200613          	li	a2,2
8000032c:	05810693          	addi	a3,sp,88
80000330:	00040713          	mv	a4,s0
80000334:	00002097          	auipc	ra,0x2
80000338:	9c0080e7          	jalr	-1600(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
8000033c:	05212c23          	sw	s2,88(sp)
80000340:	80004537          	lui	a0,0x80004
80000344:	60c50593          	addi	a1,a0,1548 # 8000460c <ebss+0xffffd60c>
80000348:	05010513          	addi	a0,sp,80
8000034c:	00200613          	li	a2,2
80000350:	05810693          	addi	a3,sp,88
80000354:	00040713          	mv	a4,s0
80000358:	00002097          	auipc	ra,0x2
8000035c:	99c080e7          	jalr	-1636(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000360:	04912c23          	sw	s1,88(sp)
80000364:	80004537          	lui	a0,0x80004
80000368:	60e50593          	addi	a1,a0,1550 # 8000460e <ebss+0xffffd60e>
8000036c:	05010513          	addi	a0,sp,80
80000370:	00300613          	li	a2,3
80000374:	05810693          	addi	a3,sp,88
80000378:	00040713          	mv	a4,s0
8000037c:	00002097          	auipc	ra,0x2
80000380:	978080e7          	jalr	-1672(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000384:	05b12c23          	sw	s11,88(sp)
80000388:	80004537          	lui	a0,0x80004
8000038c:	61150593          	addi	a1,a0,1553 # 80004611 <ebss+0xffffd611>
80000390:	05010513          	addi	a0,sp,80
80000394:	00300613          	li	a2,3
80000398:	05810693          	addi	a3,sp,88
8000039c:	00040713          	mv	a4,s0
800003a0:	00002097          	auipc	ra,0x2
800003a4:	954080e7          	jalr	-1708(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800003a8:	00012503          	lw	a0,0(sp)
800003ac:	04a12c23          	sw	a0,88(sp)
800003b0:	80004537          	lui	a0,0x80004
800003b4:	61450593          	addi	a1,a0,1556 # 80004614 <ebss+0xffffd614>
800003b8:	05010513          	addi	a0,sp,80
800003bc:	00300613          	li	a2,3
800003c0:	05810693          	addi	a3,sp,88
800003c4:	00040713          	mv	a4,s0
800003c8:	00002097          	auipc	ra,0x2
800003cc:	92c080e7          	jalr	-1748(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800003d0:	00412503          	lw	a0,4(sp)
800003d4:	04a12c23          	sw	a0,88(sp)
800003d8:	80004537          	lui	a0,0x80004
800003dc:	61750593          	addi	a1,a0,1559 # 80004617 <ebss+0xffffd617>
800003e0:	05010513          	addi	a0,sp,80
800003e4:	00300613          	li	a2,3
800003e8:	05810693          	addi	a3,sp,88
800003ec:	00040713          	mv	a4,s0
800003f0:	00002097          	auipc	ra,0x2
800003f4:	904080e7          	jalr	-1788(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800003f8:	00812503          	lw	a0,8(sp)
800003fc:	04a12c23          	sw	a0,88(sp)
80000400:	80004537          	lui	a0,0x80004
80000404:	61a50593          	addi	a1,a0,1562 # 8000461a <ebss+0xffffd61a>
80000408:	05010513          	addi	a0,sp,80
8000040c:	00300613          	li	a2,3
80000410:	05810693          	addi	a3,sp,88
80000414:	00040713          	mv	a4,s0
80000418:	00002097          	auipc	ra,0x2
8000041c:	8dc080e7          	jalr	-1828(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000420:	00c12503          	lw	a0,12(sp)
80000424:	04a12c23          	sw	a0,88(sp)
80000428:	80004537          	lui	a0,0x80004
8000042c:	61d50593          	addi	a1,a0,1565 # 8000461d <ebss+0xffffd61d>
80000430:	05010513          	addi	a0,sp,80
80000434:	00300613          	li	a2,3
80000438:	05810693          	addi	a3,sp,88
8000043c:	00040713          	mv	a4,s0
80000440:	00002097          	auipc	ra,0x2
80000444:	8b4080e7          	jalr	-1868(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000448:	01012503          	lw	a0,16(sp)
8000044c:	04a12c23          	sw	a0,88(sp)
80000450:	80004537          	lui	a0,0x80004
80000454:	62050593          	addi	a1,a0,1568 # 80004620 <ebss+0xffffd620>
80000458:	05010513          	addi	a0,sp,80
8000045c:	00300613          	li	a2,3
80000460:	05810693          	addi	a3,sp,88
80000464:	00040713          	mv	a4,s0
80000468:	00002097          	auipc	ra,0x2
8000046c:	88c080e7          	jalr	-1908(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000470:	01412503          	lw	a0,20(sp)
80000474:	04a12c23          	sw	a0,88(sp)
80000478:	80004537          	lui	a0,0x80004
8000047c:	62350593          	addi	a1,a0,1571 # 80004623 <ebss+0xffffd623>
80000480:	05010513          	addi	a0,sp,80
80000484:	00300613          	li	a2,3
80000488:	05810693          	addi	a3,sp,88
8000048c:	00040713          	mv	a4,s0
80000490:	00002097          	auipc	ra,0x2
80000494:	864080e7          	jalr	-1948(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000498:	01812503          	lw	a0,24(sp)
8000049c:	04a12c23          	sw	a0,88(sp)
800004a0:	80004537          	lui	a0,0x80004
800004a4:	62650593          	addi	a1,a0,1574 # 80004626 <ebss+0xffffd626>
800004a8:	05010513          	addi	a0,sp,80
800004ac:	00300613          	li	a2,3
800004b0:	05810693          	addi	a3,sp,88
800004b4:	00040713          	mv	a4,s0
800004b8:	00002097          	auipc	ra,0x2
800004bc:	83c080e7          	jalr	-1988(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800004c0:	01c12503          	lw	a0,28(sp)
800004c4:	04a12c23          	sw	a0,88(sp)
800004c8:	80004537          	lui	a0,0x80004
800004cc:	62950593          	addi	a1,a0,1577 # 80004629 <ebss+0xffffd629>
800004d0:	05010513          	addi	a0,sp,80
800004d4:	00300613          	li	a2,3
800004d8:	05810693          	addi	a3,sp,88
800004dc:	00040713          	mv	a4,s0
800004e0:	00002097          	auipc	ra,0x2
800004e4:	814080e7          	jalr	-2028(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800004e8:	02012503          	lw	a0,32(sp)
800004ec:	04a12c23          	sw	a0,88(sp)
800004f0:	80004537          	lui	a0,0x80004
800004f4:	62c50593          	addi	a1,a0,1580 # 8000462c <ebss+0xffffd62c>
800004f8:	05010513          	addi	a0,sp,80
800004fc:	00300613          	li	a2,3
80000500:	05810693          	addi	a3,sp,88
80000504:	00040713          	mv	a4,s0
80000508:	00001097          	auipc	ra,0x1
8000050c:	7ec080e7          	jalr	2028(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000510:	02412503          	lw	a0,36(sp)
80000514:	04a12c23          	sw	a0,88(sp)
80000518:	80004537          	lui	a0,0x80004
8000051c:	62f50593          	addi	a1,a0,1583 # 8000462f <ebss+0xffffd62f>
80000520:	05010513          	addi	a0,sp,80
80000524:	00300613          	li	a2,3
80000528:	05810693          	addi	a3,sp,88
8000052c:	00040713          	mv	a4,s0
80000530:	00001097          	auipc	ra,0x1
80000534:	7c4080e7          	jalr	1988(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000538:	02812503          	lw	a0,40(sp)
8000053c:	04a12c23          	sw	a0,88(sp)
80000540:	80004537          	lui	a0,0x80004
80000544:	63250593          	addi	a1,a0,1586 # 80004632 <ebss+0xffffd632>
80000548:	05010513          	addi	a0,sp,80
8000054c:	00300613          	li	a2,3
80000550:	05810693          	addi	a3,sp,88
80000554:	00040713          	mv	a4,s0
80000558:	00001097          	auipc	ra,0x1
8000055c:	79c080e7          	jalr	1948(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000560:	02c12503          	lw	a0,44(sp)
80000564:	04a12c23          	sw	a0,88(sp)
80000568:	80004537          	lui	a0,0x80004
8000056c:	63550593          	addi	a1,a0,1589 # 80004635 <ebss+0xffffd635>
80000570:	05010513          	addi	a0,sp,80
80000574:	00300613          	li	a2,3
80000578:	05810693          	addi	a3,sp,88
8000057c:	00040713          	mv	a4,s0
80000580:	00001097          	auipc	ra,0x1
80000584:	774080e7          	jalr	1908(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000588:	03012503          	lw	a0,48(sp)
8000058c:	04a12c23          	sw	a0,88(sp)
80000590:	80004537          	lui	a0,0x80004
80000594:	63850593          	addi	a1,a0,1592 # 80004638 <ebss+0xffffd638>
80000598:	05010513          	addi	a0,sp,80
8000059c:	00300613          	li	a2,3
800005a0:	05810693          	addi	a3,sp,88
800005a4:	00040713          	mv	a4,s0
800005a8:	00001097          	auipc	ra,0x1
800005ac:	74c080e7          	jalr	1868(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800005b0:	03412503          	lw	a0,52(sp)
800005b4:	04a12c23          	sw	a0,88(sp)
800005b8:	80004537          	lui	a0,0x80004
800005bc:	63b50593          	addi	a1,a0,1595 # 8000463b <ebss+0xffffd63b>
800005c0:	05010513          	addi	a0,sp,80
800005c4:	00300613          	li	a2,3
800005c8:	05810693          	addi	a3,sp,88
800005cc:	00040713          	mv	a4,s0
800005d0:	00001097          	auipc	ra,0x1
800005d4:	724080e7          	jalr	1828(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800005d8:	03812503          	lw	a0,56(sp)
800005dc:	04a12c23          	sw	a0,88(sp)
800005e0:	80004537          	lui	a0,0x80004
800005e4:	63e50593          	addi	a1,a0,1598 # 8000463e <ebss+0xffffd63e>
800005e8:	05010513          	addi	a0,sp,80
800005ec:	00300613          	li	a2,3
800005f0:	05810693          	addi	a3,sp,88
800005f4:	00040713          	mv	a4,s0
800005f8:	00001097          	auipc	ra,0x1
800005fc:	6fc080e7          	jalr	1788(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000600:	03c12503          	lw	a0,60(sp)
80000604:	04a12c23          	sw	a0,88(sp)
80000608:	80004537          	lui	a0,0x80004
8000060c:	64150593          	addi	a1,a0,1601 # 80004641 <ebss+0xffffd641>
80000610:	05010513          	addi	a0,sp,80
80000614:	00300613          	li	a2,3
80000618:	05810693          	addi	a3,sp,88
8000061c:	00040713          	mv	a4,s0
80000620:	00001097          	auipc	ra,0x1
80000624:	6d4080e7          	jalr	1748(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000628:	04012503          	lw	a0,64(sp)
8000062c:	04a12c23          	sw	a0,88(sp)
80000630:	80004537          	lui	a0,0x80004
80000634:	64450593          	addi	a1,a0,1604 # 80004644 <ebss+0xffffd644>
80000638:	05010513          	addi	a0,sp,80
8000063c:	00300613          	li	a2,3
80000640:	05810693          	addi	a3,sp,88
80000644:	00040713          	mv	a4,s0
80000648:	00001097          	auipc	ra,0x1
8000064c:	6ac080e7          	jalr	1708(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000650:	04412503          	lw	a0,68(sp)
80000654:	04a12c23          	sw	a0,88(sp)
80000658:	80004537          	lui	a0,0x80004
8000065c:	64750593          	addi	a1,a0,1607 # 80004647 <ebss+0xffffd647>
80000660:	05010513          	addi	a0,sp,80
80000664:	00300613          	li	a2,3
80000668:	05810693          	addi	a3,sp,88
8000066c:	00040713          	mv	a4,s0
80000670:	00001097          	auipc	ra,0x1
80000674:	684080e7          	jalr	1668(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
80000678:	04812503          	lw	a0,72(sp)
8000067c:	04a12c23          	sw	a0,88(sp)
80000680:	80004537          	lui	a0,0x80004
80000684:	64a50593          	addi	a1,a0,1610 # 8000464a <ebss+0xffffd64a>
80000688:	05010513          	addi	a0,sp,80
8000068c:	00300613          	li	a2,3
80000690:	05810693          	addi	a3,sp,88
80000694:	00040713          	mv	a4,s0
80000698:	00001097          	auipc	ra,0x1
8000069c:	65c080e7          	jalr	1628(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800006a0:	04c12503          	lw	a0,76(sp)
800006a4:	04a12c23          	sw	a0,88(sp)
800006a8:	80004537          	lui	a0,0x80004
800006ac:	64d50593          	addi	a1,a0,1613 # 8000464d <ebss+0xffffd64d>
800006b0:	05010513          	addi	a0,sp,80
800006b4:	00300613          	li	a2,3
800006b8:	05810693          	addi	a3,sp,88
800006bc:	00040713          	mv	a4,s0
800006c0:	00001097          	auipc	ra,0x1
800006c4:	634080e7          	jalr	1588(ra) # 80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>
800006c8:	05010513          	addi	a0,sp,80
800006cc:	00002097          	auipc	ra,0x2
800006d0:	850080e7          	jalr	-1968(ra) # 80001f1c <_ZN4core3fmt8builders11DebugStruct6finish17h9d7c90b72a6fed8cE>
800006d4:	05c12d83          	lw	s11,92(sp)
800006d8:	06012d03          	lw	s10,96(sp)
800006dc:	06412c83          	lw	s9,100(sp)
800006e0:	06812c03          	lw	s8,104(sp)
800006e4:	06c12b83          	lw	s7,108(sp)
800006e8:	07012b03          	lw	s6,112(sp)
800006ec:	07412a83          	lw	s5,116(sp)
800006f0:	07812a03          	lw	s4,120(sp)
800006f4:	07c12983          	lw	s3,124(sp)
800006f8:	08012903          	lw	s2,128(sp)
800006fc:	08412483          	lw	s1,132(sp)
80000700:	08812403          	lw	s0,136(sp)
80000704:	08c12083          	lw	ra,140(sp)
80000708:	09010113          	addi	sp,sp,144
8000070c:	00008067          	ret

80000710 <trap_handler>:
80000710:	f7010113          	addi	sp,sp,-144
80000714:	08112623          	sw	ra,140(sp)
80000718:	08812423          	sw	s0,136(sp)
8000071c:	08912223          	sw	s1,132(sp)
80000720:	09212023          	sw	s2,128(sp)
80000724:	07312e23          	sw	s3,124(sp)
80000728:	00050913          	mv	s2,a0
8000072c:	00a12423          	sw	a0,8(sp)
80000730:	00001097          	auipc	ra,0x1
80000734:	f18080e7          	jalr	-232(ra) # 80001648 <__read_mcause>
80000738:	00050493          	mv	s1,a0
8000073c:	02a12c23          	sw	a0,56(sp)
80000740:	01f55413          	srli	s0,a0,0x1f
80000744:	03810513          	addi	a0,sp,56
80000748:	00001097          	auipc	ra,0x1
8000074c:	c04080e7          	jalr	-1020(ra) # 8000134c <_ZN5riscv8register6mcause6Mcause4code17hb0194acaa4b9e1ccE>
80000750:	0004c863          	bltz	s1,80000760 <trap_handler+0x50>
80000754:	00001097          	auipc	ra,0x1
80000758:	b60080e7          	jalr	-1184(ra) # 800012b4 <_ZN5riscv8register6mcause9Exception4from17h925cbab6cc6afdcdE>
8000075c:	00c0006f          	j	80000768 <trap_handler+0x58>
80000760:	00001097          	auipc	ra,0x1
80000764:	ae4080e7          	jalr	-1308(ra) # 80001244 <_ZN5riscv8register6mcause9Interrupt4from17h9e168bf52c128881E>
80000768:	0ff57493          	andi	s1,a0,255
8000076c:	00144513          	xori	a0,s0,1
80000770:	00a10823          	sb	a0,16(sp)
80000774:	009108a3          	sb	s1,17(sp)
80000778:	00001097          	auipc	ra,0x1
8000077c:	ed8080e7          	jalr	-296(ra) # 80001650 <__read_mtval>
80000780:	00a12a23          	sw	a0,20(sp)
80000784:	00001097          	auipc	ra,0x1
80000788:	ebc080e7          	jalr	-324(ra) # 80001640 <__read_mepc>
8000078c:	00050993          	mv	s3,a0
80000790:	00a12623          	sw	a0,12(sp)
80000794:	04041663          	bnez	s0,800007e0 <trap_handler+0xd0>
80000798:	00900513          	li	a0,9
8000079c:	06a48463          	beq	s1,a0,80000804 <trap_handler+0xf4>
800007a0:	00200513          	li	a0,2
800007a4:	2ca49a63          	bne	s1,a0,80000a78 <.LBB2_24+0xcc>
800007a8:	0009a503          	lw	a0,0(s3)
800007ac:	fffff5b7          	lui	a1,0xfffff
800007b0:	07f58593          	addi	a1,a1,127 # fffff07f <ebss+0x7fff807f>
800007b4:	00b575b3          	and	a1,a0,a1
800007b8:	c0102637          	lui	a2,0xc0102
800007bc:	07360613          	addi	a2,a2,115 # c0102073 <ebss+0x400fb073>
800007c0:	0ac58663          	beq	a1,a2,8000086c <.LBB2_13+0x3c>
800007c4:	c8102637          	lui	a2,0xc8102
800007c8:	07360613          	addi	a2,a2,115 # c8102073 <ebss+0x480fb073>
800007cc:	3ac59063          	bne	a1,a2,80000b6c <.LBB2_24+0x1c0>
800007d0:	0200c5b7          	lui	a1,0x200c
800007d4:	ff85a603          	lw	a2,-8(a1) # 200bff8 <.Lline_table_start0+0x1fe1665>
800007d8:	ffc5a583          	lw	a1,-4(a1)
800007dc:	09c0006f          	j	80000878 <.LBB2_13+0x48>
800007e0:	00500513          	li	a0,5
800007e4:	28a49a63          	bne	s1,a0,80000a78 <.LBB2_24+0xcc>
800007e8:	08000513          	li	a0,128
800007ec:	00001097          	auipc	ra,0x1
800007f0:	e4c080e7          	jalr	-436(ra) # 80001638 <__clear_mie>
800007f4:	02000513          	li	a0,32
800007f8:	00001097          	auipc	ra,0x1
800007fc:	e60080e7          	jalr	-416(ra) # 80001658 <__set_mip>
80000800:	2580006f          	j	80000a58 <.LBB2_24+0xac>
80000804:	04492503          	lw	a0,68(s2)
80000808:	00600593          	li	a1,6
8000080c:	08a5e463          	bltu	a1,a0,80000894 <.LBB2_13+0x64>
80000810:	02892403          	lw	s0,40(s2)
80000814:	00251513          	slli	a0,a0,0x2
80000818:	800045b7          	lui	a1,0x80004
8000081c:	38858593          	addi	a1,a1,904 # 80004388 <ebss+0xffffd388>
80000820:	00b50533          	add	a0,a0,a1
80000824:	00052503          	lw	a0,0(a0)
80000828:	02c92483          	lw	s1,44(s2)
8000082c:	00050067          	jr	a0

80000830 <.LBB2_13>:
80000830:	00001097          	auipc	ra,0x1
80000834:	df8080e7          	jalr	-520(ra) # 80001628 <__read_mhartid>
80000838:	00351513          	slli	a0,a0,0x3
8000083c:	020045b7          	lui	a1,0x2004
80000840:	00b50533          	add	a0,a0,a1
80000844:	00852023          	sw	s0,0(a0)
80000848:	00456513          	ori	a0,a0,4
8000084c:	00952023          	sw	s1,0(a0)
80000850:	08000513          	li	a0,128
80000854:	00001097          	auipc	ra,0x1
80000858:	ddc080e7          	jalr	-548(ra) # 80001630 <__set_mie>
8000085c:	02000513          	li	a0,32
80000860:	00001097          	auipc	ra,0x1
80000864:	e00080e7          	jalr	-512(ra) # 80001660 <__clear_mip>
80000868:	1e00006f          	j	80000a48 <.LBB2_24+0x9c>
8000086c:	0200c5b7          	lui	a1,0x200c
80000870:	ffc5a603          	lw	a2,-4(a1) # 200bffc <.Lline_table_start0+0x1fe1669>
80000874:	ff85a583          	lw	a1,-8(a1)
80000878:	00555513          	srli	a0,a0,0x5
8000087c:	07c57513          	andi	a0,a0,124
80000880:	00a90533          	add	a0,s2,a0
80000884:	00b52023          	sw	a1,0(a0)
80000888:	00498993          	addi	s3,s3,4
8000088c:	01312623          	sw	s3,12(sp)
80000890:	1c80006f          	j	80000a58 <.LBB2_24+0xac>
80000894:	fda00513          	li	a0,-38
80000898:	1b40006f          	j	80000a4c <.LBB2_24+0xa0>

8000089c <.LBB2_17>:
8000089c:	100005b7          	lui	a1,0x10000
800008a0:	0055c503          	lbu	a0,5(a1) # 10000005 <.Lline_table_start0+0xffd5672>
800008a4:	00157613          	andi	a2,a0,1
800008a8:	fff00513          	li	a0,-1
800008ac:	1a060063          	beqz	a2,80000a4c <.LBB2_24+0xa0>
800008b0:	0005c503          	lbu	a0,0(a1)
800008b4:	1980006f          	j	80000a4c <.LBB2_24+0xa0>

800008b8 <.LBB2_19>:
800008b8:	10000537          	lui	a0,0x10000
800008bc:	06a12023          	sw	a0,96(sp)
800008c0:	80004537          	lui	a0,0x80004
800008c4:	4d050513          	addi	a0,a0,1232 # 800044d0 <ebss+0xffffd4d0>
800008c8:	02a12c23          	sw	a0,56(sp)
800008cc:	00100513          	li	a0,1
800008d0:	02a12e23          	sw	a0,60(sp)
800008d4:	04012023          	sw	zero,64(sp)
800008d8:	80004537          	lui	a0,0x80004
800008dc:	4b850513          	addi	a0,a0,1208 # 800044b8 <ebss+0xffffd4b8>
800008e0:	04a12423          	sw	a0,72(sp)
800008e4:	04012623          	sw	zero,76(sp)
800008e8:	80004537          	lui	a0,0x80004
800008ec:	65050593          	addi	a1,a0,1616 # 80004650 <ebss+0xffffd650>
800008f0:	06010513          	addi	a0,sp,96
800008f4:	1440006f          	j	80000a38 <.LBB2_24+0x8c>

800008f8 <.LBB2_20>:
800008f8:	02812823          	sw	s0,48(sp)
800008fc:	03010513          	addi	a0,sp,48
80000900:	06a12023          	sw	a0,96(sp)
80000904:	80004537          	lui	a0,0x80004
80000908:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
8000090c:	06a12223          	sw	a0,100(sp)
80000910:	10000537          	lui	a0,0x10000
80000914:	00a12c23          	sw	a0,24(sp)
80000918:	80004537          	lui	a0,0x80004
8000091c:	4f050513          	addi	a0,a0,1264 # 800044f0 <ebss+0xffffd4f0>
80000920:	06c0006f          	j	8000098c <.LBB2_22+0x28>

80000924 <.LBB2_21>:
80000924:	0ff47513          	andi	a0,s0,255
80000928:	02a12823          	sw	a0,48(sp)
8000092c:	03010513          	addi	a0,sp,48
80000930:	06a12023          	sw	a0,96(sp)
80000934:	80003537          	lui	a0,0x80003
80000938:	3f050513          	addi	a0,a0,1008 # 800033f0 <ebss+0xffffc3f0>
8000093c:	06a12223          	sw	a0,100(sp)
80000940:	10000537          	lui	a0,0x10000
80000944:	00a12c23          	sw	a0,24(sp)
80000948:	80004537          	lui	a0,0x80004
8000094c:	4b850513          	addi	a0,a0,1208 # 800044b8 <ebss+0xffffd4b8>
80000950:	02a12c23          	sw	a0,56(sp)
80000954:	00100513          	li	a0,1
80000958:	02a12e23          	sw	a0,60(sp)
8000095c:	04012023          	sw	zero,64(sp)
80000960:	0c00006f          	j	80000a20 <.LBB2_24+0x74>

80000964 <.LBB2_22>:
80000964:	02812823          	sw	s0,48(sp)
80000968:	03010513          	addi	a0,sp,48
8000096c:	06a12023          	sw	a0,96(sp)
80000970:	80004537          	lui	a0,0x80004
80000974:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
80000978:	06a12223          	sw	a0,100(sp)
8000097c:	10000537          	lui	a0,0x10000
80000980:	00a12c23          	sw	a0,24(sp)
80000984:	80004537          	lui	a0,0x80004
80000988:	52050513          	addi	a0,a0,1312 # 80004520 <ebss+0xffffd520>
8000098c:	02a12c23          	sw	a0,56(sp)
80000990:	00200513          	li	a0,2
80000994:	02a12e23          	sw	a0,60(sp)
80000998:	04012023          	sw	zero,64(sp)
8000099c:	06010513          	addi	a0,sp,96
800009a0:	04a12423          	sw	a0,72(sp)
800009a4:	00100513          	li	a0,1
800009a8:	0800006f          	j	80000a28 <.LBB2_24+0x7c>

800009ac <.LBB2_24>:
800009ac:	03092503          	lw	a0,48(s2)
800009b0:	04812c23          	sw	s0,88(sp)
800009b4:	04912e23          	sw	s1,92(sp)
800009b8:	02a12823          	sw	a0,48(sp)
800009bc:	05810513          	addi	a0,sp,88
800009c0:	06a12023          	sw	a0,96(sp)
800009c4:	80004537          	lui	a0,0x80004
800009c8:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
800009cc:	06a12223          	sw	a0,100(sp)
800009d0:	05c10513          	addi	a0,sp,92
800009d4:	06a12423          	sw	a0,104(sp)
800009d8:	80004537          	lui	a0,0x80004
800009dc:	bc850513          	addi	a0,a0,-1080 # 80003bc8 <ebss+0xffffcbc8>
800009e0:	06a12623          	sw	a0,108(sp)
800009e4:	03010593          	addi	a1,sp,48
800009e8:	06b12823          	sw	a1,112(sp)
800009ec:	06a12a23          	sw	a0,116(sp)
800009f0:	10000537          	lui	a0,0x10000
800009f4:	00a12c23          	sw	a0,24(sp)
800009f8:	80004537          	lui	a0,0x80004
800009fc:	56050513          	addi	a0,a0,1376 # 80004560 <ebss+0xffffd560>
80000a00:	02a12c23          	sw	a0,56(sp)
80000a04:	00400513          	li	a0,4
80000a08:	02a12e23          	sw	a0,60(sp)
80000a0c:	80004537          	lui	a0,0x80004
80000a10:	58050513          	addi	a0,a0,1408 # 80004580 <ebss+0xffffd580>
80000a14:	04a12023          	sw	a0,64(sp)
80000a18:	00300513          	li	a0,3
80000a1c:	04a12223          	sw	a0,68(sp)
80000a20:	06010593          	addi	a1,sp,96
80000a24:	04b12423          	sw	a1,72(sp)
80000a28:	04a12623          	sw	a0,76(sp)
80000a2c:	80004537          	lui	a0,0x80004
80000a30:	65050593          	addi	a1,a0,1616 # 80004650 <ebss+0xffffd650>
80000a34:	01810513          	addi	a0,sp,24
80000a38:	03810613          	addi	a2,sp,56
80000a3c:	00002097          	auipc	ra,0x2
80000a40:	a98080e7          	jalr	-1384(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
80000a44:	0e051e63          	bnez	a0,80000b40 <.LBB2_24+0x194>
80000a48:	00000513          	li	a0,0
80000a4c:	00498993          	addi	s3,s3,4
80000a50:	01312623          	sw	s3,12(sp)
80000a54:	02a92423          	sw	a0,40(s2)
80000a58:	00098513          	mv	a0,s3
80000a5c:	07c12983          	lw	s3,124(sp)
80000a60:	08012903          	lw	s2,128(sp)
80000a64:	08412483          	lw	s1,132(sp)
80000a68:	08812403          	lw	s0,136(sp)
80000a6c:	08c12083          	lw	ra,140(sp)
80000a70:	09010113          	addi	sp,sp,144
80000a74:	00008067          	ret
80000a78:	01010513          	addi	a0,sp,16
80000a7c:	02a12c23          	sw	a0,56(sp)
80000a80:	80001537          	lui	a0,0x80001
80000a84:	36050513          	addi	a0,a0,864 # 80001360 <ebss+0xffffa360>
80000a88:	02a12e23          	sw	a0,60(sp)
80000a8c:	00c10513          	addi	a0,sp,12
80000a90:	04a12023          	sw	a0,64(sp)
80000a94:	80004537          	lui	a0,0x80004
80000a98:	b1850513          	addi	a0,a0,-1256 # 80003b18 <ebss+0xffffcb18>
80000a9c:	04a12223          	sw	a0,68(sp)
80000aa0:	01410593          	addi	a1,sp,20
80000aa4:	04b12423          	sw	a1,72(sp)
80000aa8:	04a12623          	sw	a0,76(sp)
80000aac:	00810513          	addi	a0,sp,8
80000ab0:	04a12823          	sw	a0,80(sp)
80000ab4:	80000537          	lui	a0,0x80000
80000ab8:	0c850513          	addi	a0,a0,200 # 800000c8 <ebss+0xffff90c8>
80000abc:	04a12a23          	sw	a0,84(sp)
80000ac0:	80004537          	lui	a0,0x80004
80000ac4:	3f850513          	addi	a0,a0,1016 # 800043f8 <ebss+0xffffd3f8>
80000ac8:	06a12023          	sw	a0,96(sp)
80000acc:	00400513          	li	a0,4
80000ad0:	06a12223          	sw	a0,100(sp)
80000ad4:	800045b7          	lui	a1,0x80004
80000ad8:	41858593          	addi	a1,a1,1048 # 80004418 <ebss+0xffffd418>
80000adc:	06b12423          	sw	a1,104(sp)
80000ae0:	06a12623          	sw	a0,108(sp)
80000ae4:	03810593          	addi	a1,sp,56
80000ae8:	06b12823          	sw	a1,112(sp)
80000aec:	06a12a23          	sw	a0,116(sp)
80000af0:	06010513          	addi	a0,sp,96
80000af4:	02a12823          	sw	a0,48(sp)
80000af8:	80002537          	lui	a0,0x80002
80000afc:	47850513          	addi	a0,a0,1144 # 80002478 <ebss+0xffffb478>
80000b00:	02a12a23          	sw	a0,52(sp)
80000b04:	80004537          	lui	a0,0x80004
80000b08:	3c050513          	addi	a0,a0,960 # 800043c0 <ebss+0xffffd3c0>
80000b0c:	00a12c23          	sw	a0,24(sp)
80000b10:	00100513          	li	a0,1
80000b14:	00a12e23          	sw	a0,28(sp)
80000b18:	02012023          	sw	zero,32(sp)
80000b1c:	03010593          	addi	a1,sp,48
80000b20:	02b12423          	sw	a1,40(sp)
80000b24:	02a12623          	sw	a0,44(sp)
80000b28:	80004537          	lui	a0,0x80004
80000b2c:	4a850593          	addi	a1,a0,1192 # 800044a8 <ebss+0xffffd4a8>
80000b30:	01810513          	addi	a0,sp,24
80000b34:	00001097          	auipc	ra,0x1
80000b38:	e20080e7          	jalr	-480(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
80000b3c:	c0001073          	unimp
80000b40:	80004537          	lui	a0,0x80004
80000b44:	66850513          	addi	a0,a0,1640 # 80004668 <ebss+0xffffd668>
80000b48:	800045b7          	lui	a1,0x80004
80000b4c:	69458693          	addi	a3,a1,1684 # 80004694 <ebss+0xffffd694>
80000b50:	800045b7          	lui	a1,0x80004
80000b54:	6b458713          	addi	a4,a1,1716 # 800046b4 <ebss+0xffffd6b4>
80000b58:	02b00593          	li	a1,43
80000b5c:	03810613          	addi	a2,sp,56
80000b60:	00001097          	auipc	ra,0x1
80000b64:	e2c080e7          	jalr	-468(ra) # 8000198c <_ZN4core6result13unwrap_failed17h3d45bfc3fc39404dE>
80000b68:	c0001073          	unimp
80000b6c:	01010513          	addi	a0,sp,16
80000b70:	02a12c23          	sw	a0,56(sp)
80000b74:	80001537          	lui	a0,0x80001
80000b78:	36050513          	addi	a0,a0,864 # 80001360 <ebss+0xffffa360>
80000b7c:	02a12e23          	sw	a0,60(sp)
80000b80:	00c10513          	addi	a0,sp,12
80000b84:	04a12023          	sw	a0,64(sp)
80000b88:	80004537          	lui	a0,0x80004
80000b8c:	b1850513          	addi	a0,a0,-1256 # 80003b18 <ebss+0xffffcb18>
80000b90:	04a12223          	sw	a0,68(sp)
80000b94:	01410593          	addi	a1,sp,20
80000b98:	04b12423          	sw	a1,72(sp)
80000b9c:	04a12623          	sw	a0,76(sp)
80000ba0:	00810513          	addi	a0,sp,8
80000ba4:	04a12823          	sw	a0,80(sp)
80000ba8:	80000537          	lui	a0,0x80000
80000bac:	0c850513          	addi	a0,a0,200 # 800000c8 <ebss+0xffff90c8>
80000bb0:	04a12a23          	sw	a0,84(sp)
80000bb4:	80004537          	lui	a0,0x80004
80000bb8:	3f850513          	addi	a0,a0,1016 # 800043f8 <ebss+0xffffd3f8>
80000bbc:	06a12023          	sw	a0,96(sp)
80000bc0:	00400513          	li	a0,4
80000bc4:	06a12223          	sw	a0,100(sp)
80000bc8:	800045b7          	lui	a1,0x80004
80000bcc:	41858593          	addi	a1,a1,1048 # 80004418 <ebss+0xffffd418>
80000bd0:	06b12423          	sw	a1,104(sp)
80000bd4:	06a12623          	sw	a0,108(sp)
80000bd8:	03810593          	addi	a1,sp,56
80000bdc:	06b12823          	sw	a1,112(sp)
80000be0:	06a12a23          	sw	a0,116(sp)
80000be4:	06010513          	addi	a0,sp,96
80000be8:	02a12823          	sw	a0,48(sp)
80000bec:	80002537          	lui	a0,0x80002
80000bf0:	47850513          	addi	a0,a0,1144 # 80002478 <ebss+0xffffb478>
80000bf4:	02a12a23          	sw	a0,52(sp)
80000bf8:	80004537          	lui	a0,0x80004
80000bfc:	3c050513          	addi	a0,a0,960 # 800043c0 <ebss+0xffffd3c0>
80000c00:	00a12c23          	sw	a0,24(sp)
80000c04:	00100513          	li	a0,1
80000c08:	00a12e23          	sw	a0,28(sp)
80000c0c:	02012023          	sw	zero,32(sp)
80000c10:	03010593          	addi	a1,sp,48
80000c14:	02b12423          	sw	a1,40(sp)
80000c18:	02a12623          	sw	a0,44(sp)
80000c1c:	80004537          	lui	a0,0x80004
80000c20:	49850593          	addi	a1,a0,1176 # 80004498 <ebss+0xffffd498>
80000c24:	01810513          	addi	a0,sp,24
80000c28:	00001097          	auipc	ra,0x1
80000c2c:	d2c080e7          	jalr	-724(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
80000c30:	c0001073          	unimp

80000c34 <_ZN4core3ptr37drop_in_place$LT$core..fmt..Error$GT$17h21156c9a5826e980E.llvm.7793597378114770890>:
80000c34:	00008067          	ret

80000c38 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890>:
80000c38:	ff010113          	addi	sp,sp,-16
80000c3c:	00052503          	lw	a0,0(a0)
80000c40:	08000613          	li	a2,128
80000c44:	00012623          	sw	zero,12(sp)
80000c48:	00c5f863          	bgeu	a1,a2,80000c58 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0x20>
80000c4c:	00100693          	li	a3,1
80000c50:	0a069e63          	bnez	a3,80000d0c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xd4>
80000c54:	0e00006f          	j	80000d34 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xfc>
80000c58:	00b5d613          	srli	a2,a1,0xb
80000c5c:	02061663          	bnez	a2,80000c88 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0x50>
80000c60:	0065d613          	srli	a2,a1,0x6
80000c64:	03f5f593          	andi	a1,a1,63
80000c68:	fc066613          	ori	a2,a2,-64
80000c6c:	00c10623          	sb	a2,12(sp)
80000c70:	0805e593          	ori	a1,a1,128
80000c74:	00b106a3          	sb	a1,13(sp)
80000c78:	00200693          	li	a3,2
80000c7c:	00060593          	mv	a1,a2
80000c80:	08069663          	bnez	a3,80000d0c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xd4>
80000c84:	0b00006f          	j	80000d34 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xfc>
80000c88:	0105d613          	srli	a2,a1,0x10
80000c8c:	02061e63          	bnez	a2,80000cc8 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0x90>
80000c90:	00c5d613          	srli	a2,a1,0xc
80000c94:	0065d693          	srli	a3,a1,0x6
80000c98:	03f5f593          	andi	a1,a1,63
80000c9c:	fe066613          	ori	a2,a2,-32
80000ca0:	00c10623          	sb	a2,12(sp)
80000ca4:	03f6f693          	andi	a3,a3,63
80000ca8:	0806e693          	ori	a3,a3,128
80000cac:	00d106a3          	sb	a3,13(sp)
80000cb0:	0805e593          	ori	a1,a1,128
80000cb4:	00b10723          	sb	a1,14(sp)
80000cb8:	00300693          	li	a3,3
80000cbc:	00060593          	mv	a1,a2
80000cc0:	04069663          	bnez	a3,80000d0c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xd4>
80000cc4:	0700006f          	j	80000d34 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xfc>
80000cc8:	0125d613          	srli	a2,a1,0x12
80000ccc:	00c5d693          	srli	a3,a1,0xc
80000cd0:	0065d713          	srli	a4,a1,0x6
80000cd4:	03f5f593          	andi	a1,a1,63
80000cd8:	ff066613          	ori	a2,a2,-16
80000cdc:	00c10623          	sb	a2,12(sp)
80000ce0:	03f6f693          	andi	a3,a3,63
80000ce4:	0806e693          	ori	a3,a3,128
80000ce8:	00d106a3          	sb	a3,13(sp)
80000cec:	03f77693          	andi	a3,a4,63
80000cf0:	0806e693          	ori	a3,a3,128
80000cf4:	00d10723          	sb	a3,14(sp)
80000cf8:	0805e593          	ori	a1,a1,128
80000cfc:	00b107a3          	sb	a1,15(sp)
80000d00:	00400693          	li	a3,4
80000d04:	00060593          	mv	a1,a2
80000d08:	02068663          	beqz	a3,80000d34 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xfc>
80000d0c:	00c10613          	addi	a2,sp,12
80000d10:	00d606b3          	add	a3,a2,a3
80000d14:	00554703          	lbu	a4,5(a0)
80000d18:	02077713          	andi	a4,a4,32
80000d1c:	fe070ce3          	beqz	a4,80000d14 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xdc>
80000d20:	00160613          	addi	a2,a2,1
80000d24:	00b50023          	sb	a1,0(a0)
80000d28:	00d60663          	beq	a2,a3,80000d34 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xfc>
80000d2c:	00064583          	lbu	a1,0(a2)
80000d30:	fe5ff06f          	j	80000d14 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17hdca6aa5936a40645E.llvm.7793597378114770890+0xdc>
80000d34:	00000513          	li	a0,0
80000d38:	01010113          	addi	sp,sp,16
80000d3c:	00008067          	ret

80000d40 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17hbc271b877598f3b9E.llvm.7793597378114770890>:
80000d40:	fd010113          	addi	sp,sp,-48
80000d44:	02112623          	sw	ra,44(sp)
80000d48:	00052503          	lw	a0,0(a0)
80000d4c:	0145a603          	lw	a2,20(a1)
80000d50:	0105a683          	lw	a3,16(a1)
80000d54:	00a12623          	sw	a0,12(sp)
80000d58:	02c12223          	sw	a2,36(sp)
80000d5c:	02d12023          	sw	a3,32(sp)
80000d60:	00c5a503          	lw	a0,12(a1)
80000d64:	0085a603          	lw	a2,8(a1)
80000d68:	0045a683          	lw	a3,4(a1)
80000d6c:	0005a583          	lw	a1,0(a1)
80000d70:	00a12e23          	sw	a0,28(sp)
80000d74:	00c12c23          	sw	a2,24(sp)
80000d78:	00d12a23          	sw	a3,20(sp)
80000d7c:	00b12823          	sw	a1,16(sp)
80000d80:	80004537          	lui	a0,0x80004
80000d84:	65050593          	addi	a1,a0,1616 # 80004650 <ebss+0xffffd650>
80000d88:	00c10513          	addi	a0,sp,12
80000d8c:	01010613          	addi	a2,sp,16
80000d90:	00001097          	auipc	ra,0x1
80000d94:	744080e7          	jalr	1860(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
80000d98:	02c12083          	lw	ra,44(sp)
80000d9c:	03010113          	addi	sp,sp,48
80000da0:	00008067          	ret

80000da4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h21a4afadc4b849daE.llvm.7793597378114770890>:
80000da4:	02060463          	beqz	a2,80000dcc <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h21a4afadc4b849daE.llvm.7793597378114770890+0x28>
80000da8:	00052503          	lw	a0,0(a0)
80000dac:	00c58633          	add	a2,a1,a2
80000db0:	0005c683          	lbu	a3,0(a1)
80000db4:	00554703          	lbu	a4,5(a0)
80000db8:	02077713          	andi	a4,a4,32
80000dbc:	fe070ce3          	beqz	a4,80000db4 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h21a4afadc4b849daE.llvm.7793597378114770890+0x10>
80000dc0:	00158593          	addi	a1,a1,1
80000dc4:	00d50023          	sb	a3,0(a0)
80000dc8:	fec594e3          	bne	a1,a2,80000db0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h21a4afadc4b849daE.llvm.7793597378114770890+0xc>
80000dcc:	00000513          	li	a0,0
80000dd0:	00008067          	ret

80000dd4 <_ZN3rbl6serial5print17hbd21c0db296e1a05E>:
80000dd4:	fd010113          	addi	sp,sp,-48
80000dd8:	02112623          	sw	ra,44(sp)
80000ddc:	01452583          	lw	a1,20(a0)
80000de0:	01052603          	lw	a2,16(a0)
80000de4:	100006b7          	lui	a3,0x10000
80000de8:	00d12623          	sw	a3,12(sp)
80000dec:	02b12223          	sw	a1,36(sp)
80000df0:	02c12023          	sw	a2,32(sp)
80000df4:	00c52583          	lw	a1,12(a0)
80000df8:	00852603          	lw	a2,8(a0)
80000dfc:	00452683          	lw	a3,4(a0)
80000e00:	00052503          	lw	a0,0(a0)
80000e04:	00b12e23          	sw	a1,28(sp)
80000e08:	00c12c23          	sw	a2,24(sp)
80000e0c:	00d12a23          	sw	a3,20(sp)
80000e10:	00a12823          	sw	a0,16(sp)
80000e14:	80004537          	lui	a0,0x80004
80000e18:	65050593          	addi	a1,a0,1616 # 80004650 <ebss+0xffffd650>
80000e1c:	00c10513          	addi	a0,sp,12
80000e20:	01010613          	addi	a2,sp,16
80000e24:	00001097          	auipc	ra,0x1
80000e28:	6b0080e7          	jalr	1712(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
80000e2c:	00051863          	bnez	a0,80000e3c <_ZN3rbl6serial5print17hbd21c0db296e1a05E+0x68>
80000e30:	02c12083          	lw	ra,44(sp)
80000e34:	03010113          	addi	sp,sp,48
80000e38:	00008067          	ret
80000e3c:	80004537          	lui	a0,0x80004
80000e40:	66850513          	addi	a0,a0,1640 # 80004668 <ebss+0xffffd668>
80000e44:	800045b7          	lui	a1,0x80004
80000e48:	69458693          	addi	a3,a1,1684 # 80004694 <ebss+0xffffd694>
80000e4c:	800045b7          	lui	a1,0x80004
80000e50:	6b458713          	addi	a4,a1,1716 # 800046b4 <ebss+0xffffd6b4>
80000e54:	02b00593          	li	a1,43
80000e58:	01010613          	addi	a2,sp,16
80000e5c:	00001097          	auipc	ra,0x1
80000e60:	b30080e7          	jalr	-1232(ra) # 8000198c <_ZN4core6result13unwrap_failed17h3d45bfc3fc39404dE>
80000e64:	c0001073          	unimp
	...

80000e70 <trap_vector>:
80000e70:	34011173          	csrrw	sp,mscratch,sp
80000e74:	12010063          	beqz	sp,80000f94 <trap_from_machine_mode>
80000e78:	f8010113          	addi	sp,sp,-128
80000e7c:	00012023          	sw	zero,0(sp)
80000e80:	00112223          	sw	ra,4(sp)
80000e84:	340020f3          	csrr	ra,mscratch
80000e88:	00112423          	sw	ra,8(sp)
80000e8c:	00312623          	sw	gp,12(sp)
80000e90:	00412823          	sw	tp,16(sp)
80000e94:	00512a23          	sw	t0,20(sp)
80000e98:	00612c23          	sw	t1,24(sp)
80000e9c:	00712e23          	sw	t2,28(sp)
80000ea0:	02812023          	sw	s0,32(sp)
80000ea4:	02912223          	sw	s1,36(sp)
80000ea8:	02a12423          	sw	a0,40(sp)
80000eac:	02b12623          	sw	a1,44(sp)
80000eb0:	02c12823          	sw	a2,48(sp)
80000eb4:	02d12a23          	sw	a3,52(sp)
80000eb8:	02e12c23          	sw	a4,56(sp)
80000ebc:	02f12e23          	sw	a5,60(sp)
80000ec0:	05012023          	sw	a6,64(sp)
80000ec4:	05112223          	sw	a7,68(sp)
80000ec8:	05212423          	sw	s2,72(sp)
80000ecc:	05312623          	sw	s3,76(sp)
80000ed0:	05412823          	sw	s4,80(sp)
80000ed4:	05512a23          	sw	s5,84(sp)
80000ed8:	05612c23          	sw	s6,88(sp)
80000edc:	05712e23          	sw	s7,92(sp)
80000ee0:	07812023          	sw	s8,96(sp)
80000ee4:	07912223          	sw	s9,100(sp)
80000ee8:	07a12423          	sw	s10,104(sp)
80000eec:	07b12623          	sw	s11,108(sp)
80000ef0:	07c12823          	sw	t3,112(sp)
80000ef4:	07d12a23          	sw	t4,116(sp)
80000ef8:	07e12c23          	sw	t5,120(sp)
80000efc:	07f12e23          	sw	t6,124(sp)
80000f00:	00010513          	mv	a0,sp
80000f04:	80dff0ef          	jal	ra,80000710 <trap_handler>
80000f08:	34151073          	csrw	mepc,a0
80000f0c:	08010293          	addi	t0,sp,128
80000f10:	34029073          	csrw	mscratch,t0
80000f14:	00412083          	lw	ra,4(sp)
80000f18:	00c12183          	lw	gp,12(sp)
80000f1c:	01012203          	lw	tp,16(sp)
80000f20:	01412283          	lw	t0,20(sp)
80000f24:	01812303          	lw	t1,24(sp)
80000f28:	01c12383          	lw	t2,28(sp)
80000f2c:	02012403          	lw	s0,32(sp)
80000f30:	02412483          	lw	s1,36(sp)
80000f34:	02812503          	lw	a0,40(sp)
80000f38:	02c12583          	lw	a1,44(sp)
80000f3c:	03012603          	lw	a2,48(sp)
80000f40:	03412683          	lw	a3,52(sp)
80000f44:	03812703          	lw	a4,56(sp)
80000f48:	03c12783          	lw	a5,60(sp)
80000f4c:	04012803          	lw	a6,64(sp)
80000f50:	04412883          	lw	a7,68(sp)
80000f54:	04812903          	lw	s2,72(sp)
80000f58:	04c12983          	lw	s3,76(sp)
80000f5c:	05012a03          	lw	s4,80(sp)
80000f60:	05412a83          	lw	s5,84(sp)
80000f64:	05812b03          	lw	s6,88(sp)
80000f68:	05c12b83          	lw	s7,92(sp)
80000f6c:	06012c03          	lw	s8,96(sp)
80000f70:	06412c83          	lw	s9,100(sp)
80000f74:	06812d03          	lw	s10,104(sp)
80000f78:	06c12d83          	lw	s11,108(sp)
80000f7c:	07012e03          	lw	t3,112(sp)
80000f80:	07412e83          	lw	t4,116(sp)
80000f84:	07812f03          	lw	t5,120(sp)
80000f88:	07c12f83          	lw	t6,124(sp)
80000f8c:	00812103          	lw	sp,8(sp)
80000f90:	30200073          	mret

80000f94 <trap_from_machine_mode>:
80000f94:	10500073          	wfi

80000f98 <boot_first_hart>:
80000f98:	fb010113          	addi	sp,sp,-80
80000f9c:	04112623          	sw	ra,76(sp)
80000fa0:	04812423          	sw	s0,72(sp)
80000fa4:	00a12623          	sw	a0,12(sp)
80000fa8:	80007537          	lui	a0,0x80007
80000fac:	00050513          	mv	a0,a0
80000fb0:	80007637          	lui	a2,0x80007
80000fb4:	00060613          	mv	a2,a2
80000fb8:	00b12823          	sw	a1,16(sp)
80000fbc:	00a67863          	bgeu	a2,a0,80000fcc <boot_first_hart+0x34>
80000fc0:	00062023          	sw	zero,0(a2) # 80007000 <ebss+0x0>
80000fc4:	00460613          	addi	a2,a2,4
80000fc8:	fea66ce3          	bltu	a2,a0,80000fc0 <boot_first_hart+0x28>
80000fcc:	80004537          	lui	a0,0x80004
80000fd0:	6e450513          	addi	a0,a0,1764 # 800046e4 <ebss+0xffffd6e4>
80000fd4:	02a12823          	sw	a0,48(sp)
80000fd8:	00100513          	li	a0,1
80000fdc:	02a12a23          	sw	a0,52(sp)
80000fe0:	02012c23          	sw	zero,56(sp)
80000fe4:	80004537          	lui	a0,0x80004
80000fe8:	6ec50513          	addi	a0,a0,1772 # 800046ec <ebss+0xffffd6ec>
80000fec:	04a12023          	sw	a0,64(sp)
80000ff0:	04012223          	sw	zero,68(sp)
80000ff4:	03010513          	addi	a0,sp,48
80000ff8:	03010413          	addi	s0,sp,48
80000ffc:	00000097          	auipc	ra,0x0
80001000:	dd8080e7          	jalr	-552(ra) # 80000dd4 <_ZN3rbl6serial5print17hbd21c0db296e1a05E>
80001004:	80400537          	lui	a0,0x80400
80001008:	00a12a23          	sw	a0,20(sp)
8000100c:	01410513          	addi	a0,sp,20
80001010:	02a12823          	sw	a0,48(sp)
80001014:	80004537          	lui	a0,0x80004
80001018:	b1850513          	addi	a0,a0,-1256 # 80003b18 <ebss+0xffffcb18>
8000101c:	02a12a23          	sw	a0,52(sp)
80001020:	00c10593          	addi	a1,sp,12
80001024:	02b12c23          	sw	a1,56(sp)
80001028:	800045b7          	lui	a1,0x80004
8000102c:	fd458593          	addi	a1,a1,-44 # 80003fd4 <ebss+0xffffcfd4>
80001030:	02b12e23          	sw	a1,60(sp)
80001034:	01010593          	addi	a1,sp,16
80001038:	04b12023          	sw	a1,64(sp)
8000103c:	04a12223          	sw	a0,68(sp)
80001040:	80004537          	lui	a0,0x80004
80001044:	77c50513          	addi	a0,a0,1916 # 8000477c <ebss+0xffffd77c>
80001048:	00a12c23          	sw	a0,24(sp)
8000104c:	00400513          	li	a0,4
80001050:	00a12e23          	sw	a0,28(sp)
80001054:	80004537          	lui	a0,0x80004
80001058:	79c50513          	addi	a0,a0,1948 # 8000479c <ebss+0xffffd79c>
8000105c:	02a12023          	sw	a0,32(sp)
80001060:	00300513          	li	a0,3
80001064:	02a12223          	sw	a0,36(sp)
80001068:	02812423          	sw	s0,40(sp)
8000106c:	02a12623          	sw	a0,44(sp)
80001070:	01810513          	addi	a0,sp,24
80001074:	00000097          	auipc	ra,0x0
80001078:	d60080e7          	jalr	-672(ra) # 80000dd4 <_ZN3rbl6serial5print17hbd21c0db296e1a05E>
8000107c:	22200513          	li	a0,546
80001080:	30351073          	csrw	mideleg,a0
80001084:	0000b537          	lui	a0,0xb
80001088:	10950513          	addi	a0,a0,265 # b109 <.Lline_table_start0+0xb109>
8000108c:	30251073          	csrw	medeleg,a0
80001090:	08800513          	li	a0,136
80001094:	30451073          	csrw	mie,a0
80001098:	30002573          	csrr	a0,mstatus
8000109c:	ffff95b7          	lui	a1,0xffff9
800010a0:	77f58593          	addi	a1,a1,1919 # ffff977f <ebss+0x7fff277f>
800010a4:	00b57533          	and	a0,a0,a1
800010a8:	000015b7          	lui	a1,0x1
800010ac:	80058593          	addi	a1,a1,-2048 # 800 <.Lline_table_start0+0x800>
800010b0:	00b56533          	or	a0,a0,a1
800010b4:	30051073          	csrw	mstatus,a0
800010b8:	01412503          	lw	a0,20(sp)
800010bc:	34151073          	csrw	mepc,a0
800010c0:	18001073          	csrw	satp,zero
800010c4:	00c12503          	lw	a0,12(sp)
800010c8:	01012583          	lw	a1,16(sp)
800010cc:	00100613          	li	a2,1
800010d0:	30200073          	mret
800010d4:	80004537          	lui	a0,0x80004
800010d8:	7fc50513          	addi	a0,a0,2044 # 800047fc <ebss+0xffffd7fc>
800010dc:	800055b7          	lui	a1,0x80005
800010e0:	83058613          	addi	a2,a1,-2000 # 80004830 <ebss+0xffffd830>
800010e4:	02800593          	li	a1,40
800010e8:	00000097          	auipc	ra,0x0
800010ec:	7bc080e7          	jalr	1980(ra) # 800018a4 <_ZN4core9panicking5panic17h6e58be21c8262ebcE>
800010f0:	c0001073          	unimp

800010f4 <rust_begin_unwind>:
800010f4:	fc010113          	addi	sp,sp,-64
800010f8:	02112e23          	sw	ra,60(sp)
800010fc:	00a12623          	sw	a0,12(sp)
80001100:	00c10513          	addi	a0,sp,12
80001104:	00a12823          	sw	a0,16(sp)
80001108:	80000537          	lui	a0,0x80000
8000110c:	0b850513          	addi	a0,a0,184 # 800000b8 <ebss+0xffff90b8>
80001110:	00a12a23          	sw	a0,20(sp)
80001114:	10000537          	lui	a0,0x10000
80001118:	00a12e23          	sw	a0,28(sp)
8000111c:	80005537          	lui	a0,0x80005
80001120:	84050513          	addi	a0,a0,-1984 # 80004840 <ebss+0xffffd840>
80001124:	02a12023          	sw	a0,32(sp)
80001128:	00200513          	li	a0,2
8000112c:	02a12223          	sw	a0,36(sp)
80001130:	02012423          	sw	zero,40(sp)
80001134:	01010513          	addi	a0,sp,16
80001138:	02a12823          	sw	a0,48(sp)
8000113c:	00100513          	li	a0,1
80001140:	02a12a23          	sw	a0,52(sp)
80001144:	80004537          	lui	a0,0x80004
80001148:	65050593          	addi	a1,a0,1616 # 80004650 <ebss+0xffffd650>
8000114c:	01c10513          	addi	a0,sp,28
80001150:	02010613          	addi	a2,sp,32
80001154:	00001097          	auipc	ra,0x1
80001158:	380080e7          	jalr	896(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
8000115c:	00051463          	bnez	a0,80001164 <rust_begin_unwind+0x70>
80001160:	0000006f          	j	80001160 <rust_begin_unwind+0x6c>
80001164:	80004537          	lui	a0,0x80004
80001168:	66850513          	addi	a0,a0,1640 # 80004668 <ebss+0xffffd668>
8000116c:	800045b7          	lui	a1,0x80004
80001170:	69458693          	addi	a3,a1,1684 # 80004694 <ebss+0xffffd694>
80001174:	800045b7          	lui	a1,0x80004
80001178:	6b458713          	addi	a4,a1,1716 # 800046b4 <ebss+0xffffd6b4>
8000117c:	02b00593          	li	a1,43
80001180:	02010613          	addi	a2,sp,32
80001184:	00001097          	auipc	ra,0x1
80001188:	808080e7          	jalr	-2040(ra) # 8000198c <_ZN4core6result13unwrap_failed17h3d45bfc3fc39404dE>
8000118c:	c0001073          	unimp

80001190 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he9552901bc687830E>:
80001190:	ff010113          	addi	sp,sp,-16
80001194:	00112623          	sw	ra,12(sp)
80001198:	00812423          	sw	s0,8(sp)
8000119c:	00912223          	sw	s1,4(sp)
800011a0:	00052483          	lw	s1,0(a0)
800011a4:	00058413          	mv	s0,a1
800011a8:	00058513          	mv	a0,a1
800011ac:	00002097          	auipc	ra,0x2
800011b0:	d80080e7          	jalr	-640(ra) # 80002f2c <_ZN4core3fmt9Formatter15debug_lower_hex17h38efe26ca78948c0E>
800011b4:	02050263          	beqz	a0,800011d8 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he9552901bc687830E+0x48>
800011b8:	00048513          	mv	a0,s1
800011bc:	00040593          	mv	a1,s0
800011c0:	00412483          	lw	s1,4(sp)
800011c4:	00812403          	lw	s0,8(sp)
800011c8:	00c12083          	lw	ra,12(sp)
800011cc:	01010113          	addi	sp,sp,16
800011d0:	00003317          	auipc	t1,0x3
800011d4:	94830067          	jr	-1720(t1) # 80003b18 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17he3a030007845ea13E>
800011d8:	00040513          	mv	a0,s0
800011dc:	00002097          	auipc	ra,0x2
800011e0:	d60080e7          	jalr	-672(ra) # 80002f3c <_ZN4core3fmt9Formatter15debug_upper_hex17hc0a12002b7a1ac2bE>
800011e4:	02050263          	beqz	a0,80001208 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17he9552901bc687830E+0x78>
800011e8:	00048513          	mv	a0,s1
800011ec:	00040593          	mv	a1,s0
800011f0:	00412483          	lw	s1,4(sp)
800011f4:	00812403          	lw	s0,8(sp)
800011f8:	00c12083          	lw	ra,12(sp)
800011fc:	01010113          	addi	sp,sp,16
80001200:	00003317          	auipc	t1,0x3
80001204:	9c830067          	jr	-1592(t1) # 80003bc8 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2703b71c89cf64d6E>
80001208:	00048513          	mv	a0,s1
8000120c:	00040593          	mv	a1,s0
80001210:	00412483          	lw	s1,4(sp)
80001214:	00812403          	lw	s0,8(sp)
80001218:	00c12083          	lw	ra,12(sp)
8000121c:	01010113          	addi	sp,sp,16
80001220:	00003317          	auipc	t1,0x3
80001224:	db430067          	jr	-588(t1) # 80003fd4 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf0e441e4f1f8f3a3E>

80001228 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3c9607b58783ee18E>:
80001228:	00052503          	lw	a0,0(a0)
8000122c:	00000317          	auipc	t1,0x0
80001230:	1c830067          	jr	456(t1) # 800013f4 <_ZN71_$LT$riscv..register..mcause..Interrupt$u20$as$u20$core..fmt..Debug$GT$3fmt17h02df658714f77b5cE>

80001234 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hf8df5339efd8d0b8E>:
80001234:	00052503          	lw	a0,0(a0)
80001238:	00000317          	auipc	t1,0x0
8000123c:	2a430067          	jr	676(t1) # 800014dc <_ZN71_$LT$riscv..register..mcause..Exception$u20$as$u20$core..fmt..Debug$GT$3fmt17h2cc204d25acd5466E>

80001240 <_ZN4core3ptr30drop_in_place$LT$$RF$usize$GT$17h222d31e055e3ed6fE>:
80001240:	00008067          	ret

80001244 <_ZN5riscv8register6mcause9Interrupt4from17h9e168bf52c128881E>:
80001244:	00050593          	mv	a1,a0
80001248:	00b00613          	li	a2,11
8000124c:	00900513          	li	a0,9
80001250:	06b66063          	bltu	a2,a1,800012b0 <.LBB3_11>
80001254:	00259593          	slli	a1,a1,0x2
80001258:	80005637          	lui	a2,0x80005
8000125c:	85060613          	addi	a2,a2,-1968 # 80004850 <ebss+0xffffd850>
80001260:	00c585b3          	add	a1,a1,a2
80001264:	0005a583          	lw	a1,0(a1)
80001268:	00058067          	jr	a1

8000126c <.LBB3_2>:
8000126c:	00000513          	li	a0,0
80001270:	00008067          	ret

80001274 <.LBB3_3>:
80001274:	00100513          	li	a0,1
80001278:	00008067          	ret

8000127c <.LBB3_4>:
8000127c:	00200513          	li	a0,2
80001280:	00008067          	ret

80001284 <.LBB3_5>:
80001284:	00300513          	li	a0,3
80001288:	00008067          	ret

8000128c <.LBB3_6>:
8000128c:	00400513          	li	a0,4
80001290:	00008067          	ret

80001294 <.LBB3_7>:
80001294:	00500513          	li	a0,5
80001298:	00008067          	ret

8000129c <.LBB3_8>:
8000129c:	00600513          	li	a0,6
800012a0:	00008067          	ret

800012a4 <.LBB3_9>:
800012a4:	00700513          	li	a0,7
800012a8:	00008067          	ret

800012ac <.LBB3_10>:
800012ac:	00800513          	li	a0,8

800012b0 <.LBB3_11>:
800012b0:	00008067          	ret

800012b4 <_ZN5riscv8register6mcause9Exception4from17h925cbab6cc6afdcdE>:
800012b4:	00050593          	mv	a1,a0
800012b8:	00f00613          	li	a2,15
800012bc:	00e00513          	li	a0,14
800012c0:	08b66463          	bltu	a2,a1,80001348 <.LBB4_16>
800012c4:	00259593          	slli	a1,a1,0x2
800012c8:	80005637          	lui	a2,0x80005
800012cc:	88060613          	addi	a2,a2,-1920 # 80004880 <ebss+0xffffd880>
800012d0:	00c585b3          	add	a1,a1,a2
800012d4:	0005a583          	lw	a1,0(a1)
800012d8:	00058067          	jr	a1

800012dc <.LBB4_2>:
800012dc:	00000513          	li	a0,0
800012e0:	00008067          	ret

800012e4 <.LBB4_3>:
800012e4:	00100513          	li	a0,1
800012e8:	00008067          	ret

800012ec <.LBB4_4>:
800012ec:	00200513          	li	a0,2
800012f0:	00008067          	ret

800012f4 <.LBB4_5>:
800012f4:	00300513          	li	a0,3
800012f8:	00008067          	ret

800012fc <.LBB4_6>:
800012fc:	00400513          	li	a0,4
80001300:	00008067          	ret

80001304 <.LBB4_7>:
80001304:	00500513          	li	a0,5
80001308:	00008067          	ret

8000130c <.LBB4_8>:
8000130c:	00600513          	li	a0,6
80001310:	00008067          	ret

80001314 <.LBB4_9>:
80001314:	00700513          	li	a0,7
80001318:	00008067          	ret

8000131c <.LBB4_10>:
8000131c:	00800513          	li	a0,8
80001320:	00008067          	ret

80001324 <.LBB4_11>:
80001324:	00900513          	li	a0,9
80001328:	00008067          	ret

8000132c <.LBB4_12>:
8000132c:	00a00513          	li	a0,10
80001330:	00008067          	ret

80001334 <.LBB4_13>:
80001334:	00b00513          	li	a0,11
80001338:	00008067          	ret

8000133c <.LBB4_14>:
8000133c:	00c00513          	li	a0,12
80001340:	00008067          	ret

80001344 <.LBB4_15>:
80001344:	00d00513          	li	a0,13

80001348 <.LBB4_16>:
80001348:	00008067          	ret

8000134c <_ZN5riscv8register6mcause6Mcause4code17hb0194acaa4b9e1ccE>:
8000134c:	00052503          	lw	a0,0(a0)
80001350:	800005b7          	lui	a1,0x80000
80001354:	fff58593          	addi	a1,a1,-1 # 7fffffff <ebss+0xffff8fff>
80001358:	00b57533          	and	a0,a0,a1
8000135c:	00008067          	ret

80001360 <_ZN66_$LT$riscv..register..mcause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17h721d3a9539cf6d46E>:
80001360:	fe010113          	addi	sp,sp,-32
80001364:	00112e23          	sw	ra,28(sp)
80001368:	00812c23          	sw	s0,24(sp)
8000136c:	00054603          	lbu	a2,0(a0)
80001370:	00100693          	li	a3,1
80001374:	00150413          	addi	s0,a0,1
80001378:	02d61663          	bne	a2,a3,800013a4 <_ZN66_$LT$riscv..register..mcause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17h721d3a9539cf6d46E+0x44>
8000137c:	80005537          	lui	a0,0x80005
80001380:	92450613          	addi	a2,a0,-1756 # 80004924 <ebss+0xffffd924>
80001384:	00810513          	addi	a0,sp,8
80001388:	00900693          	li	a3,9
8000138c:	00002097          	auipc	ra,0x2
80001390:	bf8080e7          	jalr	-1032(ra) # 80002f84 <_ZN4core3fmt9Formatter11debug_tuple17h3747f691d94e4e92E>
80001394:	00812a23          	sw	s0,20(sp)
80001398:	80005537          	lui	a0,0x80005
8000139c:	93050613          	addi	a2,a0,-1744 # 80004930 <ebss+0xffffd930>
800013a0:	0280006f          	j	800013c8 <_ZN66_$LT$riscv..register..mcause..Trap$u20$as$u20$core..fmt..Debug$GT$3fmt17h721d3a9539cf6d46E+0x68>
800013a4:	80005537          	lui	a0,0x80005
800013a8:	94050613          	addi	a2,a0,-1728 # 80004940 <ebss+0xffffd940>
800013ac:	00810513          	addi	a0,sp,8
800013b0:	00900693          	li	a3,9
800013b4:	00002097          	auipc	ra,0x2
800013b8:	bd0080e7          	jalr	-1072(ra) # 80002f84 <_ZN4core3fmt9Formatter11debug_tuple17h3747f691d94e4e92E>
800013bc:	00812a23          	sw	s0,20(sp)
800013c0:	80005537          	lui	a0,0x80005
800013c4:	94c50613          	addi	a2,a0,-1716 # 8000494c <ebss+0xffffd94c>
800013c8:	00810513          	addi	a0,sp,8
800013cc:	01410593          	addi	a1,sp,20
800013d0:	00001097          	auipc	ra,0x1
800013d4:	bd4080e7          	jalr	-1068(ra) # 80001fa4 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E>
800013d8:	00810513          	addi	a0,sp,8
800013dc:	00001097          	auipc	ra,0x1
800013e0:	d70080e7          	jalr	-656(ra) # 8000214c <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE>
800013e4:	01812403          	lw	s0,24(sp)
800013e8:	01c12083          	lw	ra,28(sp)
800013ec:	02010113          	addi	sp,sp,32
800013f0:	00008067          	ret

800013f4 <_ZN71_$LT$riscv..register..mcause..Interrupt$u20$as$u20$core..fmt..Debug$GT$3fmt17h02df658714f77b5cE>:
800013f4:	00054503          	lbu	a0,0(a0)
800013f8:	00251513          	slli	a0,a0,0x2
800013fc:	80005637          	lui	a2,0x80005
80001400:	8c060613          	addi	a2,a2,-1856 # 800048c0 <ebss+0xffffd8c0>
80001404:	00c50533          	add	a0,a0,a2
80001408:	00052603          	lw	a2,0(a0)
8000140c:	00058513          	mv	a0,a1
80001410:	00060067          	jr	a2

80001414 <.LBB8_1>:
80001414:	800045b7          	lui	a1,0x80004
80001418:	3e458593          	addi	a1,a1,996 # 800043e4 <ebss+0xffffd3e4>
8000141c:	00800613          	li	a2,8
80001420:	00002317          	auipc	t1,0x2
80001424:	afc30067          	jr	-1284(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001428 <.LBB8_2>:
80001428:	800055b7          	lui	a1,0x80005
8000142c:	9bf58593          	addi	a1,a1,-1601 # 800049bf <ebss+0xffffd9bf>
80001430:	00e00613          	li	a2,14
80001434:	00002317          	auipc	t1,0x2
80001438:	ae830067          	jr	-1304(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

8000143c <.LBB8_3>:
8000143c:	800055b7          	lui	a1,0x80005
80001440:	9b458593          	addi	a1,a1,-1612 # 800049b4 <ebss+0xffffd9b4>
80001444:	00b00613          	li	a2,11
80001448:	00002317          	auipc	t1,0x2
8000144c:	ad430067          	jr	-1324(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001450 <.LBB8_4>:
80001450:	800055b7          	lui	a1,0x80005
80001454:	9ab58593          	addi	a1,a1,-1621 # 800049ab <ebss+0xffffd9ab>
80001458:	00900613          	li	a2,9
8000145c:	00002317          	auipc	t1,0x2
80001460:	ac030067          	jr	-1344(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001464 <.LBB8_5>:
80001464:	800055b7          	lui	a1,0x80005
80001468:	99c58593          	addi	a1,a1,-1636 # 8000499c <ebss+0xffffd99c>
8000146c:	00f00613          	li	a2,15
80001470:	00002317          	auipc	t1,0x2
80001474:	aac30067          	jr	-1364(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001478 <.LBB8_6>:
80001478:	800055b7          	lui	a1,0x80005
8000147c:	99058593          	addi	a1,a1,-1648 # 80004990 <ebss+0xffffd990>
80001480:	00c00613          	li	a2,12
80001484:	00002317          	auipc	t1,0x2
80001488:	a9830067          	jr	-1384(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

8000148c <.LBB8_7>:
8000148c:	800055b7          	lui	a1,0x80005
80001490:	98458593          	addi	a1,a1,-1660 # 80004984 <ebss+0xffffd984>
80001494:	00c00613          	li	a2,12
80001498:	00002317          	auipc	t1,0x2
8000149c:	a8430067          	jr	-1404(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800014a0 <.LBB8_8>:
800014a0:	800055b7          	lui	a1,0x80005
800014a4:	97258593          	addi	a1,a1,-1678 # 80004972 <ebss+0xffffd972>
800014a8:	01200613          	li	a2,18
800014ac:	00002317          	auipc	t1,0x2
800014b0:	a7030067          	jr	-1424(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800014b4 <.LBB8_9>:
800014b4:	800055b7          	lui	a1,0x80005
800014b8:	96358593          	addi	a1,a1,-1693 # 80004963 <ebss+0xffffd963>
800014bc:	00f00613          	li	a2,15
800014c0:	00002317          	auipc	t1,0x2
800014c4:	a5c30067          	jr	-1444(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800014c8 <.LBB8_10>:
800014c8:	800055b7          	lui	a1,0x80005
800014cc:	95c58593          	addi	a1,a1,-1700 # 8000495c <ebss+0xffffd95c>
800014d0:	00700613          	li	a2,7
800014d4:	00002317          	auipc	t1,0x2
800014d8:	a4830067          	jr	-1464(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800014dc <_ZN71_$LT$riscv..register..mcause..Exception$u20$as$u20$core..fmt..Debug$GT$3fmt17h2cc204d25acd5466E>:
800014dc:	00054503          	lbu	a0,0(a0)
800014e0:	00251513          	slli	a0,a0,0x2
800014e4:	80005637          	lui	a2,0x80005
800014e8:	8e860613          	addi	a2,a2,-1816 # 800048e8 <ebss+0xffffd8e8>
800014ec:	00c50533          	add	a0,a0,a2
800014f0:	00052603          	lw	a2,0(a0)
800014f4:	00058513          	mv	a0,a1
800014f8:	00060067          	jr	a2

800014fc <.LBB9_1>:
800014fc:	800055b7          	lui	a1,0x80005
80001500:	aa458593          	addi	a1,a1,-1372 # 80004aa4 <ebss+0xffffdaa4>
80001504:	01500613          	li	a2,21
80001508:	00002317          	auipc	t1,0x2
8000150c:	a1430067          	jr	-1516(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001510 <.LBB9_2>:
80001510:	800055b7          	lui	a1,0x80005
80001514:	a9458593          	addi	a1,a1,-1388 # 80004a94 <ebss+0xffffda94>
80001518:	01000613          	li	a2,16
8000151c:	00002317          	auipc	t1,0x2
80001520:	a0030067          	jr	-1536(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001524 <.LBB9_3>:
80001524:	800055b7          	lui	a1,0x80005
80001528:	a6058593          	addi	a1,a1,-1440 # 80004a60 <ebss+0xffffda60>
8000152c:	01200613          	li	a2,18
80001530:	00002317          	auipc	t1,0x2
80001534:	9ec30067          	jr	-1556(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001538 <.LBB9_4>:
80001538:	800055b7          	lui	a1,0x80005
8000153c:	a5658593          	addi	a1,a1,-1450 # 80004a56 <ebss+0xffffda56>
80001540:	00a00613          	li	a2,10
80001544:	00002317          	auipc	t1,0x2
80001548:	9d830067          	jr	-1576(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

8000154c <.LBB9_5>:
8000154c:	800055b7          	lui	a1,0x80005
80001550:	a4858593          	addi	a1,a1,-1464 # 80004a48 <ebss+0xffffda48>
80001554:	00e00613          	li	a2,14
80001558:	00002317          	auipc	t1,0x2
8000155c:	9c430067          	jr	-1596(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001560 <.LBB9_6>:
80001560:	800055b7          	lui	a1,0x80005
80001564:	a3f58593          	addi	a1,a1,-1473 # 80004a3f <ebss+0xffffda3f>
80001568:	00900613          	li	a2,9
8000156c:	00002317          	auipc	t1,0x2
80001570:	9b030067          	jr	-1616(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001574 <.LBB9_7>:
80001574:	800055b7          	lui	a1,0x80005
80001578:	a3058593          	addi	a1,a1,-1488 # 80004a30 <ebss+0xffffda30>
8000157c:	00f00613          	li	a2,15
80001580:	00002317          	auipc	t1,0x2
80001584:	99c30067          	jr	-1636(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001588 <.LBB9_8>:
80001588:	800055b7          	lui	a1,0x80005
8000158c:	a2658593          	addi	a1,a1,-1498 # 80004a26 <ebss+0xffffda26>
80001590:	00a00613          	li	a2,10
80001594:	00002317          	auipc	t1,0x2
80001598:	98830067          	jr	-1656(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

8000159c <.LBB9_9>:
8000159c:	800055b7          	lui	a1,0x80005
800015a0:	a1b58593          	addi	a1,a1,-1509 # 80004a1b <ebss+0xffffda1b>
800015a4:	00b00613          	li	a2,11
800015a8:	00002317          	auipc	t1,0x2
800015ac:	97430067          	jr	-1676(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800015b0 <.LBB9_10>:
800015b0:	800055b7          	lui	a1,0x80005
800015b4:	a0a58593          	addi	a1,a1,-1526 # 80004a0a <ebss+0xffffda0a>
800015b8:	01100613          	li	a2,17
800015bc:	00002317          	auipc	t1,0x2
800015c0:	96030067          	jr	-1696(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800015c4 <.LBB9_11>:
800015c4:	800055b7          	lui	a1,0x80005
800015c8:	9fc58593          	addi	a1,a1,-1540 # 800049fc <ebss+0xffffd9fc>
800015cc:	00e00613          	li	a2,14
800015d0:	00002317          	auipc	t1,0x2
800015d4:	94c30067          	jr	-1716(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800015d8 <.LBB9_12>:
800015d8:	800055b7          	lui	a1,0x80005
800015dc:	9e858593          	addi	a1,a1,-1560 # 800049e8 <ebss+0xffffd9e8>
800015e0:	01400613          	li	a2,20
800015e4:	00002317          	auipc	t1,0x2
800015e8:	93830067          	jr	-1736(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

800015ec <.LBB9_13>:
800015ec:	800055b7          	lui	a1,0x80005
800015f0:	9db58593          	addi	a1,a1,-1573 # 800049db <ebss+0xffffd9db>
800015f4:	00d00613          	li	a2,13
800015f8:	00002317          	auipc	t1,0x2
800015fc:	92430067          	jr	-1756(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001600 <.LBB9_14>:
80001600:	800055b7          	lui	a1,0x80005
80001604:	9cd58593          	addi	a1,a1,-1587 # 800049cd <ebss+0xffffd9cd>
80001608:	00e00613          	li	a2,14
8000160c:	00002317          	auipc	t1,0x2
80001610:	91030067          	jr	-1776(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001614 <.LBB9_15>:
80001614:	800055b7          	lui	a1,0x80005
80001618:	95c58593          	addi	a1,a1,-1700 # 8000495c <ebss+0xffffd95c>
8000161c:	00700613          	li	a2,7
80001620:	00002317          	auipc	t1,0x2
80001624:	8fc30067          	jr	-1796(t1) # 80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>

80001628 <__read_mhartid>:
80001628:	f1402573          	csrr	a0,mhartid
8000162c:	00008067          	ret

80001630 <__set_mie>:
80001630:	30452073          	csrs	mie,a0
80001634:	00008067          	ret

80001638 <__clear_mie>:
80001638:	30453073          	csrc	mie,a0
8000163c:	00008067          	ret

80001640 <__read_mepc>:
80001640:	34102573          	csrr	a0,mepc
80001644:	00008067          	ret

80001648 <__read_mcause>:
80001648:	34202573          	csrr	a0,mcause
8000164c:	00008067          	ret

80001650 <__read_mtval>:
80001650:	34302573          	csrr	a0,mtval
80001654:	00008067          	ret

80001658 <__set_mip>:
80001658:	34452073          	csrs	mip,a0
8000165c:	00008067          	ret

80001660 <__clear_mip>:
80001660:	34453073          	csrc	mip,a0
80001664:	00008067          	ret

80001668 <_ZN4core3ops8function6FnOnce9call_once17hc69dd6d8bcc89128E>:
80001668:	00052503          	lw	a0,0(a0)
8000166c:	0000006f          	j	8000166c <_ZN4core3ops8function6FnOnce9call_once17hc69dd6d8bcc89128E+0x4>

80001670 <_ZN4core3ptr102drop_in_place$LT$$RF$core..iter..adapters..copied..Copied$LT$core..slice..iter..Iter$LT$u8$GT$$GT$$GT$17haa55c5e588d24068E>:
80001670:	00008067          	ret

80001674 <_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h46218f6ccc34a73cE>:
80001674:	fd010113          	addi	sp,sp,-48
80001678:	02112623          	sw	ra,44(sp)
8000167c:	02812423          	sw	s0,40(sp)
80001680:	02912223          	sw	s1,36(sp)
80001684:	00058413          	mv	s0,a1
80001688:	00050493          	mv	s1,a0
8000168c:	00002097          	auipc	ra,0x2
80001690:	5ec080e7          	jalr	1516(ra) # 80003c78 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E>
80001694:	04051263          	bnez	a0,800016d8 <_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h46218f6ccc34a73cE+0x64>
80001698:	01842503          	lw	a0,24(s0)
8000169c:	01c42583          	lw	a1,28(s0)
800016a0:	80005637          	lui	a2,0x80005
800016a4:	ad860613          	addi	a2,a2,-1320 # 80004ad8 <ebss+0xffffdad8>
800016a8:	00c12423          	sw	a2,8(sp)
800016ac:	00100613          	li	a2,1
800016b0:	00c12623          	sw	a2,12(sp)
800016b4:	00012823          	sw	zero,16(sp)
800016b8:	80005637          	lui	a2,0x80005
800016bc:	ad460613          	addi	a2,a2,-1324 # 80004ad4 <ebss+0xffffdad4>
800016c0:	00c12c23          	sw	a2,24(sp)
800016c4:	00012e23          	sw	zero,28(sp)
800016c8:	00810613          	addi	a2,sp,8
800016cc:	00001097          	auipc	ra,0x1
800016d0:	e08080e7          	jalr	-504(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
800016d4:	00050e63          	beqz	a0,800016f0 <_ZN71_$LT$core..ops..range..Range$LT$Idx$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h46218f6ccc34a73cE+0x7c>
800016d8:	00100513          	li	a0,1
800016dc:	02412483          	lw	s1,36(sp)
800016e0:	02812403          	lw	s0,40(sp)
800016e4:	02c12083          	lw	ra,44(sp)
800016e8:	03010113          	addi	sp,sp,48
800016ec:	00008067          	ret
800016f0:	00448513          	addi	a0,s1,4
800016f4:	00040593          	mv	a1,s0
800016f8:	02412483          	lw	s1,36(sp)
800016fc:	02812403          	lw	s0,40(sp)
80001700:	02c12083          	lw	ra,44(sp)
80001704:	03010113          	addi	sp,sp,48
80001708:	00002317          	auipc	t1,0x2
8000170c:	57030067          	jr	1392(t1) # 80003c78 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E>

80001710 <_ZN36_$LT$T$u20$as$u20$core..any..Any$GT$7type_id17h63b6995297ab8571E>:
80001710:	4ccb3537          	lui	a0,0x4ccb3
80001714:	3e150513          	addi	a0,a0,993 # 4ccb33e1 <.Lline_table_start0+0x4cc88a4e>
80001718:	276ec5b7          	lui	a1,0x276ec
8000171c:	49c58593          	addi	a1,a1,1180 # 276ec49c <.Lline_table_start0+0x276c1b09>
80001720:	00008067          	ret

80001724 <_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h4ed6c1d285e05647E>:
80001724:	fb010113          	addi	sp,sp,-80
80001728:	04112623          	sw	ra,76(sp)
8000172c:	04812423          	sw	s0,72(sp)
80001730:	04912223          	sw	s1,68(sp)
80001734:	05212023          	sw	s2,64(sp)
80001738:	03312e23          	sw	s3,60(sp)
8000173c:	01c5a983          	lw	s3,28(a1)
80001740:	0185a483          	lw	s1,24(a1)
80001744:	00c9a683          	lw	a3,12(s3)
80001748:	00050913          	mv	s2,a0
8000174c:	80005537          	lui	a0,0x80005
80001750:	b3c50593          	addi	a1,a0,-1220 # 80004b3c <ebss+0xffffdb3c>
80001754:	00c00613          	li	a2,12
80001758:	00048513          	mv	a0,s1
8000175c:	000680e7          	jalr	a3 # 10000000 <.Lline_table_start0+0xffd566d>
80001760:	00100413          	li	s0,1
80001764:	12051063          	bnez	a0,80001884 <_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h4ed6c1d285e05647E+0x160>
80001768:	00892503          	lw	a0,8(s2)
8000176c:	00050e63          	beqz	a0,80001788 <_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h4ed6c1d285e05647E+0x64>
80001770:	00a12223          	sw	a0,4(sp)
80001774:	00410513          	addi	a0,sp,4
80001778:	00a12423          	sw	a0,8(sp)
8000177c:	80004537          	lui	a0,0x80004
80001780:	02c50513          	addi	a0,a0,44 # 8000402c <ebss+0xffffd02c>
80001784:	04c0006f          	j	800017d0 <_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h4ed6c1d285e05647E+0xac>
80001788:	00492503          	lw	a0,4(s2)
8000178c:	00092403          	lw	s0,0(s2)
80001790:	00c52583          	lw	a1,12(a0)
80001794:	00040513          	mv	a0,s0
80001798:	000580e7          	jalr	a1
8000179c:	7ef2b637          	lui	a2,0x7ef2b
800017a0:	91e60613          	addi	a2,a2,-1762 # 7ef2a91e <.Lline_table_start0+0x7eefff8b>
800017a4:	00c5c5b3          	xor	a1,a1,a2
800017a8:	ecc7c637          	lui	a2,0xecc7c
800017ac:	cf460613          	addi	a2,a2,-780 # ecc7bcf4 <ebss+0x6cc74cf4>
800017b0:	00c54533          	xor	a0,a0,a2
800017b4:	00b56533          	or	a0,a0,a1
800017b8:	04051e63          	bnez	a0,80001814 <_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h4ed6c1d285e05647E+0xf0>
800017bc:	00812223          	sw	s0,4(sp)
800017c0:	00410513          	addi	a0,sp,4
800017c4:	00a12423          	sw	a0,8(sp)
800017c8:	80004537          	lui	a0,0x80004
800017cc:	08850513          	addi	a0,a0,136 # 80004088 <ebss+0xffffd088>
800017d0:	00a12623          	sw	a0,12(sp)
800017d4:	80005537          	lui	a0,0x80005
800017d8:	b4c50513          	addi	a0,a0,-1204 # 80004b4c <ebss+0xffffdb4c>
800017dc:	02a12023          	sw	a0,32(sp)
800017e0:	00200513          	li	a0,2
800017e4:	02a12223          	sw	a0,36(sp)
800017e8:	02012423          	sw	zero,40(sp)
800017ec:	00810513          	addi	a0,sp,8
800017f0:	02a12823          	sw	a0,48(sp)
800017f4:	00100413          	li	s0,1
800017f8:	02812a23          	sw	s0,52(sp)
800017fc:	02010613          	addi	a2,sp,32
80001800:	00048513          	mv	a0,s1
80001804:	00098593          	mv	a1,s3
80001808:	00001097          	auipc	ra,0x1
8000180c:	ccc080e7          	jalr	-820(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
80001810:	06051a63          	bnez	a0,80001884 <_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h4ed6c1d285e05647E+0x160>
80001814:	00c92503          	lw	a0,12(s2)
80001818:	00850593          	addi	a1,a0,8
8000181c:	00c50613          	addi	a2,a0,12
80001820:	00a12423          	sw	a0,8(sp)
80001824:	80004537          	lui	a0,0x80004
80001828:	01450513          	addi	a0,a0,20 # 80004014 <ebss+0xffffd014>
8000182c:	00a12623          	sw	a0,12(sp)
80001830:	00b12823          	sw	a1,16(sp)
80001834:	80004537          	lui	a0,0x80004
80001838:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
8000183c:	00a12a23          	sw	a0,20(sp)
80001840:	00c12c23          	sw	a2,24(sp)
80001844:	00a12e23          	sw	a0,28(sp)
80001848:	80005537          	lui	a0,0x80005
8000184c:	b1450513          	addi	a0,a0,-1260 # 80004b14 <ebss+0xffffdb14>
80001850:	02a12023          	sw	a0,32(sp)
80001854:	00300513          	li	a0,3
80001858:	02a12223          	sw	a0,36(sp)
8000185c:	02012423          	sw	zero,40(sp)
80001860:	00810593          	addi	a1,sp,8
80001864:	02b12823          	sw	a1,48(sp)
80001868:	02a12a23          	sw	a0,52(sp)
8000186c:	02010613          	addi	a2,sp,32
80001870:	00048513          	mv	a0,s1
80001874:	00098593          	mv	a1,s3
80001878:	00001097          	auipc	ra,0x1
8000187c:	c5c080e7          	jalr	-932(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
80001880:	00050413          	mv	s0,a0
80001884:	00040513          	mv	a0,s0
80001888:	03c12983          	lw	s3,60(sp)
8000188c:	04012903          	lw	s2,64(sp)
80001890:	04412483          	lw	s1,68(sp)
80001894:	04812403          	lw	s0,72(sp)
80001898:	04c12083          	lw	ra,76(sp)
8000189c:	05010113          	addi	sp,sp,80
800018a0:	00008067          	ret

800018a4 <_ZN4core9panicking5panic17h6e58be21c8262ebcE>:
800018a4:	fd010113          	addi	sp,sp,-48
800018a8:	02112623          	sw	ra,44(sp)
800018ac:	02a12023          	sw	a0,32(sp)
800018b0:	02b12223          	sw	a1,36(sp)
800018b4:	02010513          	addi	a0,sp,32
800018b8:	00a12423          	sw	a0,8(sp)
800018bc:	00100513          	li	a0,1
800018c0:	00a12623          	sw	a0,12(sp)
800018c4:	00012823          	sw	zero,16(sp)
800018c8:	80005537          	lui	a0,0x80005
800018cc:	ad450513          	addi	a0,a0,-1324 # 80004ad4 <ebss+0xffffdad4>
800018d0:	00a12c23          	sw	a0,24(sp)
800018d4:	00012e23          	sw	zero,28(sp)
800018d8:	00810513          	addi	a0,sp,8
800018dc:	00060593          	mv	a1,a2
800018e0:	00000097          	auipc	ra,0x0
800018e4:	074080e7          	jalr	116(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
800018e8:	c0001073          	unimp

800018ec <_ZN4core9panicking18panic_bounds_check17h559cb3e10bbb8ef9E>:
800018ec:	fc010113          	addi	sp,sp,-64
800018f0:	02112e23          	sw	ra,60(sp)
800018f4:	00a12423          	sw	a0,8(sp)
800018f8:	00b12623          	sw	a1,12(sp)
800018fc:	00c10513          	addi	a0,sp,12
80001900:	02a12423          	sw	a0,40(sp)
80001904:	80004537          	lui	a0,0x80004
80001908:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
8000190c:	02a12623          	sw	a0,44(sp)
80001910:	00810593          	addi	a1,sp,8
80001914:	02b12823          	sw	a1,48(sp)
80001918:	02a12a23          	sw	a0,52(sp)
8000191c:	80005537          	lui	a0,0x80005
80001920:	b7050513          	addi	a0,a0,-1168 # 80004b70 <ebss+0xffffdb70>
80001924:	00a12823          	sw	a0,16(sp)
80001928:	00200513          	li	a0,2
8000192c:	00a12a23          	sw	a0,20(sp)
80001930:	00012c23          	sw	zero,24(sp)
80001934:	02810593          	addi	a1,sp,40
80001938:	02b12023          	sw	a1,32(sp)
8000193c:	02a12223          	sw	a0,36(sp)
80001940:	01010513          	addi	a0,sp,16
80001944:	00060593          	mv	a1,a2
80001948:	00000097          	auipc	ra,0x0
8000194c:	00c080e7          	jalr	12(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
80001950:	c0001073          	unimp

80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>:
80001954:	fe010113          	addi	sp,sp,-32
80001958:	00112e23          	sw	ra,28(sp)
8000195c:	80005637          	lui	a2,0x80005
80001960:	ad460613          	addi	a2,a2,-1324 # 80004ad4 <ebss+0xffffdad4>
80001964:	00c12423          	sw	a2,8(sp)
80001968:	80005637          	lui	a2,0x80005
8000196c:	b2c60613          	addi	a2,a2,-1236 # 80004b2c <ebss+0xffffdb2c>
80001970:	00c12623          	sw	a2,12(sp)
80001974:	00a12823          	sw	a0,16(sp)
80001978:	00b12a23          	sw	a1,20(sp)
8000197c:	00810513          	addi	a0,sp,8
80001980:	fffff097          	auipc	ra,0xfffff
80001984:	774080e7          	jalr	1908(ra) # 800010f4 <rust_begin_unwind>
80001988:	c0001073          	unimp

8000198c <_ZN4core6result13unwrap_failed17h3d45bfc3fc39404dE>:
8000198c:	fc010113          	addi	sp,sp,-64
80001990:	02112e23          	sw	ra,60(sp)
80001994:	00a12023          	sw	a0,0(sp)
80001998:	00b12223          	sw	a1,4(sp)
8000199c:	00c12423          	sw	a2,8(sp)
800019a0:	00d12623          	sw	a3,12(sp)
800019a4:	00010513          	mv	a0,sp
800019a8:	02a12423          	sw	a0,40(sp)
800019ac:	80004537          	lui	a0,0x80004
800019b0:	01450513          	addi	a0,a0,20 # 80004014 <ebss+0xffffd014>
800019b4:	02a12623          	sw	a0,44(sp)
800019b8:	00810513          	addi	a0,sp,8
800019bc:	02a12823          	sw	a0,48(sp)
800019c0:	80004537          	lui	a0,0x80004
800019c4:	00450513          	addi	a0,a0,4 # 80004004 <ebss+0xffffd004>
800019c8:	02a12a23          	sw	a0,52(sp)
800019cc:	80005537          	lui	a0,0x80005
800019d0:	b8450513          	addi	a0,a0,-1148 # 80004b84 <ebss+0xffffdb84>
800019d4:	00a12823          	sw	a0,16(sp)
800019d8:	00200513          	li	a0,2
800019dc:	00a12a23          	sw	a0,20(sp)
800019e0:	00012c23          	sw	zero,24(sp)
800019e4:	02810593          	addi	a1,sp,40
800019e8:	02b12023          	sw	a1,32(sp)
800019ec:	02a12223          	sw	a0,36(sp)
800019f0:	01010513          	addi	a0,sp,16
800019f4:	00070593          	mv	a1,a4
800019f8:	00000097          	auipc	ra,0x0
800019fc:	f5c080e7          	jalr	-164(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
80001a00:	c0001073          	unimp

80001a04 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E>:
80001a04:	fc010113          	addi	sp,sp,-64
80001a08:	02112e23          	sw	ra,60(sp)
80001a0c:	02812c23          	sw	s0,56(sp)
80001a10:	02912a23          	sw	s1,52(sp)
80001a14:	03212823          	sw	s2,48(sp)
80001a18:	03312623          	sw	s3,44(sp)
80001a1c:	03412423          	sw	s4,40(sp)
80001a20:	03512223          	sw	s5,36(sp)
80001a24:	03612023          	sw	s6,32(sp)
80001a28:	01712e23          	sw	s7,28(sp)
80001a2c:	01812c23          	sw	s8,24(sp)
80001a30:	01912a23          	sw	s9,20(sp)
80001a34:	01a12823          	sw	s10,16(sp)
80001a38:	01b12623          	sw	s11,12(sp)
80001a3c:	22060c63          	beqz	a2,80001c74 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x270>
80001a40:	00060b93          	mv	s7,a2
80001a44:	00058a13          	mv	s4,a1
80001a48:	00852a83          	lw	s5,8(a0)
80001a4c:	00052903          	lw	s2,0(a0)
80001a50:	00452403          	lw	s0,4(a0)
80001a54:	feff0537          	lui	a0,0xfeff0
80001a58:	eff50c13          	addi	s8,a0,-257 # fefefeff <ebss+0x7efe8eff>
80001a5c:	80808537          	lui	a0,0x80808
80001a60:	08050c93          	addi	s9,a0,128 # 80808080 <ebss+0x801080>
80001a64:	0a0a1537          	lui	a0,0xa0a1
80001a68:	a0a50d13          	addi	s10,a0,-1526 # a0a0a0a <.Lline_table_start0+0xa076077>
80001a6c:	00800493          	li	s1,8
80001a70:	00a00b13          	li	s6,10
80001a74:	80005537          	lui	a0,0x80005
80001a78:	ae050513          	addi	a0,a0,-1312 # 80004ae0 <ebss+0xffffdae0>
80001a7c:	00a12423          	sw	a0,8(sp)
80001a80:	0100006f          	j	80001a90 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x8c>
80001a84:	41bb8bb3          	sub	s7,s7,s11
80001a88:	01ba0a33          	add	s4,s4,s11
80001a8c:	1e0b8463          	beqz	s7,80001c74 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x270>
80001a90:	000ac503          	lbu	a0,0(s5)
80001a94:	00050e63          	beqz	a0,80001ab0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0xac>
80001a98:	00c42683          	lw	a3,12(s0)
80001a9c:	00400613          	li	a2,4
80001aa0:	00090513          	mv	a0,s2
80001aa4:	00812583          	lw	a1,8(sp)
80001aa8:	000680e7          	jalr	a3
80001aac:	1c051863          	bnez	a0,80001c7c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x278>
80001ab0:	00000d93          	li	s11,0
80001ab4:	000b8593          	mv	a1,s7
80001ab8:	00c0006f          	j	80001ac4 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0xc0>
80001abc:	41bb85b3          	sub	a1,s7,s11
80001ac0:	14051663          	bnez	a0,80001c0c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x208>
80001ac4:	01ba0633          	add	a2,s4,s11
80001ac8:	0295f263          	bgeu	a1,s1,80001aec <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0xe8>
80001acc:	14058063          	beqz	a1,80001c0c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x208>
80001ad0:	00000693          	li	a3,0
80001ad4:	00d60533          	add	a0,a2,a3
80001ad8:	00054503          	lbu	a0,0(a0)
80001adc:	0f650063          	beq	a0,s6,80001bbc <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x1b8>
80001ae0:	00168693          	addi	a3,a3,1
80001ae4:	fed598e3          	bne	a1,a3,80001ad4 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0xd0>
80001ae8:	1240006f          	j	80001c0c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x208>
80001aec:	00360513          	addi	a0,a2,3
80001af0:	ffc57513          	andi	a0,a0,-4
80001af4:	40c506b3          	sub	a3,a0,a2
80001af8:	02068c63          	beqz	a3,80001b30 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x12c>
80001afc:	00058513          	mv	a0,a1
80001b00:	00d5e463          	bltu	a1,a3,80001b08 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x104>
80001b04:	00068513          	mv	a0,a3
80001b08:	00000693          	li	a3,0
80001b0c:	00d60733          	add	a4,a2,a3
80001b10:	00074703          	lbu	a4,0(a4)
80001b14:	0b670463          	beq	a4,s6,80001bbc <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x1b8>
80001b18:	00168693          	addi	a3,a3,1
80001b1c:	fed518e3          	bne	a0,a3,80001b0c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x108>
80001b20:	ff858693          	addi	a3,a1,-8
80001b24:	00a6fa63          	bgeu	a3,a0,80001b38 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x134>
80001b28:	06b51463          	bne	a0,a1,80001b90 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x18c>
80001b2c:	0e00006f          	j	80001c0c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x208>
80001b30:	00000513          	li	a0,0
80001b34:	ff858693          	addi	a3,a1,-8
80001b38:	00040813          	mv	a6,s0
80001b3c:	00a60733          	add	a4,a2,a0
80001b40:	00072783          	lw	a5,0(a4)
80001b44:	00472703          	lw	a4,4(a4)
80001b48:	fff7c493          	not	s1,a5
80001b4c:	fff74413          	not	s0,a4
80001b50:	01a7c7b3          	xor	a5,a5,s10
80001b54:	018787b3          	add	a5,a5,s8
80001b58:	0194f4b3          	and	s1,s1,s9
80001b5c:	00f4f7b3          	and	a5,s1,a5
80001b60:	01a74733          	xor	a4,a4,s10
80001b64:	01870733          	add	a4,a4,s8
80001b68:	019474b3          	and	s1,s0,s9
80001b6c:	00e4f733          	and	a4,s1,a4
80001b70:	00e7e733          	or	a4,a5,a4
80001b74:	00071663          	bnez	a4,80001b80 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x17c>
80001b78:	00850513          	addi	a0,a0,8
80001b7c:	fca6f0e3          	bgeu	a3,a0,80001b3c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x138>
80001b80:	16a5e063          	bltu	a1,a0,80001ce0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x2dc>
80001b84:	00080413          	mv	s0,a6
80001b88:	00800493          	li	s1,8
80001b8c:	08b50063          	beq	a0,a1,80001c0c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x208>
80001b90:	00000613          	li	a2,0
80001b94:	01b506b3          	add	a3,a0,s11
80001b98:	00da06b3          	add	a3,s4,a3
80001b9c:	40a585b3          	sub	a1,a1,a0
80001ba0:	00c68733          	add	a4,a3,a2
80001ba4:	00074703          	lbu	a4,0(a4)
80001ba8:	01670863          	beq	a4,s6,80001bb8 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x1b4>
80001bac:	00160613          	addi	a2,a2,1
80001bb0:	fec598e3          	bne	a1,a2,80001ba0 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x19c>
80001bb4:	0580006f          	j	80001c0c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x208>
80001bb8:	00c506b3          	add	a3,a0,a2
80001bbc:	01b685b3          	add	a1,a3,s11
80001bc0:	00158d93          	addi	s11,a1,1
80001bc4:	00bdb633          	sltu	a2,s11,a1
80001bc8:	01bbb533          	sltu	a0,s7,s11
80001bcc:	00a66633          	or	a2,a2,a0
80001bd0:	ee0616e3          	bnez	a2,80001abc <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0xb8>
80001bd4:	00ba05b3          	add	a1,s4,a1
80001bd8:	0005c583          	lbu	a1,0(a1)
80001bdc:	ef6590e3          	bne	a1,s6,80001abc <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0xb8>
80001be0:	00100513          	li	a0,1
80001be4:	00aa8023          	sb	a0,0(s5)
80001be8:	037dea63          	bltu	s11,s7,80001c1c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x218>
80001bec:	0dbb9863          	bne	s7,s11,80001cbc <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x2b8>
80001bf0:	00c42683          	lw	a3,12(s0)
80001bf4:	00090513          	mv	a0,s2
80001bf8:	000a0593          	mv	a1,s4
80001bfc:	000d8613          	mv	a2,s11
80001c00:	000680e7          	jalr	a3
80001c04:	e80500e3          	beqz	a0,80001a84 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x80>
80001c08:	0740006f          	j	80001c7c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x278>
80001c0c:	00000513          	li	a0,0
80001c10:	000b8d93          	mv	s11,s7
80001c14:	00aa8023          	sb	a0,0(s5)
80001c18:	fd7dfae3          	bgeu	s11,s7,80001bec <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x1e8>
80001c1c:	01ba09b3          	add	s3,s4,s11
80001c20:	00098503          	lb	a0,0(s3)
80001c24:	fbf00593          	li	a1,-65
80001c28:	08a5da63          	bge	a1,a0,80001cbc <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x2b8>
80001c2c:	00c42683          	lw	a3,12(s0)
80001c30:	00090513          	mv	a0,s2
80001c34:	000a0593          	mv	a1,s4
80001c38:	000d8613          	mv	a2,s11
80001c3c:	000680e7          	jalr	a3
80001c40:	02051e63          	bnez	a0,80001c7c <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x278>
80001c44:	00098503          	lb	a0,0(s3)
80001c48:	fbf00593          	li	a1,-65
80001c4c:	e2a5cce3          	blt	a1,a0,80001a84 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x80>
80001c50:	80005537          	lui	a0,0x80005
80001c54:	bbc50713          	addi	a4,a0,-1092 # 80004bbc <ebss+0xffffdbbc>
80001c58:	000a0513          	mv	a0,s4
80001c5c:	000b8593          	mv	a1,s7
80001c60:	000d8613          	mv	a2,s11
80001c64:	000b8693          	mv	a3,s7
80001c68:	00002097          	auipc	ra,0x2
80001c6c:	9d0080e7          	jalr	-1584(ra) # 80003638 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E>
80001c70:	c0001073          	unimp
80001c74:	00000513          	li	a0,0
80001c78:	0080006f          	j	80001c80 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E+0x27c>
80001c7c:	00100513          	li	a0,1
80001c80:	00c12d83          	lw	s11,12(sp)
80001c84:	01012d03          	lw	s10,16(sp)
80001c88:	01412c83          	lw	s9,20(sp)
80001c8c:	01812c03          	lw	s8,24(sp)
80001c90:	01c12b83          	lw	s7,28(sp)
80001c94:	02012b03          	lw	s6,32(sp)
80001c98:	02412a83          	lw	s5,36(sp)
80001c9c:	02812a03          	lw	s4,40(sp)
80001ca0:	02c12983          	lw	s3,44(sp)
80001ca4:	03012903          	lw	s2,48(sp)
80001ca8:	03412483          	lw	s1,52(sp)
80001cac:	03812403          	lw	s0,56(sp)
80001cb0:	03c12083          	lw	ra,60(sp)
80001cb4:	04010113          	addi	sp,sp,64
80001cb8:	00008067          	ret
80001cbc:	80005537          	lui	a0,0x80005
80001cc0:	bac50713          	addi	a4,a0,-1108 # 80004bac <ebss+0xffffdbac>
80001cc4:	000a0513          	mv	a0,s4
80001cc8:	000b8593          	mv	a1,s7
80001ccc:	00000613          	li	a2,0
80001cd0:	000d8693          	mv	a3,s11
80001cd4:	00002097          	auipc	ra,0x2
80001cd8:	964080e7          	jalr	-1692(ra) # 80003638 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E>
80001cdc:	c0001073          	unimp
80001ce0:	80005637          	lui	a2,0x80005
80001ce4:	cf060613          	addi	a2,a2,-784 # 80004cf0 <ebss+0xffffdcf0>
80001ce8:	00002097          	auipc	ra,0x2
80001cec:	818080e7          	jalr	-2024(ra) # 80003500 <_ZN4core5slice5index26slice_start_index_len_fail17h00e5ce03f9138bcfE>
80001cf0:	c0001073          	unimp

80001cf4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E>:
80001cf4:	fa010113          	addi	sp,sp,-96
80001cf8:	04112e23          	sw	ra,92(sp)
80001cfc:	04812c23          	sw	s0,88(sp)
80001d00:	04912a23          	sw	s1,84(sp)
80001d04:	05212823          	sw	s2,80(sp)
80001d08:	05312623          	sw	s3,76(sp)
80001d0c:	05412423          	sw	s4,72(sp)
80001d10:	05512223          	sw	s5,68(sp)
80001d14:	05612023          	sw	s6,64(sp)
80001d18:	03712e23          	sw	s7,60(sp)
80001d1c:	00050413          	mv	s0,a0
80001d20:	00454503          	lbu	a0,4(a0)
80001d24:	00100b93          	li	s7,1
80001d28:	00100493          	li	s1,1
80001d2c:	02050e63          	beqz	a0,80001d68 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x74>
80001d30:	00940223          	sb	s1,4(s0)
80001d34:	017402a3          	sb	s7,5(s0)
80001d38:	00040513          	mv	a0,s0
80001d3c:	03c12b83          	lw	s7,60(sp)
80001d40:	04012b03          	lw	s6,64(sp)
80001d44:	04412a83          	lw	s5,68(sp)
80001d48:	04812a03          	lw	s4,72(sp)
80001d4c:	04c12983          	lw	s3,76(sp)
80001d50:	05012903          	lw	s2,80(sp)
80001d54:	05412483          	lw	s1,84(sp)
80001d58:	05812403          	lw	s0,88(sp)
80001d5c:	05c12083          	lw	ra,92(sp)
80001d60:	06010113          	addi	sp,sp,96
80001d64:	00008067          	ret
80001d68:	00070993          	mv	s3,a4
80001d6c:	00068913          	mv	s2,a3
80001d70:	00060a13          	mv	s4,a2
80001d74:	00058a93          	mv	s5,a1
80001d78:	00042b03          	lw	s6,0(s0)
80001d7c:	000b4503          	lbu	a0,0(s6)
80001d80:	00544583          	lbu	a1,5(s0)
80001d84:	00457513          	andi	a0,a0,4
80001d88:	0015b613          	seqz	a2,a1
80001d8c:	00051a63          	bnez	a0,80001da0 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0xac>
80001d90:	10061663          	bnez	a2,80001e9c <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x1a8>
80001d94:	80005537          	lui	a0,0x80005
80001d98:	bd150593          	addi	a1,a0,-1071 # 80004bd1 <ebss+0xffffdbd1>
80001d9c:	1080006f          	j	80001ea4 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x1b0>
80001da0:	02060463          	beqz	a2,80001dc8 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0xd4>
80001da4:	01cb2583          	lw	a1,28(s6)
80001da8:	018b2503          	lw	a0,24(s6)
80001dac:	00c5a683          	lw	a3,12(a1)
80001db0:	800055b7          	lui	a1,0x80005
80001db4:	bcc58593          	addi	a1,a1,-1076 # 80004bcc <ebss+0xffffdbcc>
80001db8:	00300613          	li	a2,3
80001dbc:	000680e7          	jalr	a3
80001dc0:	00100493          	li	s1,1
80001dc4:	f60516e3          	bnez	a0,80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>
80001dc8:	00100493          	li	s1,1
80001dcc:	00910ba3          	sb	s1,23(sp)
80001dd0:	018b2503          	lw	a0,24(s6)
80001dd4:	01cb2583          	lw	a1,28(s6)
80001dd8:	00a12423          	sw	a0,8(sp)
80001ddc:	00b12623          	sw	a1,12(sp)
80001de0:	01710513          	addi	a0,sp,23
80001de4:	00a12823          	sw	a0,16(sp)
80001de8:	000b2503          	lw	a0,0(s6)
80001dec:	004b2583          	lw	a1,4(s6)
80001df0:	020b0603          	lb	a2,32(s6)
80001df4:	008b2683          	lw	a3,8(s6)
80001df8:	00cb2703          	lw	a4,12(s6)
80001dfc:	010b2783          	lw	a5,16(s6)
80001e00:	014b2803          	lw	a6,20(s6)
80001e04:	00a12c23          	sw	a0,24(sp)
80001e08:	00b12e23          	sw	a1,28(sp)
80001e0c:	02c10c23          	sb	a2,56(sp)
80001e10:	02d12023          	sw	a3,32(sp)
80001e14:	02e12223          	sw	a4,36(sp)
80001e18:	02f12423          	sw	a5,40(sp)
80001e1c:	03012623          	sw	a6,44(sp)
80001e20:	00810513          	addi	a0,sp,8
80001e24:	02a12823          	sw	a0,48(sp)
80001e28:	80005537          	lui	a0,0x80005
80001e2c:	b9450513          	addi	a0,a0,-1132 # 80004b94 <ebss+0xffffdb94>
80001e30:	02a12a23          	sw	a0,52(sp)
80001e34:	00810513          	addi	a0,sp,8
80001e38:	000a8593          	mv	a1,s5
80001e3c:	000a0613          	mv	a2,s4
80001e40:	00000097          	auipc	ra,0x0
80001e44:	bc4080e7          	jalr	-1084(ra) # 80001a04 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E>
80001e48:	ee0514e3          	bnez	a0,80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>
80001e4c:	80005537          	lui	a0,0x80005
80001e50:	b8150593          	addi	a1,a0,-1151 # 80004b81 <ebss+0xffffdb81>
80001e54:	00810513          	addi	a0,sp,8
80001e58:	00200613          	li	a2,2
80001e5c:	00000097          	auipc	ra,0x0
80001e60:	ba8080e7          	jalr	-1112(ra) # 80001a04 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E>
80001e64:	ec0516e3          	bnez	a0,80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>
80001e68:	00c9a603          	lw	a2,12(s3)
80001e6c:	01810593          	addi	a1,sp,24
80001e70:	00090513          	mv	a0,s2
80001e74:	000600e7          	jalr	a2
80001e78:	ea051ce3          	bnez	a0,80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>
80001e7c:	03412583          	lw	a1,52(sp)
80001e80:	03012503          	lw	a0,48(sp)
80001e84:	00c5a683          	lw	a3,12(a1)
80001e88:	800055b7          	lui	a1,0x80005
80001e8c:	bcf58593          	addi	a1,a1,-1073 # 80004bcf <ebss+0xffffdbcf>
80001e90:	00200613          	li	a2,2
80001e94:	000680e7          	jalr	a3
80001e98:	07c0006f          	j	80001f14 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x220>
80001e9c:	80005537          	lui	a0,0x80005
80001ea0:	bd350593          	addi	a1,a0,-1069 # 80004bd3 <ebss+0xffffdbd3>
80001ea4:	01cb2683          	lw	a3,28(s6)
80001ea8:	018b2503          	lw	a0,24(s6)
80001eac:	00c6a683          	lw	a3,12(a3)
80001eb0:	00266613          	ori	a2,a2,2
80001eb4:	000680e7          	jalr	a3
80001eb8:	00100493          	li	s1,1
80001ebc:	e6051ae3          	bnez	a0,80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>
80001ec0:	01cb2583          	lw	a1,28(s6)
80001ec4:	018b2503          	lw	a0,24(s6)
80001ec8:	00c5a683          	lw	a3,12(a1)
80001ecc:	000a8593          	mv	a1,s5
80001ed0:	000a0613          	mv	a2,s4
80001ed4:	000680e7          	jalr	a3
80001ed8:	00100493          	li	s1,1
80001edc:	e4051ae3          	bnez	a0,80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>
80001ee0:	01cb2583          	lw	a1,28(s6)
80001ee4:	018b2503          	lw	a0,24(s6)
80001ee8:	00c5a683          	lw	a3,12(a1)
80001eec:	800055b7          	lui	a1,0x80005
80001ef0:	b8158593          	addi	a1,a1,-1151 # 80004b81 <ebss+0xffffdb81>
80001ef4:	00200613          	li	a2,2
80001ef8:	000680e7          	jalr	a3
80001efc:	00100493          	li	s1,1
80001f00:	e20518e3          	bnez	a0,80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>
80001f04:	00c9a603          	lw	a2,12(s3)
80001f08:	00090513          	mv	a0,s2
80001f0c:	000b0593          	mv	a1,s6
80001f10:	000600e7          	jalr	a2
80001f14:	00050493          	mv	s1,a0
80001f18:	e19ff06f          	j	80001d30 <_ZN4core3fmt8builders11DebugStruct5field17h7697a2fe80185e67E+0x3c>

80001f1c <_ZN4core3fmt8builders11DebugStruct6finish17h9d7c90b72a6fed8cE>:
80001f1c:	ff010113          	addi	sp,sp,-16
80001f20:	00112623          	sw	ra,12(sp)
80001f24:	00812423          	sw	s0,8(sp)
80001f28:	00050413          	mv	s0,a0
80001f2c:	00554503          	lbu	a0,5(a0)
80001f30:	00444583          	lbu	a1,4(s0)
80001f34:	04050e63          	beqz	a0,80001f90 <_ZN4core3fmt8builders11DebugStruct6finish17h9d7c90b72a6fed8cE+0x74>
80001f38:	00100513          	li	a0,1
80001f3c:	04059663          	bnez	a1,80001f88 <_ZN4core3fmt8builders11DebugStruct6finish17h9d7c90b72a6fed8cE+0x6c>
80001f40:	00042503          	lw	a0,0(s0)
80001f44:	00054583          	lbu	a1,0(a0)
80001f48:	0045f593          	andi	a1,a1,4
80001f4c:	02059063          	bnez	a1,80001f6c <_ZN4core3fmt8builders11DebugStruct6finish17h9d7c90b72a6fed8cE+0x50>
80001f50:	01c52583          	lw	a1,28(a0)
80001f54:	01852503          	lw	a0,24(a0)
80001f58:	00c5a683          	lw	a3,12(a1)
80001f5c:	800055b7          	lui	a1,0x80005
80001f60:	bd758593          	addi	a1,a1,-1065 # 80004bd7 <ebss+0xffffdbd7>
80001f64:	00200613          	li	a2,2
80001f68:	01c0006f          	j	80001f84 <_ZN4core3fmt8builders11DebugStruct6finish17h9d7c90b72a6fed8cE+0x68>
80001f6c:	01c52583          	lw	a1,28(a0)
80001f70:	01852503          	lw	a0,24(a0)
80001f74:	00c5a683          	lw	a3,12(a1)
80001f78:	800055b7          	lui	a1,0x80005
80001f7c:	bd658593          	addi	a1,a1,-1066 # 80004bd6 <ebss+0xffffdbd6>
80001f80:	00100613          	li	a2,1
80001f84:	000680e7          	jalr	a3
80001f88:	00a40223          	sb	a0,4(s0)
80001f8c:	00050593          	mv	a1,a0
80001f90:	00b03533          	snez	a0,a1
80001f94:	00812403          	lw	s0,8(sp)
80001f98:	00c12083          	lw	ra,12(sp)
80001f9c:	01010113          	addi	sp,sp,16
80001fa0:	00008067          	ret

80001fa4 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E>:
80001fa4:	fb010113          	addi	sp,sp,-80
80001fa8:	04112623          	sw	ra,76(sp)
80001fac:	04812423          	sw	s0,72(sp)
80001fb0:	04912223          	sw	s1,68(sp)
80001fb4:	05212023          	sw	s2,64(sp)
80001fb8:	03312e23          	sw	s3,60(sp)
80001fbc:	03412c23          	sw	s4,56(sp)
80001fc0:	03512a23          	sw	s5,52(sp)
80001fc4:	00050413          	mv	s0,a0
80001fc8:	00854503          	lbu	a0,8(a0)
80001fcc:	00050863          	beqz	a0,80001fdc <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x38>
80001fd0:	00442a83          	lw	s5,4(s0)
80001fd4:	00100a13          	li	s4,1
80001fd8:	1400006f          	j	80002118 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x174>
80001fdc:	00060993          	mv	s3,a2
80001fe0:	00058913          	mv	s2,a1
80001fe4:	00042483          	lw	s1,0(s0)
80001fe8:	0004c503          	lbu	a0,0(s1)
80001fec:	00442a83          	lw	s5,4(s0)
80001ff0:	00457513          	andi	a0,a0,4
80001ff4:	001ab613          	seqz	a2,s5
80001ff8:	00051a63          	bnez	a0,8000200c <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x68>
80001ffc:	0e061063          	bnez	a2,800020dc <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x138>
80002000:	80005537          	lui	a0,0x80005
80002004:	bd150593          	addi	a1,a0,-1071 # 80004bd1 <ebss+0xffffdbd1>
80002008:	0dc0006f          	j	800020e4 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x140>
8000200c:	02060863          	beqz	a2,8000203c <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x98>
80002010:	01c4a583          	lw	a1,28(s1)
80002014:	0184a503          	lw	a0,24(s1)
80002018:	00c5a683          	lw	a3,12(a1)
8000201c:	800055b7          	lui	a1,0x80005
80002020:	bd958593          	addi	a1,a1,-1063 # 80004bd9 <ebss+0xffffdbd9>
80002024:	00200613          	li	a2,2
80002028:	000680e7          	jalr	a3
8000202c:	00050863          	beqz	a0,8000203c <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x98>
80002030:	00000a93          	li	s5,0
80002034:	00100a13          	li	s4,1
80002038:	0e00006f          	j	80002118 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x174>
8000203c:	00100a13          	li	s4,1
80002040:	014107a3          	sb	s4,15(sp)
80002044:	0184a503          	lw	a0,24(s1)
80002048:	01c4a583          	lw	a1,28(s1)
8000204c:	00a12023          	sw	a0,0(sp)
80002050:	00b12223          	sw	a1,4(sp)
80002054:	00f10513          	addi	a0,sp,15
80002058:	00a12423          	sw	a0,8(sp)
8000205c:	0004a503          	lw	a0,0(s1)
80002060:	0044a583          	lw	a1,4(s1)
80002064:	02048603          	lb	a2,32(s1)
80002068:	0084a683          	lw	a3,8(s1)
8000206c:	00c4a703          	lw	a4,12(s1)
80002070:	0104a783          	lw	a5,16(s1)
80002074:	0144a483          	lw	s1,20(s1)
80002078:	00a12823          	sw	a0,16(sp)
8000207c:	00b12a23          	sw	a1,20(sp)
80002080:	02c10823          	sb	a2,48(sp)
80002084:	00d12c23          	sw	a3,24(sp)
80002088:	00e12e23          	sw	a4,28(sp)
8000208c:	02f12023          	sw	a5,32(sp)
80002090:	02912223          	sw	s1,36(sp)
80002094:	00010513          	mv	a0,sp
80002098:	02a12423          	sw	a0,40(sp)
8000209c:	00c9a603          	lw	a2,12(s3)
800020a0:	80005537          	lui	a0,0x80005
800020a4:	b9450513          	addi	a0,a0,-1132 # 80004b94 <ebss+0xffffdb94>
800020a8:	02a12623          	sw	a0,44(sp)
800020ac:	01010593          	addi	a1,sp,16
800020b0:	00090513          	mv	a0,s2
800020b4:	000600e7          	jalr	a2
800020b8:	06051063          	bnez	a0,80002118 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x174>
800020bc:	02c12583          	lw	a1,44(sp)
800020c0:	02812503          	lw	a0,40(sp)
800020c4:	00c5a683          	lw	a3,12(a1)
800020c8:	800055b7          	lui	a1,0x80005
800020cc:	bcf58593          	addi	a1,a1,-1073 # 80004bcf <ebss+0xffffdbcf>
800020d0:	00200613          	li	a2,2
800020d4:	000680e7          	jalr	a3
800020d8:	03c0006f          	j	80002114 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x170>
800020dc:	80005537          	lui	a0,0x80005
800020e0:	bdb50593          	addi	a1,a0,-1061 # 80004bdb <ebss+0xffffdbdb>
800020e4:	01c4a683          	lw	a3,28(s1)
800020e8:	0184a503          	lw	a0,24(s1)
800020ec:	00c6a683          	lw	a3,12(a3)
800020f0:	00200713          	li	a4,2
800020f4:	40c70633          	sub	a2,a4,a2
800020f8:	000680e7          	jalr	a3
800020fc:	00100a13          	li	s4,1
80002100:	00051c63          	bnez	a0,80002118 <_ZN4core3fmt8builders10DebugTuple5field17h0b45fffe16c94051E+0x174>
80002104:	00c9a603          	lw	a2,12(s3)
80002108:	00090513          	mv	a0,s2
8000210c:	00048593          	mv	a1,s1
80002110:	000600e7          	jalr	a2
80002114:	00050a13          	mv	s4,a0
80002118:	01440423          	sb	s4,8(s0)
8000211c:	001a8513          	addi	a0,s5,1
80002120:	00a42223          	sw	a0,4(s0)
80002124:	00040513          	mv	a0,s0
80002128:	03412a83          	lw	s5,52(sp)
8000212c:	03812a03          	lw	s4,56(sp)
80002130:	03c12983          	lw	s3,60(sp)
80002134:	04012903          	lw	s2,64(sp)
80002138:	04412483          	lw	s1,68(sp)
8000213c:	04812403          	lw	s0,72(sp)
80002140:	04c12083          	lw	ra,76(sp)
80002144:	05010113          	addi	sp,sp,80
80002148:	00008067          	ret

8000214c <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE>:
8000214c:	ff010113          	addi	sp,sp,-16
80002150:	00112623          	sw	ra,12(sp)
80002154:	00812423          	sw	s0,8(sp)
80002158:	00912223          	sw	s1,4(sp)
8000215c:	00050413          	mv	s0,a0
80002160:	00452583          	lw	a1,4(a0)
80002164:	00854503          	lbu	a0,8(a0)
80002168:	06058e63          	beqz	a1,800021e4 <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE+0x98>
8000216c:	00100493          	li	s1,1
80002170:	06051663          	bnez	a0,800021dc <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE+0x90>
80002174:	00100513          	li	a0,1
80002178:	04a59063          	bne	a1,a0,800021b8 <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE+0x6c>
8000217c:	00944503          	lbu	a0,9(s0)
80002180:	02050c63          	beqz	a0,800021b8 <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE+0x6c>
80002184:	00042503          	lw	a0,0(s0)
80002188:	00054583          	lbu	a1,0(a0)
8000218c:	0045f593          	andi	a1,a1,4
80002190:	02059463          	bnez	a1,800021b8 <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE+0x6c>
80002194:	01c52583          	lw	a1,28(a0)
80002198:	01852503          	lw	a0,24(a0)
8000219c:	00c5a683          	lw	a3,12(a1)
800021a0:	800055b7          	lui	a1,0x80005
800021a4:	bdc58593          	addi	a1,a1,-1060 # 80004bdc <ebss+0xffffdbdc>
800021a8:	00100613          	li	a2,1
800021ac:	00100493          	li	s1,1
800021b0:	000680e7          	jalr	a3
800021b4:	02051463          	bnez	a0,800021dc <_ZN4core3fmt8builders10DebugTuple6finish17hc28bf68716dc095bE+0x90>
800021b8:	00042503          	lw	a0,0(s0)
800021bc:	01c52583          	lw	a1,28(a0)
800021c0:	01852503          	lw	a0,24(a0)
800021c4:	00c5a683          	lw	a3,12(a1)
800021c8:	800055b7          	lui	a1,0x80005
800021cc:	bdd58593          	addi	a1,a1,-1059 # 80004bdd <ebss+0xffffdbdd>
800021d0:	00100613          	li	a2,1
800021d4:	000680e7          	jalr	a3
800021d8:	00050493          	mv	s1,a0
800021dc:	00940423          	sb	s1,8(s0)
800021e0:	00048513          	mv	a0,s1
800021e4:	00a03533          	snez	a0,a0
800021e8:	00412483          	lw	s1,4(sp)
800021ec:	00812403          	lw	s0,8(sp)
800021f0:	00c12083          	lw	ra,12(sp)
800021f4:	01010113          	addi	sp,sp,16
800021f8:	00008067          	ret

800021fc <_ZN4core3fmt5Write10write_char17ha18b9cb6c85dbb5eE>:
800021fc:	ff010113          	addi	sp,sp,-16
80002200:	00112623          	sw	ra,12(sp)
80002204:	08000613          	li	a2,128
80002208:	00012423          	sw	zero,8(sp)
8000220c:	00c5f863          	bgeu	a1,a2,8000221c <_ZN4core3fmt5Write10write_char17ha18b9cb6c85dbb5eE+0x20>
80002210:	00b10423          	sb	a1,8(sp)
80002214:	00100613          	li	a2,1
80002218:	0a00006f          	j	800022b8 <_ZN4core3fmt5Write10write_char17ha18b9cb6c85dbb5eE+0xbc>
8000221c:	00b5d613          	srli	a2,a1,0xb
80002220:	02061263          	bnez	a2,80002244 <_ZN4core3fmt5Write10write_char17ha18b9cb6c85dbb5eE+0x48>
80002224:	0065d613          	srli	a2,a1,0x6
80002228:	0c066613          	ori	a2,a2,192
8000222c:	00c10423          	sb	a2,8(sp)
80002230:	03f5f593          	andi	a1,a1,63
80002234:	0805e593          	ori	a1,a1,128
80002238:	00b104a3          	sb	a1,9(sp)
8000223c:	00200613          	li	a2,2
80002240:	0780006f          	j	800022b8 <_ZN4core3fmt5Write10write_char17ha18b9cb6c85dbb5eE+0xbc>
80002244:	0105d613          	srli	a2,a1,0x10
80002248:	02061a63          	bnez	a2,8000227c <_ZN4core3fmt5Write10write_char17ha18b9cb6c85dbb5eE+0x80>
8000224c:	00c5d613          	srli	a2,a1,0xc
80002250:	0e066613          	ori	a2,a2,224
80002254:	00c10423          	sb	a2,8(sp)
80002258:	0065d613          	srli	a2,a1,0x6
8000225c:	03f67613          	andi	a2,a2,63
80002260:	08066613          	ori	a2,a2,128
80002264:	00c104a3          	sb	a2,9(sp)
80002268:	03f5f593          	andi	a1,a1,63
8000226c:	0805e593          	ori	a1,a1,128
80002270:	00b10523          	sb	a1,10(sp)
80002274:	00300613          	li	a2,3
80002278:	0400006f          	j	800022b8 <_ZN4core3fmt5Write10write_char17ha18b9cb6c85dbb5eE+0xbc>
8000227c:	0125d613          	srli	a2,a1,0x12
80002280:	0f066613          	ori	a2,a2,240
80002284:	00c10423          	sb	a2,8(sp)
80002288:	00c5d613          	srli	a2,a1,0xc
8000228c:	03f67613          	andi	a2,a2,63
80002290:	08066613          	ori	a2,a2,128
80002294:	00c104a3          	sb	a2,9(sp)
80002298:	0065d613          	srli	a2,a1,0x6
8000229c:	03f67613          	andi	a2,a2,63
800022a0:	08066613          	ori	a2,a2,128
800022a4:	00c10523          	sb	a2,10(sp)
800022a8:	03f5f593          	andi	a1,a1,63
800022ac:	0805e593          	ori	a1,a1,128
800022b0:	00b105a3          	sb	a1,11(sp)
800022b4:	00400613          	li	a2,4
800022b8:	00810593          	addi	a1,sp,8
800022bc:	fffff097          	auipc	ra,0xfffff
800022c0:	748080e7          	jalr	1864(ra) # 80001a04 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E>
800022c4:	00c12083          	lw	ra,12(sp)
800022c8:	01010113          	addi	sp,sp,16
800022cc:	00008067          	ret

800022d0 <_ZN4core3fmt5Write9write_fmt17hed37d0f03a379d8eE>:
800022d0:	fd010113          	addi	sp,sp,-48
800022d4:	02112623          	sw	ra,44(sp)
800022d8:	0145a603          	lw	a2,20(a1)
800022dc:	0105a683          	lw	a3,16(a1)
800022e0:	00a12623          	sw	a0,12(sp)
800022e4:	02c12223          	sw	a2,36(sp)
800022e8:	02d12023          	sw	a3,32(sp)
800022ec:	00c5a503          	lw	a0,12(a1)
800022f0:	0085a603          	lw	a2,8(a1)
800022f4:	0045a683          	lw	a3,4(a1)
800022f8:	0005a583          	lw	a1,0(a1)
800022fc:	00a12e23          	sw	a0,28(sp)
80002300:	00c12c23          	sw	a2,24(sp)
80002304:	00d12a23          	sw	a3,20(sp)
80002308:	00b12823          	sw	a1,16(sp)
8000230c:	80005537          	lui	a0,0x80005
80002310:	cd850593          	addi	a1,a0,-808 # 80004cd8 <ebss+0xffffdcd8>
80002314:	00c10513          	addi	a0,sp,12
80002318:	01010613          	addi	a2,sp,16
8000231c:	00000097          	auipc	ra,0x0
80002320:	1b8080e7          	jalr	440(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
80002324:	02c12083          	lw	ra,44(sp)
80002328:	03010113          	addi	sp,sp,48
8000232c:	00008067          	ret

80002330 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_str17h6891ba049a4b993bE>:
80002330:	00052503          	lw	a0,0(a0)
80002334:	fffff317          	auipc	t1,0xfffff
80002338:	6d030067          	jr	1744(t1) # 80001a04 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E>

8000233c <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17ha2e65ad0b269bfb9E>:
8000233c:	ff010113          	addi	sp,sp,-16
80002340:	00112623          	sw	ra,12(sp)
80002344:	00052503          	lw	a0,0(a0)
80002348:	08000613          	li	a2,128
8000234c:	00012423          	sw	zero,8(sp)
80002350:	00c5f863          	bgeu	a1,a2,80002360 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17ha2e65ad0b269bfb9E+0x24>
80002354:	00b10423          	sb	a1,8(sp)
80002358:	00100613          	li	a2,1
8000235c:	0a00006f          	j	800023fc <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17ha2e65ad0b269bfb9E+0xc0>
80002360:	00b5d613          	srli	a2,a1,0xb
80002364:	02061263          	bnez	a2,80002388 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17ha2e65ad0b269bfb9E+0x4c>
80002368:	0065d613          	srli	a2,a1,0x6
8000236c:	0c066613          	ori	a2,a2,192
80002370:	00c10423          	sb	a2,8(sp)
80002374:	03f5f593          	andi	a1,a1,63
80002378:	0805e593          	ori	a1,a1,128
8000237c:	00b104a3          	sb	a1,9(sp)
80002380:	00200613          	li	a2,2
80002384:	0780006f          	j	800023fc <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17ha2e65ad0b269bfb9E+0xc0>
80002388:	0105d613          	srli	a2,a1,0x10
8000238c:	02061a63          	bnez	a2,800023c0 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17ha2e65ad0b269bfb9E+0x84>
80002390:	00c5d613          	srli	a2,a1,0xc
80002394:	0e066613          	ori	a2,a2,224
80002398:	00c10423          	sb	a2,8(sp)
8000239c:	0065d613          	srli	a2,a1,0x6
800023a0:	03f67613          	andi	a2,a2,63
800023a4:	08066613          	ori	a2,a2,128
800023a8:	00c104a3          	sb	a2,9(sp)
800023ac:	03f5f593          	andi	a1,a1,63
800023b0:	0805e593          	ori	a1,a1,128
800023b4:	00b10523          	sb	a1,10(sp)
800023b8:	00300613          	li	a2,3
800023bc:	0400006f          	j	800023fc <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$10write_char17ha2e65ad0b269bfb9E+0xc0>
800023c0:	0125d613          	srli	a2,a1,0x12
800023c4:	0f066613          	ori	a2,a2,240
800023c8:	00c10423          	sb	a2,8(sp)
800023cc:	00c5d613          	srli	a2,a1,0xc
800023d0:	03f67613          	andi	a2,a2,63
800023d4:	08066613          	ori	a2,a2,128
800023d8:	00c104a3          	sb	a2,9(sp)
800023dc:	0065d613          	srli	a2,a1,0x6
800023e0:	03f67613          	andi	a2,a2,63
800023e4:	08066613          	ori	a2,a2,128
800023e8:	00c10523          	sb	a2,10(sp)
800023ec:	03f5f593          	andi	a1,a1,63
800023f0:	0805e593          	ori	a1,a1,128
800023f4:	00b105a3          	sb	a1,11(sp)
800023f8:	00400613          	li	a2,4
800023fc:	00810593          	addi	a1,sp,8
80002400:	fffff097          	auipc	ra,0xfffff
80002404:	604080e7          	jalr	1540(ra) # 80001a04 <_ZN68_$LT$core..fmt..builders..PadAdapter$u20$as$u20$core..fmt..Write$GT$9write_str17ha8073eedd5c27227E>
80002408:	00c12083          	lw	ra,12(sp)
8000240c:	01010113          	addi	sp,sp,16
80002410:	00008067          	ret

80002414 <_ZN50_$LT$$RF$mut$u20$W$u20$as$u20$core..fmt..Write$GT$9write_fmt17h6728f54ab925edbdE>:
80002414:	fd010113          	addi	sp,sp,-48
80002418:	02112623          	sw	ra,44(sp)
8000241c:	00052503          	lw	a0,0(a0)
80002420:	0145a603          	lw	a2,20(a1)
80002424:	0105a683          	lw	a3,16(a1)
80002428:	00a12623          	sw	a0,12(sp)
8000242c:	02c12223          	sw	a2,36(sp)
80002430:	02d12023          	sw	a3,32(sp)
80002434:	00c5a503          	lw	a0,12(a1)
80002438:	0085a603          	lw	a2,8(a1)
8000243c:	0045a683          	lw	a3,4(a1)
80002440:	0005a583          	lw	a1,0(a1)
80002444:	00a12e23          	sw	a0,28(sp)
80002448:	00c12c23          	sw	a2,24(sp)
8000244c:	00d12a23          	sw	a3,20(sp)
80002450:	00b12823          	sw	a1,16(sp)
80002454:	80005537          	lui	a0,0x80005
80002458:	cd850593          	addi	a1,a0,-808 # 80004cd8 <ebss+0xffffdcd8>
8000245c:	00c10513          	addi	a0,sp,12
80002460:	01010613          	addi	a2,sp,16
80002464:	00000097          	auipc	ra,0x0
80002468:	070080e7          	jalr	112(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
8000246c:	02c12083          	lw	ra,44(sp)
80002470:	03010113          	addi	sp,sp,48
80002474:	00008067          	ret

80002478 <_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h312b562e7c6fea87E>:
80002478:	fe010113          	addi	sp,sp,-32
8000247c:	00112e23          	sw	ra,28(sp)
80002480:	01452603          	lw	a2,20(a0)
80002484:	01052703          	lw	a4,16(a0)
80002488:	00c52783          	lw	a5,12(a0)
8000248c:	00c12a23          	sw	a2,20(sp)
80002490:	0185a683          	lw	a3,24(a1)
80002494:	00e12823          	sw	a4,16(sp)
80002498:	00f12623          	sw	a5,12(sp)
8000249c:	00852603          	lw	a2,8(a0)
800024a0:	00452703          	lw	a4,4(a0)
800024a4:	00052503          	lw	a0,0(a0)
800024a8:	01c5a583          	lw	a1,28(a1)
800024ac:	00c12423          	sw	a2,8(sp)
800024b0:	00e12223          	sw	a4,4(sp)
800024b4:	00a12023          	sw	a0,0(sp)
800024b8:	00010613          	mv	a2,sp
800024bc:	00068513          	mv	a0,a3
800024c0:	00000097          	auipc	ra,0x0
800024c4:	014080e7          	jalr	20(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
800024c8:	01c12083          	lw	ra,28(sp)
800024cc:	02010113          	addi	sp,sp,32
800024d0:	00008067          	ret

800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>:
800024d4:	fb010113          	addi	sp,sp,-80
800024d8:	04112623          	sw	ra,76(sp)
800024dc:	04812423          	sw	s0,72(sp)
800024e0:	04912223          	sw	s1,68(sp)
800024e4:	05212023          	sw	s2,64(sp)
800024e8:	03312e23          	sw	s3,60(sp)
800024ec:	03412c23          	sw	s4,56(sp)
800024f0:	03512a23          	sw	s5,52(sp)
800024f4:	03612823          	sw	s6,48(sp)
800024f8:	00060993          	mv	s3,a2
800024fc:	00012423          	sw	zero,8(sp)
80002500:	02000613          	li	a2,32
80002504:	00c12623          	sw	a2,12(sp)
80002508:	00300613          	li	a2,3
8000250c:	02c10423          	sb	a2,40(sp)
80002510:	0089a603          	lw	a2,8(s3)
80002514:	00012823          	sw	zero,16(sp)
80002518:	00012c23          	sw	zero,24(sp)
8000251c:	02a12023          	sw	a0,32(sp)
80002520:	02b12223          	sw	a1,36(sp)
80002524:	12060263          	beqz	a2,80002648 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x174>
80002528:	00c9a503          	lw	a0,12(s3)
8000252c:	18050863          	beqz	a0,800026bc <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x1e8>
80002530:	0009a583          	lw	a1,0(s3)
80002534:	00551a13          	slli	s4,a0,0x5
80002538:	fe0a0513          	addi	a0,s4,-32
8000253c:	00555513          	srli	a0,a0,0x5
80002540:	00150913          	addi	s2,a0,1
80002544:	00458413          	addi	s0,a1,4
80002548:	01060493          	addi	s1,a2,16
8000254c:	00100a93          	li	s5,1
80002550:	80001537          	lui	a0,0x80001
80002554:	66850b13          	addi	s6,a0,1640 # 80001668 <ebss+0xffffa668>
80002558:	00042603          	lw	a2,0(s0)
8000255c:	00060e63          	beqz	a2,80002578 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0xa4>
80002560:	02412683          	lw	a3,36(sp)
80002564:	02012503          	lw	a0,32(sp)
80002568:	ffc42583          	lw	a1,-4(s0)
8000256c:	00c6a683          	lw	a3,12(a3)
80002570:	000680e7          	jalr	a3
80002574:	18051c63          	bnez	a0,8000270c <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x238>
80002578:	ff44a503          	lw	a0,-12(s1)
8000257c:	00a12623          	sw	a0,12(sp)
80002580:	00c48503          	lb	a0,12(s1)
80002584:	02a10423          	sb	a0,40(sp)
80002588:	ff84a583          	lw	a1,-8(s1)
8000258c:	0109a503          	lw	a0,16(s3)
80002590:	00b12423          	sw	a1,8(sp)
80002594:	0044a683          	lw	a3,4(s1)
80002598:	0084a583          	lw	a1,8(s1)
8000259c:	02068663          	beqz	a3,800025c8 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0xf4>
800025a0:	00000613          	li	a2,0
800025a4:	03569463          	bne	a3,s5,800025cc <_ZN4core3fmt5write17hc9cc6c7de730469dE+0xf8>
800025a8:	00359593          	slli	a1,a1,0x3
800025ac:	00b505b3          	add	a1,a0,a1
800025b0:	0045a603          	lw	a2,4(a1)
800025b4:	01660663          	beq	a2,s6,800025c0 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0xec>
800025b8:	00000613          	li	a2,0
800025bc:	0100006f          	j	800025cc <_ZN4core3fmt5write17hc9cc6c7de730469dE+0xf8>
800025c0:	0005a583          	lw	a1,0(a1)
800025c4:	0005a583          	lw	a1,0(a1)
800025c8:	00100613          	li	a2,1
800025cc:	00c12823          	sw	a2,16(sp)
800025d0:	00b12a23          	sw	a1,20(sp)
800025d4:	ffc4a683          	lw	a3,-4(s1)
800025d8:	0004a583          	lw	a1,0(s1)
800025dc:	02068663          	beqz	a3,80002608 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x134>
800025e0:	00000613          	li	a2,0
800025e4:	03569463          	bne	a3,s5,8000260c <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x138>
800025e8:	00359593          	slli	a1,a1,0x3
800025ec:	00b505b3          	add	a1,a0,a1
800025f0:	0045a603          	lw	a2,4(a1)
800025f4:	01660663          	beq	a2,s6,80002600 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x12c>
800025f8:	00000613          	li	a2,0
800025fc:	0100006f          	j	8000260c <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x138>
80002600:	0005a583          	lw	a1,0(a1)
80002604:	0005a583          	lw	a1,0(a1)
80002608:	00100613          	li	a2,1
8000260c:	00c12c23          	sw	a2,24(sp)
80002610:	00b12e23          	sw	a1,28(sp)
80002614:	ff04a583          	lw	a1,-16(s1)
80002618:	00359593          	slli	a1,a1,0x3
8000261c:	00b50533          	add	a0,a0,a1
80002620:	00452603          	lw	a2,4(a0)
80002624:	00052503          	lw	a0,0(a0)
80002628:	00810593          	addi	a1,sp,8
8000262c:	000600e7          	jalr	a2
80002630:	0c051e63          	bnez	a0,8000270c <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x238>
80002634:	00840413          	addi	s0,s0,8
80002638:	fe0a0a13          	addi	s4,s4,-32
8000263c:	02048493          	addi	s1,s1,32
80002640:	f00a1ce3          	bnez	s4,80002558 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x84>
80002644:	07c0006f          	j	800026c0 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x1ec>
80002648:	0149a503          	lw	a0,20(s3)
8000264c:	08050463          	beqz	a0,800026d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x200>
80002650:	0109a583          	lw	a1,16(s3)
80002654:	0009a603          	lw	a2,0(s3)
80002658:	00351513          	slli	a0,a0,0x3
8000265c:	ff850513          	addi	a0,a0,-8
80002660:	00355513          	srli	a0,a0,0x3
80002664:	00150913          	addi	s2,a0,1
80002668:	00460413          	addi	s0,a2,4
8000266c:	00458493          	addi	s1,a1,4
80002670:	00090a13          	mv	s4,s2
80002674:	00042603          	lw	a2,0(s0)
80002678:	00060e63          	beqz	a2,80002694 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x1c0>
8000267c:	02412683          	lw	a3,36(sp)
80002680:	02012503          	lw	a0,32(sp)
80002684:	ffc42583          	lw	a1,-4(s0)
80002688:	00c6a683          	lw	a3,12(a3)
8000268c:	000680e7          	jalr	a3
80002690:	06051e63          	bnez	a0,8000270c <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x238>
80002694:	0004a603          	lw	a2,0(s1)
80002698:	ffc4a503          	lw	a0,-4(s1)
8000269c:	00810593          	addi	a1,sp,8
800026a0:	000600e7          	jalr	a2
800026a4:	06051463          	bnez	a0,8000270c <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x238>
800026a8:	fffa0a13          	addi	s4,s4,-1
800026ac:	00840413          	addi	s0,s0,8
800026b0:	00848493          	addi	s1,s1,8
800026b4:	fc0a10e3          	bnez	s4,80002674 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x1a0>
800026b8:	0080006f          	j	800026c0 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x1ec>
800026bc:	00000913          	li	s2,0
800026c0:	0049a503          	lw	a0,4(s3)
800026c4:	00a96e63          	bltu	s2,a0,800026e0 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x20c>
800026c8:	00000613          	li	a2,0
800026cc:	02a96263          	bltu	s2,a0,800026f0 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x21c>
800026d0:	0440006f          	j	80002714 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x240>
800026d4:	00000913          	li	s2,0
800026d8:	0049a503          	lw	a0,4(s3)
800026dc:	fea976e3          	bgeu	s2,a0,800026c8 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x1f4>
800026e0:	0009a583          	lw	a1,0(s3)
800026e4:	00391613          	slli	a2,s2,0x3
800026e8:	00c58633          	add	a2,a1,a2
800026ec:	02a97463          	bgeu	s2,a0,80002714 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x240>
800026f0:	02412683          	lw	a3,36(sp)
800026f4:	02012503          	lw	a0,32(sp)
800026f8:	00062583          	lw	a1,0(a2)
800026fc:	00462603          	lw	a2,4(a2)
80002700:	00c6a683          	lw	a3,12(a3)
80002704:	000680e7          	jalr	a3
80002708:	00050663          	beqz	a0,80002714 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x240>
8000270c:	00100513          	li	a0,1
80002710:	0080006f          	j	80002718 <_ZN4core3fmt5write17hc9cc6c7de730469dE+0x244>
80002714:	00000513          	li	a0,0
80002718:	03012b03          	lw	s6,48(sp)
8000271c:	03412a83          	lw	s5,52(sp)
80002720:	03812a03          	lw	s4,56(sp)
80002724:	03c12983          	lw	s3,60(sp)
80002728:	04012903          	lw	s2,64(sp)
8000272c:	04412483          	lw	s1,68(sp)
80002730:	04812403          	lw	s0,72(sp)
80002734:	04c12083          	lw	ra,76(sp)
80002738:	05010113          	addi	sp,sp,80
8000273c:	00008067          	ret

80002740 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE>:
80002740:	fd010113          	addi	sp,sp,-48
80002744:	02112623          	sw	ra,44(sp)
80002748:	02812423          	sw	s0,40(sp)
8000274c:	02912223          	sw	s1,36(sp)
80002750:	03212023          	sw	s2,32(sp)
80002754:	01312e23          	sw	s3,28(sp)
80002758:	01412c23          	sw	s4,24(sp)
8000275c:	01512a23          	sw	s5,20(sp)
80002760:	01612823          	sw	s6,16(sp)
80002764:	01712623          	sw	s7,12(sp)
80002768:	01812423          	sw	s8,8(sp)
8000276c:	01912223          	sw	s9,4(sp)
80002770:	01a12023          	sw	s10,0(sp)
80002774:	00078993          	mv	s3,a5
80002778:	00070913          	mv	s2,a4
8000277c:	00068b13          	mv	s6,a3
80002780:	00050b93          	mv	s7,a0
80002784:	06058263          	beqz	a1,800027e8 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0xa8>
80002788:	000ba503          	lw	a0,0(s7)
8000278c:	00157593          	andi	a1,a0,1
80002790:	00110a37          	lui	s4,0x110
80002794:	00058463          	beqz	a1,8000279c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x5c>
80002798:	02b00a13          	li	s4,43
8000279c:	01358433          	add	s0,a1,s3
800027a0:	00457593          	andi	a1,a0,4
800027a4:	04058c63          	beqz	a1,800027fc <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0xbc>
800027a8:	00000593          	li	a1,0
800027ac:	020b0463          	beqz	s6,800027d4 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x94>
800027b0:	fbf00693          	li	a3,-65
800027b4:	000b0713          	mv	a4,s6
800027b8:	00060793          	mv	a5,a2
800027bc:	00078483          	lb	s1,0(a5)
800027c0:	00178793          	addi	a5,a5,1
800027c4:	0096a4b3          	slt	s1,a3,s1
800027c8:	fff70713          	addi	a4,a4,-1
800027cc:	009585b3          	add	a1,a1,s1
800027d0:	fe0716e3          	bnez	a4,800027bc <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x7c>
800027d4:	00858433          	add	s0,a1,s0
800027d8:	00060c13          	mv	s8,a2
800027dc:	008ba583          	lw	a1,8(s7)
800027e0:	02059463          	bnez	a1,80002808 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0xc8>
800027e4:	0640006f          	j	80002848 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x108>
800027e8:	000ba503          	lw	a0,0(s7)
800027ec:	00198413          	addi	s0,s3,1
800027f0:	02d00a13          	li	s4,45
800027f4:	00457593          	andi	a1,a0,4
800027f8:	fa0598e3          	bnez	a1,800027a8 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x68>
800027fc:	00000c13          	li	s8,0
80002800:	008ba583          	lw	a1,8(s7)
80002804:	04058263          	beqz	a1,80002848 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x108>
80002808:	00cba483          	lw	s1,12(s7)
8000280c:	02947e63          	bgeu	s0,s1,80002848 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x108>
80002810:	00857513          	andi	a0,a0,8
80002814:	0c051e63          	bnez	a0,800028f0 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x1b0>
80002818:	020bc583          	lbu	a1,32(s7)
8000281c:	00300613          	li	a2,3
80002820:	00100513          	li	a0,1
80002824:	00c58463          	beq	a1,a2,8000282c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0xec>
80002828:	00058513          	mv	a0,a1
8000282c:	00357593          	andi	a1,a0,3
80002830:	40848533          	sub	a0,s1,s0
80002834:	12058063          	beqz	a1,80002954 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x214>
80002838:	00100613          	li	a2,1
8000283c:	12c59263          	bne	a1,a2,80002960 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x220>
80002840:	00000c93          	li	s9,0
80002844:	1280006f          	j	8000296c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x22c>
80002848:	000b8513          	mv	a0,s7
8000284c:	000a0593          	mv	a1,s4
80002850:	000c0613          	mv	a2,s8
80002854:	000b0693          	mv	a3,s6
80002858:	00000097          	auipc	ra,0x0
8000285c:	278080e7          	jalr	632(ra) # 80002ad0 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h47ce8d6cfd4a1e8fE>
80002860:	00100a93          	li	s5,1
80002864:	04050063          	beqz	a0,800028a4 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x164>
80002868:	000a8513          	mv	a0,s5
8000286c:	00012d03          	lw	s10,0(sp)
80002870:	00412c83          	lw	s9,4(sp)
80002874:	00812c03          	lw	s8,8(sp)
80002878:	00c12b83          	lw	s7,12(sp)
8000287c:	01012b03          	lw	s6,16(sp)
80002880:	01412a83          	lw	s5,20(sp)
80002884:	01812a03          	lw	s4,24(sp)
80002888:	01c12983          	lw	s3,28(sp)
8000288c:	02012903          	lw	s2,32(sp)
80002890:	02412483          	lw	s1,36(sp)
80002894:	02812403          	lw	s0,40(sp)
80002898:	02c12083          	lw	ra,44(sp)
8000289c:	03010113          	addi	sp,sp,48
800028a0:	00008067          	ret
800028a4:	01cba583          	lw	a1,28(s7)
800028a8:	018ba503          	lw	a0,24(s7)
800028ac:	00c5a783          	lw	a5,12(a1)
800028b0:	00090593          	mv	a1,s2
800028b4:	00098613          	mv	a2,s3
800028b8:	00012d03          	lw	s10,0(sp)
800028bc:	00412c83          	lw	s9,4(sp)
800028c0:	00812c03          	lw	s8,8(sp)
800028c4:	00c12b83          	lw	s7,12(sp)
800028c8:	01012b03          	lw	s6,16(sp)
800028cc:	01412a83          	lw	s5,20(sp)
800028d0:	01812a03          	lw	s4,24(sp)
800028d4:	01c12983          	lw	s3,28(sp)
800028d8:	02012903          	lw	s2,32(sp)
800028dc:	02412483          	lw	s1,36(sp)
800028e0:	02812403          	lw	s0,40(sp)
800028e4:	02c12083          	lw	ra,44(sp)
800028e8:	03010113          	addi	sp,sp,48
800028ec:	00078067          	jr	a5
800028f0:	004bac83          	lw	s9,4(s7)
800028f4:	03000513          	li	a0,48
800028f8:	020bcd03          	lbu	s10,32(s7)
800028fc:	00aba223          	sw	a0,4(s7)
80002900:	00100a93          	li	s5,1
80002904:	035b8023          	sb	s5,32(s7)
80002908:	000b8513          	mv	a0,s7
8000290c:	000a0593          	mv	a1,s4
80002910:	000c0613          	mv	a2,s8
80002914:	000b0693          	mv	a3,s6
80002918:	00000097          	auipc	ra,0x0
8000291c:	1b8080e7          	jalr	440(ra) # 80002ad0 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h47ce8d6cfd4a1e8fE>
80002920:	f40514e3          	bnez	a0,80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
80002924:	020bc583          	lbu	a1,32(s7)
80002928:	00300613          	li	a2,3
8000292c:	00100513          	li	a0,1
80002930:	00c58463          	beq	a1,a2,80002938 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x1f8>
80002934:	00058513          	mv	a0,a1
80002938:	00357593          	andi	a1,a0,3
8000293c:	40848533          	sub	a0,s1,s0
80002940:	0c058863          	beqz	a1,80002a10 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x2d0>
80002944:	00100613          	li	a2,1
80002948:	0cc59a63          	bne	a1,a2,80002a1c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x2dc>
8000294c:	00000a13          	li	s4,0
80002950:	0d80006f          	j	80002a28 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x2e8>
80002954:	00050c93          	mv	s9,a0
80002958:	00000513          	li	a0,0
8000295c:	0100006f          	j	8000296c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x22c>
80002960:	00150593          	addi	a1,a0,1
80002964:	00155513          	srli	a0,a0,0x1
80002968:	0015dc93          	srli	s9,a1,0x1
8000296c:	018baa83          	lw	s5,24(s7)
80002970:	01cba403          	lw	s0,28(s7)
80002974:	004bad03          	lw	s10,4(s7)
80002978:	00150493          	addi	s1,a0,1
8000297c:	fff48493          	addi	s1,s1,-1
80002980:	00048e63          	beqz	s1,8000299c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x25c>
80002984:	01042603          	lw	a2,16(s0)
80002988:	000a8513          	mv	a0,s5
8000298c:	000d0593          	mv	a1,s10
80002990:	000600e7          	jalr	a2
80002994:	fe0504e3          	beqz	a0,8000297c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x23c>
80002998:	0bc0006f          	j	80002a54 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x314>
8000299c:	00110537          	lui	a0,0x110
800029a0:	00100a93          	li	s5,1
800029a4:	ecad02e3          	beq	s10,a0,80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
800029a8:	000b8513          	mv	a0,s7
800029ac:	000a0593          	mv	a1,s4
800029b0:	000c0613          	mv	a2,s8
800029b4:	000b0693          	mv	a3,s6
800029b8:	00000097          	auipc	ra,0x0
800029bc:	118080e7          	jalr	280(ra) # 80002ad0 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h47ce8d6cfd4a1e8fE>
800029c0:	ea0514e3          	bnez	a0,80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
800029c4:	01cba583          	lw	a1,28(s7)
800029c8:	018ba503          	lw	a0,24(s7)
800029cc:	00c5a683          	lw	a3,12(a1)
800029d0:	00090593          	mv	a1,s2
800029d4:	00098613          	mv	a2,s3
800029d8:	000680e7          	jalr	a3
800029dc:	e80516e3          	bnez	a0,80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
800029e0:	018ba903          	lw	s2,24(s7)
800029e4:	01cba403          	lw	s0,28(s7)
800029e8:	00000493          	li	s1,0
800029ec:	0c9c8c63          	beq	s9,s1,80002ac4 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x384>
800029f0:	01042603          	lw	a2,16(s0)
800029f4:	00148493          	addi	s1,s1,1
800029f8:	00090513          	mv	a0,s2
800029fc:	000d0593          	mv	a1,s10
80002a00:	000600e7          	jalr	a2
80002a04:	fe0504e3          	beqz	a0,800029ec <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x2ac>
80002a08:	fff48513          	addi	a0,s1,-1
80002a0c:	0bc0006f          	j	80002ac8 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x388>
80002a10:	00050a13          	mv	s4,a0
80002a14:	00000513          	li	a0,0
80002a18:	0100006f          	j	80002a28 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x2e8>
80002a1c:	00150593          	addi	a1,a0,1 # 110001 <.Lline_table_start0+0xe566e>
80002a20:	00155513          	srli	a0,a0,0x1
80002a24:	0015da13          	srli	s4,a1,0x1
80002a28:	018baa83          	lw	s5,24(s7)
80002a2c:	01cba403          	lw	s0,28(s7)
80002a30:	004bab03          	lw	s6,4(s7)
80002a34:	00150493          	addi	s1,a0,1
80002a38:	fff48493          	addi	s1,s1,-1
80002a3c:	02048063          	beqz	s1,80002a5c <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x31c>
80002a40:	01042603          	lw	a2,16(s0)
80002a44:	000a8513          	mv	a0,s5
80002a48:	000b0593          	mv	a1,s6
80002a4c:	000600e7          	jalr	a2
80002a50:	fe0504e3          	beqz	a0,80002a38 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x2f8>
80002a54:	00100a93          	li	s5,1
80002a58:	e11ff06f          	j	80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
80002a5c:	00110537          	lui	a0,0x110
80002a60:	00100a93          	li	s5,1
80002a64:	e0ab02e3          	beq	s6,a0,80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
80002a68:	01cba583          	lw	a1,28(s7)
80002a6c:	018ba503          	lw	a0,24(s7)
80002a70:	00c5a683          	lw	a3,12(a1)
80002a74:	00090593          	mv	a1,s2
80002a78:	00098613          	mv	a2,s3
80002a7c:	000680e7          	jalr	a3
80002a80:	de0514e3          	bnez	a0,80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
80002a84:	018ba903          	lw	s2,24(s7)
80002a88:	01cba403          	lw	s0,28(s7)
80002a8c:	00000493          	li	s1,0
80002a90:	029a0263          	beq	s4,s1,80002ab4 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x374>
80002a94:	01042603          	lw	a2,16(s0)
80002a98:	00148493          	addi	s1,s1,1
80002a9c:	00090513          	mv	a0,s2
80002aa0:	000b0593          	mv	a1,s6
80002aa4:	000600e7          	jalr	a2
80002aa8:	fe0504e3          	beqz	a0,80002a90 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x350>
80002aac:	fff48513          	addi	a0,s1,-1
80002ab0:	db456ce3          	bltu	a0,s4,80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
80002ab4:	00000a93          	li	s5,0
80002ab8:	019ba223          	sw	s9,4(s7)
80002abc:	03ab8023          	sb	s10,32(s7)
80002ac0:	da9ff06f          	j	80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>
80002ac4:	000c8513          	mv	a0,s9
80002ac8:	01953ab3          	sltu	s5,a0,s9
80002acc:	d9dff06f          	j	80002868 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE+0x128>

80002ad0 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h47ce8d6cfd4a1e8fE>:
80002ad0:	ff010113          	addi	sp,sp,-16
80002ad4:	00112623          	sw	ra,12(sp)
80002ad8:	00812423          	sw	s0,8(sp)
80002adc:	00912223          	sw	s1,4(sp)
80002ae0:	01212023          	sw	s2,0(sp)
80002ae4:	00110737          	lui	a4,0x110
80002ae8:	00068913          	mv	s2,a3
80002aec:	00060493          	mv	s1,a2
80002af0:	00050413          	mv	s0,a0
80002af4:	02e58063          	beq	a1,a4,80002b14 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h47ce8d6cfd4a1e8fE+0x44>
80002af8:	01c42603          	lw	a2,28(s0)
80002afc:	01842503          	lw	a0,24(s0)
80002b00:	01062603          	lw	a2,16(a2)
80002b04:	000600e7          	jalr	a2
80002b08:	00050593          	mv	a1,a0
80002b0c:	00100513          	li	a0,1
80002b10:	02059c63          	bnez	a1,80002b48 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h47ce8d6cfd4a1e8fE+0x78>
80002b14:	02048863          	beqz	s1,80002b44 <_ZN4core3fmt9Formatter12pad_integral12write_prefix17h47ce8d6cfd4a1e8fE+0x74>
80002b18:	01c42583          	lw	a1,28(s0)
80002b1c:	01842503          	lw	a0,24(s0)
80002b20:	00c5a783          	lw	a5,12(a1)
80002b24:	00048593          	mv	a1,s1
80002b28:	00090613          	mv	a2,s2
80002b2c:	00012903          	lw	s2,0(sp)
80002b30:	00412483          	lw	s1,4(sp)
80002b34:	00812403          	lw	s0,8(sp)
80002b38:	00c12083          	lw	ra,12(sp)
80002b3c:	01010113          	addi	sp,sp,16
80002b40:	00078067          	jr	a5
80002b44:	00000513          	li	a0,0
80002b48:	00012903          	lw	s2,0(sp)
80002b4c:	00412483          	lw	s1,4(sp)
80002b50:	00812403          	lw	s0,8(sp)
80002b54:	00c12083          	lw	ra,12(sp)
80002b58:	01010113          	addi	sp,sp,16
80002b5c:	00008067          	ret

80002b60 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E>:
80002b60:	fd010113          	addi	sp,sp,-48
80002b64:	02112623          	sw	ra,44(sp)
80002b68:	02812423          	sw	s0,40(sp)
80002b6c:	02912223          	sw	s1,36(sp)
80002b70:	03212023          	sw	s2,32(sp)
80002b74:	01312e23          	sw	s3,28(sp)
80002b78:	01412c23          	sw	s4,24(sp)
80002b7c:	01512a23          	sw	s5,20(sp)
80002b80:	01612823          	sw	s6,16(sp)
80002b84:	01712623          	sw	s7,12(sp)
80002b88:	01052703          	lw	a4,16(a0) # 110010 <.Lline_table_start0+0xe567d>
80002b8c:	00852683          	lw	a3,8(a0)
80002b90:	00060993          	mv	s3,a2
80002b94:	00058913          	mv	s2,a1
80002b98:	fff70593          	addi	a1,a4,-1 # 10ffff <.Lline_table_start0+0xe566c>
80002b9c:	00100613          	li	a2,1
80002ba0:	0015b593          	seqz	a1,a1
80002ba4:	00c69663          	bne	a3,a2,80002bb0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x50>
80002ba8:	00059663          	bnez	a1,80002bb4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x54>
80002bac:	1880006f          	j	80002d34 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d4>
80002bb0:	1e058463          	beqz	a1,80002d98 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x238>
80002bb4:	01452703          	lw	a4,20(a0)
80002bb8:	fff68593          	addi	a1,a3,-1
80002bbc:	0015b893          	seqz	a7,a1
80002bc0:	013905b3          	add	a1,s2,s3
80002bc4:	00000613          	li	a2,0
80002bc8:	0c070463          	beqz	a4,80002c90 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x130>
80002bcc:	0e000313          	li	t1,224
80002bd0:	0f000293          	li	t0,240
80002bd4:	00110837          	lui	a6,0x110
80002bd8:	00090413          	mv	s0,s2
80002bdc:	0440006f          	j	80002c20 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xc0>
80002be0:	0006c483          	lbu	s1,0(a3)
80002be4:	00168693          	addi	a3,a3,1
80002be8:	03f4fe13          	andi	t3,s1,63
80002bec:	01d79793          	slli	a5,a5,0x1d
80002bf0:	00b7df13          	srli	t5,a5,0xb
80002bf4:	00ce9493          	slli	s1,t4,0xc
80002bf8:	00639793          	slli	a5,t2,0x6
80002bfc:	01e4e4b3          	or	s1,s1,t5
80002c00:	00f4e7b3          	or	a5,s1,a5
80002c04:	01c7e7b3          	or	a5,a5,t3
80002c08:	13078463          	beq	a5,a6,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002c0c:	40860633          	sub	a2,a2,s0
80002c10:	fff70713          	addi	a4,a4,-1
80002c14:	00d60633          	add	a2,a2,a3
80002c18:	00068413          	mv	s0,a3
80002c1c:	06070c63          	beqz	a4,80002c94 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x134>
80002c20:	10b40863          	beq	s0,a1,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002c24:	00040783          	lb	a5,0(s0)
80002c28:	00140693          	addi	a3,s0,1
80002c2c:	fe07d0e3          	bgez	a5,80002c0c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xac>
80002c30:	00b68e63          	beq	a3,a1,80002c4c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xec>
80002c34:	00144483          	lbu	s1,1(s0)
80002c38:	00240693          	addi	a3,s0,2
80002c3c:	03f4fe93          	andi	t4,s1,63
80002c40:	0ff7f793          	andi	a5,a5,255
80002c44:	fc67e4e3          	bltu	a5,t1,80002c0c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xac>
80002c48:	0140006f          	j	80002c5c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xfc>
80002c4c:	00000e93          	li	t4,0
80002c50:	00058693          	mv	a3,a1
80002c54:	0ff7f793          	andi	a5,a5,255
80002c58:	fa67eae3          	bltu	a5,t1,80002c0c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xac>
80002c5c:	00b68c63          	beq	a3,a1,80002c74 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x114>
80002c60:	0006c483          	lbu	s1,0(a3)
80002c64:	00168693          	addi	a3,a3,1
80002c68:	03f4f393          	andi	t2,s1,63
80002c6c:	fa57e0e3          	bltu	a5,t0,80002c0c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xac>
80002c70:	0100006f          	j	80002c80 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x120>
80002c74:	00000393          	li	t2,0
80002c78:	00058693          	mv	a3,a1
80002c7c:	f857e8e3          	bltu	a5,t0,80002c0c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0xac>
80002c80:	f6b690e3          	bne	a3,a1,80002be0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x80>
80002c84:	00000e13          	li	t3,0
80002c88:	00058693          	mv	a3,a1
80002c8c:	f61ff06f          	j	80002bec <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x8c>
80002c90:	00090693          	mv	a3,s2
80002c94:	08b68e63          	beq	a3,a1,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002c98:	00068703          	lb	a4,0(a3)
80002c9c:	02074863          	bltz	a4,80002ccc <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x16c>
80002ca0:	04060a63          	beqz	a2,80002cf4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x194>
80002ca4:	07367263          	bgeu	a2,s3,80002d08 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1a8>
80002ca8:	00c905b3          	add	a1,s2,a2
80002cac:	00058583          	lb	a1,0(a1)
80002cb0:	fc000693          	li	a3,-64
80002cb4:	06d5c663          	blt	a1,a3,80002d20 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1c0>
80002cb8:	00060593          	mv	a1,a2
80002cbc:	00058613          	mv	a2,a1
80002cc0:	00090593          	mv	a1,s2
80002cc4:	06058663          	beqz	a1,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002cc8:	0600006f          	j	80002d28 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1c8>
80002ccc:	00168793          	addi	a5,a3,1
80002cd0:	0ff77713          	andi	a4,a4,255
80002cd4:	18b78e63          	beq	a5,a1,80002e70 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x310>
80002cd8:	0016c483          	lbu	s1,1(a3)
80002cdc:	00268793          	addi	a5,a3,2
80002ce0:	03f4f693          	andi	a3,s1,63
80002ce4:	00669693          	slli	a3,a3,0x6
80002ce8:	0e000493          	li	s1,224
80002cec:	18977a63          	bgeu	a4,s1,80002e80 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x320>
80002cf0:	fb1ff06f          	j	80002ca0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x140>
80002cf4:	00000593          	li	a1,0
80002cf8:	00058613          	mv	a2,a1
80002cfc:	00090593          	mv	a1,s2
80002d00:	02058863          	beqz	a1,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002d04:	0240006f          	j	80002d28 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1c8>
80002d08:	00098593          	mv	a1,s3
80002d0c:	01361a63          	bne	a2,s3,80002d20 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1c0>
80002d10:	00058613          	mv	a2,a1
80002d14:	00090593          	mv	a1,s2
80002d18:	00058c63          	beqz	a1,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002d1c:	00c0006f          	j	80002d28 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1c8>
80002d20:	00000593          	li	a1,0
80002d24:	00058663          	beqz	a1,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002d28:	00058913          	mv	s2,a1
80002d2c:	00060993          	mv	s3,a2
80002d30:	06088463          	beqz	a7,80002d98 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x238>
80002d34:	00c52583          	lw	a1,12(a0)
80002d38:	00000613          	li	a2,0
80002d3c:	02098463          	beqz	s3,80002d64 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x204>
80002d40:	fbf00693          	li	a3,-65
80002d44:	00098713          	mv	a4,s3
80002d48:	00090793          	mv	a5,s2
80002d4c:	00078483          	lb	s1,0(a5)
80002d50:	00178793          	addi	a5,a5,1
80002d54:	0096a4b3          	slt	s1,a3,s1
80002d58:	fff70713          	addi	a4,a4,-1
80002d5c:	00960633          	add	a2,a2,s1
80002d60:	fe0716e3          	bnez	a4,80002d4c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1ec>
80002d64:	02b67a63          	bgeu	a2,a1,80002d98 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x238>
80002d68:	02054683          	lbu	a3,32(a0)
80002d6c:	00300793          	li	a5,3
80002d70:	00000713          	li	a4,0
80002d74:	00f68463          	beq	a3,a5,80002d7c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x21c>
80002d78:	00068713          	mv	a4,a3
80002d7c:	00377693          	andi	a3,a4,3
80002d80:	40c585b3          	sub	a1,a1,a2
80002d84:	04068a63          	beqz	a3,80002dd8 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x278>
80002d88:	00100613          	li	a2,1
80002d8c:	04c69c63          	bne	a3,a2,80002de4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x284>
80002d90:	00000a93          	li	s5,0
80002d94:	05c0006f          	j	80002df0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x290>
80002d98:	01c52583          	lw	a1,28(a0)
80002d9c:	01852503          	lw	a0,24(a0)
80002da0:	00c5a783          	lw	a5,12(a1)
80002da4:	00090593          	mv	a1,s2
80002da8:	00098613          	mv	a2,s3
80002dac:	00c12b83          	lw	s7,12(sp)
80002db0:	01012b03          	lw	s6,16(sp)
80002db4:	01412a83          	lw	s5,20(sp)
80002db8:	01812a03          	lw	s4,24(sp)
80002dbc:	01c12983          	lw	s3,28(sp)
80002dc0:	02012903          	lw	s2,32(sp)
80002dc4:	02412483          	lw	s1,36(sp)
80002dc8:	02812403          	lw	s0,40(sp)
80002dcc:	02c12083          	lw	ra,44(sp)
80002dd0:	03010113          	addi	sp,sp,48
80002dd4:	00078067          	jr	a5
80002dd8:	00058a93          	mv	s5,a1
80002ddc:	00000593          	li	a1,0
80002de0:	0100006f          	j	80002df0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x290>
80002de4:	00158613          	addi	a2,a1,1
80002de8:	0015d593          	srli	a1,a1,0x1
80002dec:	00165a93          	srli	s5,a2,0x1
80002df0:	01852b03          	lw	s6,24(a0)
80002df4:	01c52b83          	lw	s7,28(a0)
80002df8:	00452403          	lw	s0,4(a0)
80002dfc:	00158493          	addi	s1,a1,1
80002e00:	fff48493          	addi	s1,s1,-1
80002e04:	02048063          	beqz	s1,80002e24 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x2c4>
80002e08:	010ba603          	lw	a2,16(s7)
80002e0c:	000b0513          	mv	a0,s6
80002e10:	00040593          	mv	a1,s0
80002e14:	000600e7          	jalr	a2
80002e18:	fe0504e3          	beqz	a0,80002e00 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x2a0>
80002e1c:	00100a13          	li	s4,1
80002e20:	0840006f          	j	80002ea4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x344>
80002e24:	00110537          	lui	a0,0x110
80002e28:	00100a13          	li	s4,1
80002e2c:	06a40c63          	beq	s0,a0,80002ea4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x344>
80002e30:	00cba683          	lw	a3,12(s7)
80002e34:	000b0513          	mv	a0,s6
80002e38:	00090593          	mv	a1,s2
80002e3c:	00098613          	mv	a2,s3
80002e40:	000680e7          	jalr	a3
80002e44:	06051063          	bnez	a0,80002ea4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x344>
80002e48:	00000493          	li	s1,0
80002e4c:	049a8863          	beq	s5,s1,80002e9c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x33c>
80002e50:	010ba603          	lw	a2,16(s7)
80002e54:	00148493          	addi	s1,s1,1
80002e58:	000b0513          	mv	a0,s6
80002e5c:	00040593          	mv	a1,s0
80002e60:	000600e7          	jalr	a2
80002e64:	fe0504e3          	beqz	a0,80002e4c <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x2ec>
80002e68:	fff48513          	addi	a0,s1,-1
80002e6c:	0340006f          	j	80002ea0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x340>
80002e70:	00000693          	li	a3,0
80002e74:	00058793          	mv	a5,a1
80002e78:	0e000493          	li	s1,224
80002e7c:	e29762e3          	bltu	a4,s1,80002ca0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x140>
80002e80:	04b78a63          	beq	a5,a1,80002ed4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x374>
80002e84:	0007c483          	lbu	s1,0(a5)
80002e88:	00178793          	addi	a5,a5,1
80002e8c:	03f4f493          	andi	s1,s1,63
80002e90:	0f000413          	li	s0,240
80002e94:	04877863          	bgeu	a4,s0,80002ee4 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x384>
80002e98:	e09ff06f          	j	80002ca0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x140>
80002e9c:	000a8513          	mv	a0,s5
80002ea0:	01553a33          	sltu	s4,a0,s5
80002ea4:	000a0513          	mv	a0,s4
80002ea8:	00c12b83          	lw	s7,12(sp)
80002eac:	01012b03          	lw	s6,16(sp)
80002eb0:	01412a83          	lw	s5,20(sp)
80002eb4:	01812a03          	lw	s4,24(sp)
80002eb8:	01c12983          	lw	s3,28(sp)
80002ebc:	02012903          	lw	s2,32(sp)
80002ec0:	02412483          	lw	s1,36(sp)
80002ec4:	02812403          	lw	s0,40(sp)
80002ec8:	02c12083          	lw	ra,44(sp)
80002ecc:	03010113          	addi	sp,sp,48
80002ed0:	00008067          	ret
80002ed4:	00000493          	li	s1,0
80002ed8:	00058793          	mv	a5,a1
80002edc:	0f000413          	li	s0,240
80002ee0:	dc8760e3          	bltu	a4,s0,80002ca0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x140>
80002ee4:	00d4e6b3          	or	a3,s1,a3
80002ee8:	00b78863          	beq	a5,a1,80002ef8 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x398>
80002eec:	0007c583          	lbu	a1,0(a5)
80002ef0:	03f5f593          	andi	a1,a1,63
80002ef4:	0080006f          	j	80002efc <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x39c>
80002ef8:	00000593          	li	a1,0
80002efc:	01d71713          	slli	a4,a4,0x1d
80002f00:	00b75713          	srli	a4,a4,0xb
80002f04:	00669693          	slli	a3,a3,0x6
80002f08:	00e6e6b3          	or	a3,a3,a4
80002f0c:	00b6e5b3          	or	a1,a3,a1
80002f10:	001106b7          	lui	a3,0x110
80002f14:	e0d58ee3          	beq	a1,a3,80002d30 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x1d0>
80002f18:	d89ff06f          	j	80002ca0 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E+0x140>

80002f1c <_ZN4core3fmt9Formatter9write_str17h4913b9ef2958df0fE>:
80002f1c:	01c52683          	lw	a3,28(a0) # 11001c <.Lline_table_start0+0xe5689>
80002f20:	01852503          	lw	a0,24(a0)
80002f24:	00c6a783          	lw	a5,12(a3) # 11000c <.Lline_table_start0+0xe5679>
80002f28:	00078067          	jr	a5

80002f2c <_ZN4core3fmt9Formatter15debug_lower_hex17h38efe26ca78948c0E>:
80002f2c:	00054503          	lbu	a0,0(a0)
80002f30:	01057513          	andi	a0,a0,16
80002f34:	00455513          	srli	a0,a0,0x4
80002f38:	00008067          	ret

80002f3c <_ZN4core3fmt9Formatter15debug_upper_hex17hc0a12002b7a1ac2bE>:
80002f3c:	00054503          	lbu	a0,0(a0)
80002f40:	02057513          	andi	a0,a0,32
80002f44:	00555513          	srli	a0,a0,0x5
80002f48:	00008067          	ret

80002f4c <_ZN4core3fmt9Formatter12debug_struct17ha7b4d14b3b78e6a4E>:
80002f4c:	ff010113          	addi	sp,sp,-16
80002f50:	00112623          	sw	ra,12(sp)
80002f54:	00812423          	sw	s0,8(sp)
80002f58:	00050413          	mv	s0,a0
80002f5c:	01c52683          	lw	a3,28(a0)
80002f60:	01852503          	lw	a0,24(a0)
80002f64:	00c6a683          	lw	a3,12(a3)
80002f68:	000680e7          	jalr	a3
80002f6c:	00050593          	mv	a1,a0
80002f70:	00040513          	mv	a0,s0
80002f74:	00812403          	lw	s0,8(sp)
80002f78:	00c12083          	lw	ra,12(sp)
80002f7c:	01010113          	addi	sp,sp,16
80002f80:	00008067          	ret

80002f84 <_ZN4core3fmt9Formatter11debug_tuple17h3747f691d94e4e92E>:
80002f84:	ff010113          	addi	sp,sp,-16
80002f88:	00112623          	sw	ra,12(sp)
80002f8c:	00812423          	sw	s0,8(sp)
80002f90:	00912223          	sw	s1,4(sp)
80002f94:	01212023          	sw	s2,0(sp)
80002f98:	00058413          	mv	s0,a1
80002f9c:	01c5a703          	lw	a4,28(a1)
80002fa0:	0185a583          	lw	a1,24(a1)
80002fa4:	00c72703          	lw	a4,12(a4)
80002fa8:	00068913          	mv	s2,a3
80002fac:	00050493          	mv	s1,a0
80002fb0:	00058513          	mv	a0,a1
80002fb4:	00060593          	mv	a1,a2
80002fb8:	00068613          	mv	a2,a3
80002fbc:	000700e7          	jalr	a4
80002fc0:	00193593          	seqz	a1,s2
80002fc4:	0084a023          	sw	s0,0(s1)
80002fc8:	00a48423          	sb	a0,8(s1)
80002fcc:	0004a223          	sw	zero,4(s1)
80002fd0:	00b484a3          	sb	a1,9(s1)
80002fd4:	00012903          	lw	s2,0(sp)
80002fd8:	00412483          	lw	s1,4(sp)
80002fdc:	00812403          	lw	s0,8(sp)
80002fe0:	00c12083          	lw	ra,12(sp)
80002fe4:	01010113          	addi	sp,sp,16
80002fe8:	00008067          	ret

80002fec <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE>:
80002fec:	fc010113          	addi	sp,sp,-64
80002ff0:	02112e23          	sw	ra,60(sp)
80002ff4:	02812c23          	sw	s0,56(sp)
80002ff8:	02912a23          	sw	s1,52(sp)
80002ffc:	03212823          	sw	s2,48(sp)
80003000:	03312623          	sw	s3,44(sp)
80003004:	03412423          	sw	s4,40(sp)
80003008:	03512223          	sw	s5,36(sp)
8000300c:	03612023          	sw	s6,32(sp)
80003010:	01712e23          	sw	s7,28(sp)
80003014:	01812c23          	sw	s8,24(sp)
80003018:	01912a23          	sw	s9,20(sp)
8000301c:	01a12823          	sw	s10,16(sp)
80003020:	01c5a603          	lw	a2,28(a1)
80003024:	0185a983          	lw	s3,24(a1)
80003028:	01062783          	lw	a5,16(a2)
8000302c:	00050493          	mv	s1,a0
80003030:	02700593          	li	a1,39
80003034:	00098513          	mv	a0,s3
80003038:	00f12623          	sw	a5,12(sp)
8000303c:	000780e7          	jalr	a5
80003040:	04050063          	beqz	a0,80003080 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x94>
80003044:	00100513          	li	a0,1
80003048:	01012d03          	lw	s10,16(sp)
8000304c:	01412c83          	lw	s9,20(sp)
80003050:	01812c03          	lw	s8,24(sp)
80003054:	01c12b83          	lw	s7,28(sp)
80003058:	02012b03          	lw	s6,32(sp)
8000305c:	02412a83          	lw	s5,36(sp)
80003060:	02812a03          	lw	s4,40(sp)
80003064:	02c12983          	lw	s3,44(sp)
80003068:	03012903          	lw	s2,48(sp)
8000306c:	03412483          	lw	s1,52(sp)
80003070:	03812403          	lw	s0,56(sp)
80003074:	03c12083          	lw	ra,60(sp)
80003078:	04010113          	addi	sp,sp,64
8000307c:	00008067          	ret
80003080:	0004a903          	lw	s2,0(s1)
80003084:	00c00513          	li	a0,12
80003088:	00200493          	li	s1,2
8000308c:	03255063          	bge	a0,s2,800030ac <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0xc0>
80003090:	00d00513          	li	a0,13
80003094:	02a90863          	beq	s2,a0,800030c4 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0xd8>
80003098:	02700513          	li	a0,39
8000309c:	02a90263          	beq	s2,a0,800030c0 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0xd4>
800030a0:	05c00513          	li	a0,92
800030a4:	00a90e63          	beq	s2,a0,800030c0 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0xd4>
800030a8:	02c0006f          	j	800030d4 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0xe8>
800030ac:	00900513          	li	a0,9
800030b0:	00a90e63          	beq	s2,a0,800030cc <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0xe0>
800030b4:	00a00513          	li	a0,10
800030b8:	00a91e63          	bne	s2,a0,800030d4 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0xe8>
800030bc:	06e00913          	li	s2,110
800030c0:	2000006f          	j	800032c0 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x2d4>
800030c4:	07200913          	li	s2,114
800030c8:	1f80006f          	j	800032c0 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x2d4>
800030cc:	07400913          	li	s2,116
800030d0:	1f00006f          	j	800032c0 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x2d4>
800030d4:	00090513          	mv	a0,s2
800030d8:	00001097          	auipc	ra,0x1
800030dc:	fcc080e7          	jalr	-52(ra) # 800040a4 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E>
800030e0:	14051863          	bnez	a0,80003230 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x244>
800030e4:	01095513          	srli	a0,s2,0x10
800030e8:	04051063          	bnez	a0,80003128 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x13c>
800030ec:	80005537          	lui	a0,0x80005
800030f0:	ec850593          	addi	a1,a0,-312 # 80004ec8 <ebss+0xffffdec8>
800030f4:	80005537          	lui	a0,0x80005
800030f8:	f1850693          	addi	a3,a0,-232 # 80004f18 <ebss+0xffffdf18>
800030fc:	80005537          	lui	a0,0x80005
80003100:	03850793          	addi	a5,a0,56 # 80005038 <ebss+0xffffe038>
80003104:	02800613          	li	a2,40
80003108:	12000713          	li	a4,288
8000310c:	12f00813          	li	a6,303
80003110:	00090513          	mv	a0,s2
80003114:	00001097          	auipc	ra,0x1
80003118:	890080e7          	jalr	-1904(ra) # 800039a4 <_ZN4core7unicode9printable5check17h9caae249355430a0E>
8000311c:	10050a63          	beqz	a0,80003230 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x244>
80003120:	00100493          	li	s1,1
80003124:	19c0006f          	j	800032c0 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x2d4>
80003128:	01195513          	srli	a0,s2,0x11
8000312c:	02051e63          	bnez	a0,80003168 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x17c>
80003130:	80005537          	lui	a0,0x80005
80003134:	16750593          	addi	a1,a0,359 # 80005167 <ebss+0xffffe167>
80003138:	80005537          	lui	a0,0x80005
8000313c:	1bb50693          	addi	a3,a0,443 # 800051bb <ebss+0xffffe1bb>
80003140:	80005537          	lui	a0,0x80005
80003144:	27b50793          	addi	a5,a0,635 # 8000527b <ebss+0xffffe27b>
80003148:	02a00613          	li	a2,42
8000314c:	0c000713          	li	a4,192
80003150:	1b600813          	li	a6,438
80003154:	00090513          	mv	a0,s2
80003158:	00001097          	auipc	ra,0x1
8000315c:	84c080e7          	jalr	-1972(ra) # 800039a4 <_ZN4core7unicode9printable5check17h9caae249355430a0E>
80003160:	fc0510e3          	bnez	a0,80003120 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x134>
80003164:	0cc0006f          	j	80003230 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x244>
80003168:	00595513          	srli	a0,s2,0x5
8000316c:	000015b7          	lui	a1,0x1
80003170:	53758613          	addi	a2,a1,1335 # 1537 <.Lline_table_start0+0x1537>
80003174:	00c54533          	xor	a0,a0,a2
80003178:	00a03533          	snez	a0,a0
8000317c:	fffd5637          	lui	a2,0xfffd5
80003180:	8c760613          	addi	a2,a2,-1849 # fffd48c7 <ebss+0x7ffcd8c7>
80003184:	00c90633          	add	a2,s2,a2
80003188:	00600693          	li	a3,6
8000318c:	00c6b633          	sltu	a2,a3,a2
80003190:	00c57533          	and	a0,a0,a2
80003194:	00200637          	lui	a2,0x200
80003198:	fe060613          	addi	a2,a2,-32 # 1fffe0 <.Lline_table_start0+0x1d564d>
8000319c:	01e66613          	ori	a2,a2,30
800031a0:	00c97633          	and	a2,s2,a2
800031a4:	0002c6b7          	lui	a3,0x2c
800031a8:	81e68693          	addi	a3,a3,-2018 # 2b81e <.Lline_table_start0+0xe8b>
800031ac:	00d64633          	xor	a2,a2,a3
800031b0:	00c03633          	snez	a2,a2
800031b4:	00c57533          	and	a0,a0,a2
800031b8:	fffd3637          	lui	a2,0xfffd3
800031bc:	15e60613          	addi	a2,a2,350 # fffd315e <ebss+0x7ffcc15e>
800031c0:	00c90633          	add	a2,s2,a2
800031c4:	00d00693          	li	a3,13
800031c8:	00c6b633          	sltu	a2,a3,a2
800031cc:	00c57533          	and	a0,a0,a2
800031d0:	fffd1637          	lui	a2,0xfffd1
800031d4:	41f60613          	addi	a2,a2,1055 # fffd141f <ebss+0x7ffca41f>
800031d8:	00c90633          	add	a2,s2,a2
800031dc:	c1e58593          	addi	a1,a1,-994
800031e0:	00c5b5b3          	sltu	a1,a1,a2
800031e4:	00b57533          	and	a0,a0,a1
800031e8:	fffd05b7          	lui	a1,0xfffd0
800031ec:	5e258593          	addi	a1,a1,1506 # fffd05e2 <ebss+0x7ffc95e2>
800031f0:	00b905b3          	add	a1,s2,a1
800031f4:	5e100613          	li	a2,1505
800031f8:	00b635b3          	sltu	a1,a2,a1
800031fc:	00b57533          	and	a0,a0,a1
80003200:	fffcf5b7          	lui	a1,0xfffcf
80003204:	cb558593          	addi	a1,a1,-843 # fffcecb5 <ebss+0x7ffc7cb5>
80003208:	00b905b3          	add	a1,s2,a1
8000320c:	000af637          	lui	a2,0xaf
80003210:	db460613          	addi	a2,a2,-588 # aedb4 <.Lline_table_start0+0x84421>
80003214:	00b635b3          	sltu	a1,a2,a1
80003218:	00b57533          	and	a0,a0,a1
8000321c:	000e05b7          	lui	a1,0xe0
80003220:	1f058593          	addi	a1,a1,496 # e01f0 <.Lline_table_start0+0xb585d>
80003224:	00b935b3          	sltu	a1,s2,a1
80003228:	00b57533          	and	a0,a0,a1
8000322c:	ee051ae3          	bnez	a0,80003120 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x134>
80003230:	00196513          	ori	a0,s2,1
80003234:	00155593          	srli	a1,a0,0x1
80003238:	00b56533          	or	a0,a0,a1
8000323c:	00255593          	srli	a1,a0,0x2
80003240:	00b56533          	or	a0,a0,a1
80003244:	00455593          	srli	a1,a0,0x4
80003248:	00b56533          	or	a0,a0,a1
8000324c:	00855593          	srli	a1,a0,0x8
80003250:	00b56533          	or	a0,a0,a1
80003254:	01055593          	srli	a1,a0,0x10
80003258:	00b56533          	or	a0,a0,a1
8000325c:	fff54513          	not	a0,a0
80003260:	00155593          	srli	a1,a0,0x1
80003264:	55555637          	lui	a2,0x55555
80003268:	55560613          	addi	a2,a2,1365 # 55555555 <.Lline_table_start0+0x5552abc2>
8000326c:	00c5f5b3          	and	a1,a1,a2
80003270:	40b50533          	sub	a0,a0,a1
80003274:	333335b7          	lui	a1,0x33333
80003278:	33358593          	addi	a1,a1,819 # 33333333 <.Lline_table_start0+0x333089a0>
8000327c:	00b57633          	and	a2,a0,a1
80003280:	00255513          	srli	a0,a0,0x2
80003284:	00b57533          	and	a0,a0,a1
80003288:	00a60533          	add	a0,a2,a0
8000328c:	00455593          	srli	a1,a0,0x4
80003290:	00b50533          	add	a0,a0,a1
80003294:	0f0f15b7          	lui	a1,0xf0f1
80003298:	f0f58593          	addi	a1,a1,-241 # f0f0f0f <.Lline_table_start0+0xf0c657c>
8000329c:	00b57533          	and	a0,a0,a1
800032a0:	010105b7          	lui	a1,0x1010
800032a4:	10158593          	addi	a1,a1,257 # 1010101 <.Lline_table_start0+0xfe576e>
800032a8:	00001097          	auipc	ra,0x1
800032ac:	0a4080e7          	jalr	164(ra) # 8000434c <__mulsi3>
800032b0:	01a55513          	srli	a0,a0,0x1a
800032b4:	00754a13          	xori	s4,a0,7
800032b8:	00500413          	li	s0,5
800032bc:	00300493          	li	s1,3
800032c0:	f0000a93          	li	s5,-256
800032c4:	fff00b13          	li	s6,-1
800032c8:	00100b93          	li	s7,1
800032cc:	00200c13          	li	s8,2
800032d0:	80005537          	lui	a0,0x80005
800032d4:	abc50c93          	addi	s9,a0,-1348 # 80004abc <ebss+0xffffdabc>
800032d8:	00a00d13          	li	s10,10
800032dc:	01c0006f          	j	800032f8 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x30c>
800032e0:	05c00593          	li	a1,92
800032e4:	00100493          	li	s1,1
800032e8:	00098513          	mv	a0,s3
800032ec:	00c12783          	lw	a5,12(sp)
800032f0:	000780e7          	jalr	a5
800032f4:	d40518e3          	bnez	a0,80003044 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x58>
800032f8:	029bd663          	bge	s7,s1,80003324 <.LBB198_26+0x10>
800032fc:	ff8482e3          	beq	s1,s8,800032e0 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x2f4>
80003300:	0ff47513          	andi	a0,s0,255
80003304:	00251513          	slli	a0,a0,0x2
80003308:	01950533          	add	a0,a0,s9
8000330c:	00052503          	lw	a0,0(a0)
80003310:	00050067          	jr	a0

80003314 <.LBB198_26>:
80003314:	016a7a33          	and	s4,s4,s6
80003318:	01547433          	and	s0,s0,s5
8000331c:	07d00593          	li	a1,125
80003320:	0840006f          	j	800033a4 <.LBB198_35+0x20>
80003324:	09749463          	bne	s1,s7,800033ac <.LBB198_38>
80003328:	00000493          	li	s1,0
8000332c:	00090593          	mv	a1,s2
80003330:	fb9ff06f          	j	800032e8 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x2fc>

80003334 <.LBB198_29>:
80003334:	002a1513          	slli	a0,s4,0x2
80003338:	00a95533          	srl	a0,s2,a0
8000333c:	00f57513          	andi	a0,a0,15
80003340:	03000593          	li	a1,48
80003344:	01a56463          	bltu	a0,s10,8000334c <.LBB198_29+0x18>
80003348:	05700593          	li	a1,87
8000334c:	00a585b3          	add	a1,a1,a0
80003350:	040a0463          	beqz	s4,80003398 <.LBB198_35+0x14>
80003354:	fffa0a13          	addi	s4,s4,-1 # 10ffff <.Lline_table_start0+0xe566c>
80003358:	04c0006f          	j	800033a4 <.LBB198_35+0x20>

8000335c <.LBB198_33>:
8000335c:	016a7a33          	and	s4,s4,s6
80003360:	01547533          	and	a0,s0,s5
80003364:	00256413          	ori	s0,a0,2
80003368:	07b00593          	li	a1,123
8000336c:	0380006f          	j	800033a4 <.LBB198_35+0x20>

80003370 <.LBB198_34>:
80003370:	016a7a33          	and	s4,s4,s6
80003374:	01547533          	and	a0,s0,s5
80003378:	00356413          	ori	s0,a0,3
8000337c:	07500593          	li	a1,117
80003380:	0240006f          	j	800033a4 <.LBB198_35+0x20>

80003384 <.LBB198_35>:
80003384:	016a7a33          	and	s4,s4,s6
80003388:	01547533          	and	a0,s0,s5
8000338c:	00456413          	ori	s0,a0,4
80003390:	05c00593          	li	a1,92
80003394:	0100006f          	j	800033a4 <.LBB198_35+0x20>
80003398:	016a7a33          	and	s4,s4,s6
8000339c:	01547533          	and	a0,s0,s5
800033a0:	00156413          	ori	s0,a0,1
800033a4:	00300493          	li	s1,3
800033a8:	f41ff06f          	j	800032e8 <_ZN41_$LT$char$u20$as$u20$core..fmt..Debug$GT$3fmt17h11017b87887d3ccdE+0x2fc>

800033ac <.LBB198_38>:
800033ac:	02700593          	li	a1,39
800033b0:	00098513          	mv	a0,s3
800033b4:	00c12783          	lw	a5,12(sp)
800033b8:	01012d03          	lw	s10,16(sp)
800033bc:	01412c83          	lw	s9,20(sp)
800033c0:	01812c03          	lw	s8,24(sp)
800033c4:	01c12b83          	lw	s7,28(sp)
800033c8:	02012b03          	lw	s6,32(sp)
800033cc:	02412a83          	lw	s5,36(sp)
800033d0:	02812a03          	lw	s4,40(sp)
800033d4:	02c12983          	lw	s3,44(sp)
800033d8:	03012903          	lw	s2,48(sp)
800033dc:	03412483          	lw	s1,52(sp)
800033e0:	03812403          	lw	s0,56(sp)
800033e4:	03c12083          	lw	ra,60(sp)
800033e8:	04010113          	addi	sp,sp,64
800033ec:	00078067          	jr	a5

800033f0 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E>:
800033f0:	ff010113          	addi	sp,sp,-16
800033f4:	00112623          	sw	ra,12(sp)
800033f8:	00058693          	mv	a3,a1
800033fc:	0085a603          	lw	a2,8(a1)
80003400:	00100593          	li	a1,1
80003404:	00b60663          	beq	a2,a1,80003410 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0x20>
80003408:	0106a603          	lw	a2,16(a3)
8000340c:	04b61463          	bne	a2,a1,80003454 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0x64>
80003410:	00052503          	lw	a0,0(a0)
80003414:	08000593          	li	a1,128
80003418:	00012423          	sw	zero,8(sp)
8000341c:	00b57863          	bgeu	a0,a1,8000342c <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0x3c>
80003420:	00a10423          	sb	a0,8(sp)
80003424:	00100613          	li	a2,1
80003428:	0bc0006f          	j	800034e4 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0xf4>
8000342c:	00b55593          	srli	a1,a0,0xb
80003430:	04059063          	bnez	a1,80003470 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0x80>
80003434:	00655593          	srli	a1,a0,0x6
80003438:	0c05e593          	ori	a1,a1,192
8000343c:	00b10423          	sb	a1,8(sp)
80003440:	03f57513          	andi	a0,a0,63
80003444:	08056513          	ori	a0,a0,128
80003448:	00a104a3          	sb	a0,9(sp)
8000344c:	00200613          	li	a2,2
80003450:	0940006f          	j	800034e4 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0xf4>
80003454:	01c6a603          	lw	a2,28(a3)
80003458:	00052583          	lw	a1,0(a0)
8000345c:	0186a503          	lw	a0,24(a3)
80003460:	01062783          	lw	a5,16(a2)
80003464:	00c12083          	lw	ra,12(sp)
80003468:	01010113          	addi	sp,sp,16
8000346c:	00078067          	jr	a5
80003470:	01055593          	srli	a1,a0,0x10
80003474:	02059a63          	bnez	a1,800034a8 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0xb8>
80003478:	00c55593          	srli	a1,a0,0xc
8000347c:	0e05e593          	ori	a1,a1,224
80003480:	00b10423          	sb	a1,8(sp)
80003484:	00655593          	srli	a1,a0,0x6
80003488:	03f5f593          	andi	a1,a1,63
8000348c:	0805e593          	ori	a1,a1,128
80003490:	00b104a3          	sb	a1,9(sp)
80003494:	03f57513          	andi	a0,a0,63
80003498:	08056513          	ori	a0,a0,128
8000349c:	00a10523          	sb	a0,10(sp)
800034a0:	00300613          	li	a2,3
800034a4:	0400006f          	j	800034e4 <_ZN43_$LT$char$u20$as$u20$core..fmt..Display$GT$3fmt17h949c6662a01b24e8E+0xf4>
800034a8:	01255593          	srli	a1,a0,0x12
800034ac:	0f05e593          	ori	a1,a1,240
800034b0:	00b10423          	sb	a1,8(sp)
800034b4:	00c55593          	srli	a1,a0,0xc
800034b8:	03f5f593          	andi	a1,a1,63
800034bc:	0805e593          	ori	a1,a1,128
800034c0:	00b104a3          	sb	a1,9(sp)
800034c4:	00655593          	srli	a1,a0,0x6
800034c8:	03f5f593          	andi	a1,a1,63
800034cc:	0805e593          	ori	a1,a1,128
800034d0:	00b10523          	sb	a1,10(sp)
800034d4:	03f57513          	andi	a0,a0,63
800034d8:	08056513          	ori	a0,a0,128
800034dc:	00a105a3          	sb	a0,11(sp)
800034e0:	00400613          	li	a2,4
800034e4:	00810593          	addi	a1,sp,8
800034e8:	00068513          	mv	a0,a3
800034ec:	fffff097          	auipc	ra,0xfffff
800034f0:	674080e7          	jalr	1652(ra) # 80002b60 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E>
800034f4:	00c12083          	lw	ra,12(sp)
800034f8:	01010113          	addi	sp,sp,16
800034fc:	00008067          	ret

80003500 <_ZN4core5slice5index26slice_start_index_len_fail17h00e5ce03f9138bcfE>:
80003500:	fc010113          	addi	sp,sp,-64
80003504:	02112e23          	sw	ra,60(sp)
80003508:	00a12423          	sw	a0,8(sp)
8000350c:	00b12623          	sw	a1,12(sp)
80003510:	00810513          	addi	a0,sp,8
80003514:	02a12423          	sw	a0,40(sp)
80003518:	80004537          	lui	a0,0x80004
8000351c:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
80003520:	02a12623          	sw	a0,44(sp)
80003524:	00c10593          	addi	a1,sp,12
80003528:	02b12823          	sw	a1,48(sp)
8000352c:	02a12a23          	sw	a0,52(sp)
80003530:	80005537          	lui	a0,0x80005
80003534:	d3450513          	addi	a0,a0,-716 # 80004d34 <ebss+0xffffdd34>
80003538:	00a12823          	sw	a0,16(sp)
8000353c:	00200513          	li	a0,2
80003540:	00a12a23          	sw	a0,20(sp)
80003544:	00012c23          	sw	zero,24(sp)
80003548:	02810593          	addi	a1,sp,40
8000354c:	02b12023          	sw	a1,32(sp)
80003550:	02a12223          	sw	a0,36(sp)
80003554:	01010513          	addi	a0,sp,16
80003558:	00060593          	mv	a1,a2
8000355c:	ffffe097          	auipc	ra,0xffffe
80003560:	3f8080e7          	jalr	1016(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
80003564:	c0001073          	unimp

80003568 <_ZN4core5slice5index24slice_end_index_len_fail17habe52d70a9383759E>:
80003568:	fc010113          	addi	sp,sp,-64
8000356c:	02112e23          	sw	ra,60(sp)
80003570:	00a12423          	sw	a0,8(sp)
80003574:	00b12623          	sw	a1,12(sp)
80003578:	00810513          	addi	a0,sp,8
8000357c:	02a12423          	sw	a0,40(sp)
80003580:	80004537          	lui	a0,0x80004
80003584:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
80003588:	02a12623          	sw	a0,44(sp)
8000358c:	00c10593          	addi	a1,sp,12
80003590:	02b12823          	sw	a1,48(sp)
80003594:	02a12a23          	sw	a0,52(sp)
80003598:	80005537          	lui	a0,0x80005
8000359c:	d4450513          	addi	a0,a0,-700 # 80004d44 <ebss+0xffffdd44>
800035a0:	00a12823          	sw	a0,16(sp)
800035a4:	00200513          	li	a0,2
800035a8:	00a12a23          	sw	a0,20(sp)
800035ac:	00012c23          	sw	zero,24(sp)
800035b0:	02810593          	addi	a1,sp,40
800035b4:	02b12023          	sw	a1,32(sp)
800035b8:	02a12223          	sw	a0,36(sp)
800035bc:	01010513          	addi	a0,sp,16
800035c0:	00060593          	mv	a1,a2
800035c4:	ffffe097          	auipc	ra,0xffffe
800035c8:	390080e7          	jalr	912(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
800035cc:	c0001073          	unimp

800035d0 <_ZN4core5slice5index22slice_index_order_fail17hef60e0092a3ca143E>:
800035d0:	fc010113          	addi	sp,sp,-64
800035d4:	02112e23          	sw	ra,60(sp)
800035d8:	00a12423          	sw	a0,8(sp)
800035dc:	00b12623          	sw	a1,12(sp)
800035e0:	00810513          	addi	a0,sp,8
800035e4:	02a12423          	sw	a0,40(sp)
800035e8:	80004537          	lui	a0,0x80004
800035ec:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
800035f0:	02a12623          	sw	a0,44(sp)
800035f4:	00c10593          	addi	a1,sp,12
800035f8:	02b12823          	sw	a1,48(sp)
800035fc:	02a12a23          	sw	a0,52(sp)
80003600:	80005537          	lui	a0,0x80005
80003604:	d7850513          	addi	a0,a0,-648 # 80004d78 <ebss+0xffffdd78>
80003608:	00a12823          	sw	a0,16(sp)
8000360c:	00200513          	li	a0,2
80003610:	00a12a23          	sw	a0,20(sp)
80003614:	00012c23          	sw	zero,24(sp)
80003618:	02810593          	addi	a1,sp,40
8000361c:	02b12023          	sw	a1,32(sp)
80003620:	02a12223          	sw	a0,36(sp)
80003624:	01010513          	addi	a0,sp,16
80003628:	00060593          	mv	a1,a2
8000362c:	ffffe097          	auipc	ra,0xffffe
80003630:	328080e7          	jalr	808(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
80003634:	c0001073          	unimp

80003638 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E>:
80003638:	f9010113          	addi	sp,sp,-112
8000363c:	06112623          	sw	ra,108(sp)
80003640:	00c12023          	sw	a2,0(sp)
80003644:	10100793          	li	a5,257
80003648:	00d12223          	sw	a3,4(sp)
8000364c:	02f5f063          	bgeu	a1,a5,8000366c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x34>
80003650:	00000813          	li	a6,0
80003654:	00a12423          	sw	a0,8(sp)
80003658:	00b12623          	sw	a1,12(sp)
8000365c:	800057b7          	lui	a5,0x80005
80003660:	ad478793          	addi	a5,a5,-1324 # 80004ad4 <ebss+0xffffdad4>
80003664:	00f12823          	sw	a5,16(sp)
80003668:	0540006f          	j	800036bc <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x84>
8000366c:	10000893          	li	a7,256
80003670:	fc000813          	li	a6,-64
80003674:	011507b3          	add	a5,a0,a7
80003678:	00078783          	lb	a5,0(a5)
8000367c:	0107da63          	bge	a5,a6,80003690 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x58>
80003680:	fff88893          	addi	a7,a7,-1
80003684:	fe0898e3          	bnez	a7,80003674 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x3c>
80003688:	00000813          	li	a6,0
8000368c:	0180006f          	j	800036a4 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x6c>
80003690:	00b8f663          	bgeu	a7,a1,8000369c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x64>
80003694:	00088813          	mv	a6,a7
80003698:	00c0006f          	j	800036a4 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x6c>
8000369c:	00058813          	mv	a6,a1
800036a0:	13159263          	bne	a1,a7,800037c4 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x18c>
800036a4:	00a12423          	sw	a0,8(sp)
800036a8:	01012623          	sw	a6,12(sp)
800036ac:	800057b7          	lui	a5,0x80005
800036b0:	dbc78793          	addi	a5,a5,-580 # 80004dbc <ebss+0xffffddbc>
800036b4:	00f12823          	sw	a5,16(sp)
800036b8:	00500813          	li	a6,5
800036bc:	00c5b8b3          	sltu	a7,a1,a2
800036c0:	00d5b7b3          	sltu	a5,a1,a3
800036c4:	00f8e7b3          	or	a5,a7,a5
800036c8:	01012a23          	sw	a6,20(sp)
800036cc:	04078c63          	beqz	a5,80003724 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0xec>
800036d0:	00089463          	bnez	a7,800036d8 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0xa0>
800036d4:	00068613          	mv	a2,a3
800036d8:	02c12023          	sw	a2,32(sp)
800036dc:	02010513          	addi	a0,sp,32
800036e0:	04a12023          	sw	a0,64(sp)
800036e4:	80004537          	lui	a0,0x80004
800036e8:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
800036ec:	04a12223          	sw	a0,68(sp)
800036f0:	00810513          	addi	a0,sp,8
800036f4:	04a12423          	sw	a0,72(sp)
800036f8:	80004537          	lui	a0,0x80004
800036fc:	01450513          	addi	a0,a0,20 # 80004014 <ebss+0xffffd014>
80003700:	04a12623          	sw	a0,76(sp)
80003704:	01010593          	addi	a1,sp,16
80003708:	04b12823          	sw	a1,80(sp)
8000370c:	04a12a23          	sw	a0,84(sp)
80003710:	80005537          	lui	a0,0x80005
80003714:	de450513          	addi	a0,a0,-540 # 80004de4 <ebss+0xffffdde4>
80003718:	02a12423          	sw	a0,40(sp)
8000371c:	00300513          	li	a0,3
80003720:	25c0006f          	j	8000397c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x344>
80003724:	04c6fc63          	bgeu	a3,a2,8000377c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x144>
80003728:	00010513          	mv	a0,sp
8000372c:	04a12023          	sw	a0,64(sp)
80003730:	80004537          	lui	a0,0x80004
80003734:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
80003738:	04a12223          	sw	a0,68(sp)
8000373c:	00410593          	addi	a1,sp,4
80003740:	04b12423          	sw	a1,72(sp)
80003744:	04a12623          	sw	a0,76(sp)
80003748:	00810513          	addi	a0,sp,8
8000374c:	04a12823          	sw	a0,80(sp)
80003750:	80004537          	lui	a0,0x80004
80003754:	01450513          	addi	a0,a0,20 # 80004014 <ebss+0xffffd014>
80003758:	04a12a23          	sw	a0,84(sp)
8000375c:	01010593          	addi	a1,sp,16
80003760:	04b12c23          	sw	a1,88(sp)
80003764:	04a12e23          	sw	a0,92(sp)
80003768:	80005537          	lui	a0,0x80005
8000376c:	e0c50513          	addi	a0,a0,-500 # 80004e0c <ebss+0xffffde0c>
80003770:	02a12423          	sw	a0,40(sp)
80003774:	00400513          	li	a0,4
80003778:	2040006f          	j	8000397c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x344>
8000377c:	02061863          	bnez	a2,800037ac <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x174>
80003780:	00d12c23          	sw	a3,24(sp)
80003784:	06069463          	bnez	a3,800037ec <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1b4>
80003788:	00000693          	li	a3,0
8000378c:	08b68263          	beq	a3,a1,80003810 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1d8>
80003790:	00d507b3          	add	a5,a0,a3
80003794:	00078603          	lb	a2,0(a5)
80003798:	0ff67293          	andi	t0,a2,255
8000379c:	08064863          	bltz	a2,8000382c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1f4>
800037a0:	00512e23          	sw	t0,28(sp)
800037a4:	00100593          	li	a1,1
800037a8:	15c0006f          	j	80003904 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x2cc>
800037ac:	02b67a63          	bgeu	a2,a1,800037e0 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1a8>
800037b0:	00c507b3          	add	a5,a0,a2
800037b4:	00078803          	lb	a6,0(a5)
800037b8:	fbf00793          	li	a5,-65
800037bc:	fd07c2e3          	blt	a5,a6,80003780 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x148>
800037c0:	0240006f          	j	800037e4 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1ac>
800037c4:	80005637          	lui	a2,0x80005
800037c8:	dac60713          	addi	a4,a2,-596 # 80004dac <ebss+0xffffddac>
800037cc:	00000613          	li	a2,0
800037d0:	00088693          	mv	a3,a7
800037d4:	00000097          	auipc	ra,0x0
800037d8:	e64080e7          	jalr	-412(ra) # 80003638 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E>
800037dc:	c0001073          	unimp
800037e0:	fac580e3          	beq	a1,a2,80003780 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x148>
800037e4:	00c12c23          	sw	a2,24(sp)
800037e8:	00060693          	mv	a3,a2
800037ec:	fbf00613          	li	a2,-65
800037f0:	0180006f          	j	80003808 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1d0>
800037f4:	00d507b3          	add	a5,a0,a3
800037f8:	00078783          	lb	a5,0(a5)
800037fc:	f8f648e3          	blt	a2,a5,8000378c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x154>
80003800:	fff68693          	addi	a3,a3,-1
80003804:	f80682e3          	beqz	a3,80003788 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x150>
80003808:	feb6e6e3          	bltu	a3,a1,800037f4 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1bc>
8000380c:	fed59ae3          	bne	a1,a3,80003800 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1c8>
80003810:	80005537          	lui	a0,0x80005
80003814:	ae850513          	addi	a0,a0,-1304 # 80004ae8 <ebss+0xffffdae8>
80003818:	02b00593          	li	a1,43
8000381c:	00070613          	mv	a2,a4
80003820:	ffffe097          	auipc	ra,0xffffe
80003824:	084080e7          	jalr	132(ra) # 800018a4 <_ZN4core9panicking5panic17h6e58be21c8262ebcE>
80003828:	c0001073          	unimp
8000382c:	00b50533          	add	a0,a0,a1
80003830:	00178593          	addi	a1,a5,1
80003834:	02a59263          	bne	a1,a0,80003858 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x220>
80003838:	00000793          	li	a5,0
8000383c:	00050593          	mv	a1,a0
80003840:	0df00613          	li	a2,223
80003844:	01f2f813          	andi	a6,t0,31
80003848:	02566463          	bltu	a2,t0,80003870 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x238>
8000384c:	00681513          	slli	a0,a6,0x6
80003850:	00a7e533          	or	a0,a5,a0
80003854:	0840006f          	j	800038d8 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x2a0>
80003858:	0017c603          	lbu	a2,1(a5)
8000385c:	00278593          	addi	a1,a5,2
80003860:	03f67793          	andi	a5,a2,63
80003864:	0df00613          	li	a2,223
80003868:	01f2f813          	andi	a6,t0,31
8000386c:	fe5670e3          	bgeu	a2,t0,8000384c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x214>
80003870:	00a59863          	bne	a1,a0,80003880 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x248>
80003874:	00000593          	li	a1,0
80003878:	00050893          	mv	a7,a0
8000387c:	0100006f          	j	8000388c <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x254>
80003880:	0005c603          	lbu	a2,0(a1)
80003884:	00158893          	addi	a7,a1,1
80003888:	03f67593          	andi	a1,a2,63
8000388c:	00679613          	slli	a2,a5,0x6
80003890:	0f000313          	li	t1,240
80003894:	00c5e7b3          	or	a5,a1,a2
80003898:	0062e863          	bltu	t0,t1,800038a8 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x270>
8000389c:	00a89c63          	bne	a7,a0,800038b4 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x27c>
800038a0:	00000513          	li	a0,0
800038a4:	0180006f          	j	800038bc <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x284>
800038a8:	00c81513          	slli	a0,a6,0xc
800038ac:	00a7e533          	or	a0,a5,a0
800038b0:	0280006f          	j	800038d8 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x2a0>
800038b4:	0008c503          	lbu	a0,0(a7)
800038b8:	03f57513          	andi	a0,a0,63
800038bc:	01d81593          	slli	a1,a6,0x1d
800038c0:	00b5d593          	srli	a1,a1,0xb
800038c4:	00679613          	slli	a2,a5,0x6
800038c8:	00b665b3          	or	a1,a2,a1
800038cc:	00a5e533          	or	a0,a1,a0
800038d0:	001105b7          	lui	a1,0x110
800038d4:	f2b50ee3          	beq	a0,a1,80003810 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x1d8>
800038d8:	00a12e23          	sw	a0,28(sp)
800038dc:	08000613          	li	a2,128
800038e0:	00100593          	li	a1,1
800038e4:	02c56063          	bltu	a0,a2,80003904 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x2cc>
800038e8:	00b55613          	srli	a2,a0,0xb
800038ec:	00200593          	li	a1,2
800038f0:	00060a63          	beqz	a2,80003904 <_ZN4core3str16slice_error_fail17hd401c1b4bf636e39E+0x2cc>
800038f4:	01055513          	srli	a0,a0,0x10
800038f8:	00153513          	seqz	a0,a0
800038fc:	00400593          	li	a1,4
80003900:	40a585b3          	sub	a1,a1,a0
80003904:	00d58533          	add	a0,a1,a3
80003908:	02d12023          	sw	a3,32(sp)
8000390c:	02a12223          	sw	a0,36(sp)
80003910:	01810513          	addi	a0,sp,24
80003914:	04a12023          	sw	a0,64(sp)
80003918:	80004537          	lui	a0,0x80004
8000391c:	fd450513          	addi	a0,a0,-44 # 80003fd4 <ebss+0xffffcfd4>
80003920:	04a12223          	sw	a0,68(sp)
80003924:	01c10513          	addi	a0,sp,28
80003928:	04a12423          	sw	a0,72(sp)
8000392c:	80003537          	lui	a0,0x80003
80003930:	fec50513          	addi	a0,a0,-20 # 80002fec <ebss+0xffffbfec>
80003934:	04a12623          	sw	a0,76(sp)
80003938:	02010513          	addi	a0,sp,32
8000393c:	04a12823          	sw	a0,80(sp)
80003940:	80001537          	lui	a0,0x80001
80003944:	67450513          	addi	a0,a0,1652 # 80001674 <ebss+0xffffa674>
80003948:	04a12a23          	sw	a0,84(sp)
8000394c:	00810513          	addi	a0,sp,8
80003950:	04a12c23          	sw	a0,88(sp)
80003954:	80004537          	lui	a0,0x80004
80003958:	01450513          	addi	a0,a0,20 # 80004014 <ebss+0xffffd014>
8000395c:	04a12e23          	sw	a0,92(sp)
80003960:	01010593          	addi	a1,sp,16
80003964:	06b12023          	sw	a1,96(sp)
80003968:	06a12223          	sw	a0,100(sp)
8000396c:	80005537          	lui	a0,0x80005
80003970:	e5850513          	addi	a0,a0,-424 # 80004e58 <ebss+0xffffde58>
80003974:	02a12423          	sw	a0,40(sp)
80003978:	00500513          	li	a0,5
8000397c:	02a12623          	sw	a0,44(sp)
80003980:	02012823          	sw	zero,48(sp)
80003984:	04010593          	addi	a1,sp,64
80003988:	02b12c23          	sw	a1,56(sp)
8000398c:	02a12e23          	sw	a0,60(sp)
80003990:	02810513          	addi	a0,sp,40
80003994:	00070593          	mv	a1,a4
80003998:	ffffe097          	auipc	ra,0xffffe
8000399c:	fbc080e7          	jalr	-68(ra) # 80001954 <_ZN4core9panicking9panic_fmt17hc95f801ab13a3e8cE>
800039a0:	c0001073          	unimp

800039a4 <_ZN4core7unicode9printable5check17h9caae249355430a0E>:
800039a4:	ff010113          	addi	sp,sp,-16
800039a8:	00112623          	sw	ra,12(sp)
800039ac:	06060c63          	beqz	a2,80003a24 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x80>
800039b0:	00000293          	li	t0,0
800039b4:	01051893          	slli	a7,a0,0x10
800039b8:	0188d313          	srli	t1,a7,0x18
800039bc:	00161613          	slli	a2,a2,0x1
800039c0:	00c583b3          	add	t2,a1,a2
800039c4:	0ff57e13          	andi	t3,a0,255
800039c8:	01c0006f          	j	800039e4 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x40>
800039cc:	01d332b3          	sltu	t0,t1,t4
800039d0:	0075c633          	xor	a2,a1,t2
800039d4:	00163613          	seqz	a2,a2
800039d8:	00c2e633          	or	a2,t0,a2
800039dc:	00088293          	mv	t0,a7
800039e0:	04061263          	bnez	a2,80003a24 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x80>
800039e4:	0005ce83          	lbu	t4,0(a1) # 110000 <.Lline_table_start0+0xe566d>
800039e8:	0015c603          	lbu	a2,1(a1)
800039ec:	00258593          	addi	a1,a1,2
800039f0:	00c288b3          	add	a7,t0,a2
800039f4:	fc6e9ce3          	bne	t4,t1,800039cc <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x28>
800039f8:	0e58e463          	bltu	a7,t0,80003ae0 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x13c>
800039fc:	11176063          	bltu	a4,a7,80003afc <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x158>
80003a00:	005682b3          	add	t0,a3,t0
80003a04:	00060c63          	beqz	a2,80003a1c <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x78>
80003a08:	0002ce83          	lbu	t4,0(t0)
80003a0c:	00128293          	addi	t0,t0,1
80003a10:	fff60613          	addi	a2,a2,-1
80003a14:	ffce98e3          	bne	t4,t3,80003a04 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x60>
80003a18:	0800006f          	j	80003a98 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0xf4>
80003a1c:	00088293          	mv	t0,a7
80003a20:	fc7592e3          	bne	a1,t2,800039e4 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x40>
80003a24:	08080463          	beqz	a6,80003aac <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x108>
80003a28:	01078833          	add	a6,a5,a6
80003a2c:	000105b7          	lui	a1,0x10
80003a30:	fff58593          	addi	a1,a1,-1 # ffff <.Lline_table_start0+0xffff>
80003a34:	00b57633          	and	a2,a0,a1
80003a38:	00100513          	li	a0,1
80003a3c:	0007c683          	lbu	a3,0(a5)
80003a40:	01869593          	slli	a1,a3,0x18
80003a44:	4185d713          	srai	a4,a1,0x18
80003a48:	00178593          	addi	a1,a5,1
80003a4c:	00074a63          	bltz	a4,80003a60 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0xbc>
80003a50:	00058793          	mv	a5,a1
80003a54:	40d60633          	sub	a2,a2,a3
80003a58:	02065463          	bgez	a2,80003a80 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0xdc>
80003a5c:	02c0006f          	j	80003a88 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0xe4>
80003a60:	07058063          	beq	a1,a6,80003ac0 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x11c>
80003a64:	0017c583          	lbu	a1,1(a5)
80003a68:	07f77693          	andi	a3,a4,127
80003a6c:	00869693          	slli	a3,a3,0x8
80003a70:	00278793          	addi	a5,a5,2
80003a74:	00b6e6b3          	or	a3,a3,a1
80003a78:	40d60633          	sub	a2,a2,a3
80003a7c:	00064663          	bltz	a2,80003a88 <_ZN4core7unicode9printable5check17h9caae249355430a0E+0xe4>
80003a80:	00154513          	xori	a0,a0,1
80003a84:	fb079ce3          	bne	a5,a6,80003a3c <_ZN4core7unicode9printable5check17h9caae249355430a0E+0x98>
80003a88:	00157513          	andi	a0,a0,1
80003a8c:	00c12083          	lw	ra,12(sp)
80003a90:	01010113          	addi	sp,sp,16
80003a94:	00008067          	ret
80003a98:	00000513          	li	a0,0
80003a9c:	00157513          	andi	a0,a0,1
80003aa0:	00c12083          	lw	ra,12(sp)
80003aa4:	01010113          	addi	sp,sp,16
80003aa8:	00008067          	ret
80003aac:	00100513          	li	a0,1
80003ab0:	00157513          	andi	a0,a0,1
80003ab4:	00c12083          	lw	ra,12(sp)
80003ab8:	01010113          	addi	sp,sp,16
80003abc:	00008067          	ret
80003ac0:	80005537          	lui	a0,0x80005
80003ac4:	ae850513          	addi	a0,a0,-1304 # 80004ae8 <ebss+0xffffdae8>
80003ac8:	800055b7          	lui	a1,0x80005
80003acc:	eb858613          	addi	a2,a1,-328 # 80004eb8 <ebss+0xffffdeb8>
80003ad0:	02b00593          	li	a1,43
80003ad4:	ffffe097          	auipc	ra,0xffffe
80003ad8:	dd0080e7          	jalr	-560(ra) # 800018a4 <_ZN4core9panicking5panic17h6e58be21c8262ebcE>
80003adc:	c0001073          	unimp
80003ae0:	80005537          	lui	a0,0x80005
80003ae4:	ea850613          	addi	a2,a0,-344 # 80004ea8 <ebss+0xffffdea8>
80003ae8:	00028513          	mv	a0,t0
80003aec:	00088593          	mv	a1,a7
80003af0:	00000097          	auipc	ra,0x0
80003af4:	ae0080e7          	jalr	-1312(ra) # 800035d0 <_ZN4core5slice5index22slice_index_order_fail17hef60e0092a3ca143E>
80003af8:	c0001073          	unimp
80003afc:	80005537          	lui	a0,0x80005
80003b00:	ea850613          	addi	a2,a0,-344 # 80004ea8 <ebss+0xffffdea8>
80003b04:	00088513          	mv	a0,a7
80003b08:	00070593          	mv	a1,a4
80003b0c:	00000097          	auipc	ra,0x0
80003b10:	a5c080e7          	jalr	-1444(ra) # 80003568 <_ZN4core5slice5index24slice_end_index_len_fail17habe52d70a9383759E>
80003b14:	c0001073          	unimp

80003b18 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17he3a030007845ea13E>:
80003b18:	f7010113          	addi	sp,sp,-144
80003b1c:	08112623          	sw	ra,140(sp)
80003b20:	00058813          	mv	a6,a1
80003b24:	00000593          	li	a1,0
80003b28:	00052703          	lw	a4,0(a0)
80003b2c:	00c10893          	addi	a7,sp,12
80003b30:	00a00293          	li	t0,10
80003b34:	00f00313          	li	t1,15
80003b38:	01c0006f          	j	80003b54 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17he3a030007845ea13E+0x3c>
80003b3c:	00b886b3          	add	a3,a7,a1
80003b40:	00455713          	srli	a4,a0,0x4
80003b44:	00f60633          	add	a2,a2,a5
80003b48:	06c68fa3          	sb	a2,127(a3)
80003b4c:	fff58593          	addi	a1,a1,-1
80003b50:	00a37e63          	bgeu	t1,a0,80003b6c <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17he3a030007845ea13E+0x54>
80003b54:	00070513          	mv	a0,a4
80003b58:	00f77793          	andi	a5,a4,15
80003b5c:	03000613          	li	a2,48
80003b60:	fc57eee3          	bltu	a5,t0,80003b3c <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17he3a030007845ea13E+0x24>
80003b64:	05700613          	li	a2,87
80003b68:	fd5ff06f          	j	80003b3c <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17he3a030007845ea13E+0x24>
80003b6c:	08058513          	addi	a0,a1,128
80003b70:	08100613          	li	a2,129
80003b74:	02c57e63          	bgeu	a0,a2,80003bb0 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17he3a030007845ea13E+0x98>
80003b78:	40b007b3          	neg	a5,a1
80003b7c:	00c10513          	addi	a0,sp,12
80003b80:	00b50533          	add	a0,a0,a1
80003b84:	08050713          	addi	a4,a0,128
80003b88:	80005537          	lui	a0,0x80005
80003b8c:	c0c50613          	addi	a2,a0,-1012 # 80004c0c <ebss+0xffffdc0c>
80003b90:	00100593          	li	a1,1
80003b94:	00200693          	li	a3,2
80003b98:	00080513          	mv	a0,a6
80003b9c:	fffff097          	auipc	ra,0xfffff
80003ba0:	ba4080e7          	jalr	-1116(ra) # 80002740 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE>
80003ba4:	08c12083          	lw	ra,140(sp)
80003ba8:	09010113          	addi	sp,sp,144
80003bac:	00008067          	ret
80003bb0:	800055b7          	lui	a1,0x80005
80003bb4:	bfc58613          	addi	a2,a1,-1028 # 80004bfc <ebss+0xffffdbfc>
80003bb8:	08000593          	li	a1,128
80003bbc:	00000097          	auipc	ra,0x0
80003bc0:	944080e7          	jalr	-1724(ra) # 80003500 <_ZN4core5slice5index26slice_start_index_len_fail17h00e5ce03f9138bcfE>
80003bc4:	c0001073          	unimp

80003bc8 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2703b71c89cf64d6E>:
80003bc8:	f7010113          	addi	sp,sp,-144
80003bcc:	08112623          	sw	ra,140(sp)
80003bd0:	00058813          	mv	a6,a1
80003bd4:	00000593          	li	a1,0
80003bd8:	00052703          	lw	a4,0(a0)
80003bdc:	00c10893          	addi	a7,sp,12
80003be0:	00a00293          	li	t0,10
80003be4:	00f00313          	li	t1,15
80003be8:	01c0006f          	j	80003c04 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2703b71c89cf64d6E+0x3c>
80003bec:	00b886b3          	add	a3,a7,a1
80003bf0:	00455713          	srli	a4,a0,0x4
80003bf4:	00f60633          	add	a2,a2,a5
80003bf8:	06c68fa3          	sb	a2,127(a3)
80003bfc:	fff58593          	addi	a1,a1,-1
80003c00:	00a37e63          	bgeu	t1,a0,80003c1c <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2703b71c89cf64d6E+0x54>
80003c04:	00070513          	mv	a0,a4
80003c08:	00f77793          	andi	a5,a4,15
80003c0c:	03000613          	li	a2,48
80003c10:	fc57eee3          	bltu	a5,t0,80003bec <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2703b71c89cf64d6E+0x24>
80003c14:	03700613          	li	a2,55
80003c18:	fd5ff06f          	j	80003bec <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2703b71c89cf64d6E+0x24>
80003c1c:	08058513          	addi	a0,a1,128
80003c20:	08100613          	li	a2,129
80003c24:	02c57e63          	bgeu	a0,a2,80003c60 <_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h2703b71c89cf64d6E+0x98>
80003c28:	40b007b3          	neg	a5,a1
80003c2c:	00c10513          	addi	a0,sp,12
80003c30:	00b50533          	add	a0,a0,a1
80003c34:	08050713          	addi	a4,a0,128
80003c38:	80005537          	lui	a0,0x80005
80003c3c:	c0c50613          	addi	a2,a0,-1012 # 80004c0c <ebss+0xffffdc0c>
80003c40:	00100593          	li	a1,1
80003c44:	00200693          	li	a3,2
80003c48:	00080513          	mv	a0,a6
80003c4c:	fffff097          	auipc	ra,0xfffff
80003c50:	af4080e7          	jalr	-1292(ra) # 80002740 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE>
80003c54:	08c12083          	lw	ra,140(sp)
80003c58:	09010113          	addi	sp,sp,144
80003c5c:	00008067          	ret
80003c60:	800055b7          	lui	a1,0x80005
80003c64:	bfc58613          	addi	a2,a1,-1028 # 80004bfc <ebss+0xffffdbfc>
80003c68:	08000593          	li	a1,128
80003c6c:	00000097          	auipc	ra,0x0
80003c70:	894080e7          	jalr	-1900(ra) # 80003500 <_ZN4core5slice5index26slice_start_index_len_fail17h00e5ce03f9138bcfE>
80003c74:	c0001073          	unimp

80003c78 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E>:
80003c78:	f7010113          	addi	sp,sp,-144
80003c7c:	08112623          	sw	ra,140(sp)
80003c80:	00058813          	mv	a6,a1
80003c84:	0005a583          	lw	a1,0(a1)
80003c88:	0105f613          	andi	a2,a1,16
80003c8c:	02061463          	bnez	a2,80003cb4 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x3c>
80003c90:	0205f593          	andi	a1,a1,32
80003c94:	06059463          	bnez	a1,80003cfc <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x84>
80003c98:	00052503          	lw	a0,0(a0)
80003c9c:	00100593          	li	a1,1
80003ca0:	00080613          	mv	a2,a6
80003ca4:	08c12083          	lw	ra,140(sp)
80003ca8:	09010113          	addi	sp,sp,144
80003cac:	00000317          	auipc	t1,0x0
80003cb0:	0f430067          	jr	244(t1) # 80003da0 <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E>
80003cb4:	00000593          	li	a1,0
80003cb8:	00052703          	lw	a4,0(a0)
80003cbc:	00c10893          	addi	a7,sp,12
80003cc0:	00a00293          	li	t0,10
80003cc4:	00f00313          	li	t1,15
80003cc8:	01c0006f          	j	80003ce4 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x6c>
80003ccc:	00b886b3          	add	a3,a7,a1
80003cd0:	00455713          	srli	a4,a0,0x4
80003cd4:	00f60633          	add	a2,a2,a5
80003cd8:	06c68fa3          	sb	a2,127(a3)
80003cdc:	fff58593          	addi	a1,a1,-1
80003ce0:	06a37263          	bgeu	t1,a0,80003d44 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0xcc>
80003ce4:	00070513          	mv	a0,a4
80003ce8:	00f77793          	andi	a5,a4,15
80003cec:	03000613          	li	a2,48
80003cf0:	fc57eee3          	bltu	a5,t0,80003ccc <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x54>
80003cf4:	05700613          	li	a2,87
80003cf8:	fd5ff06f          	j	80003ccc <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x54>
80003cfc:	00000593          	li	a1,0
80003d00:	00052703          	lw	a4,0(a0)
80003d04:	00c10893          	addi	a7,sp,12
80003d08:	00a00293          	li	t0,10
80003d0c:	00f00313          	li	t1,15
80003d10:	01c0006f          	j	80003d2c <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0xb4>
80003d14:	00b886b3          	add	a3,a7,a1
80003d18:	00455713          	srli	a4,a0,0x4
80003d1c:	00f60633          	add	a2,a2,a5
80003d20:	06c68fa3          	sb	a2,127(a3)
80003d24:	fff58593          	addi	a1,a1,-1
80003d28:	00a37e63          	bgeu	t1,a0,80003d44 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0xcc>
80003d2c:	00070513          	mv	a0,a4
80003d30:	00f77793          	andi	a5,a4,15
80003d34:	03000613          	li	a2,48
80003d38:	fc57eee3          	bltu	a5,t0,80003d14 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x9c>
80003d3c:	03700613          	li	a2,55
80003d40:	fd5ff06f          	j	80003d14 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x9c>
80003d44:	08058513          	addi	a0,a1,128
80003d48:	08100613          	li	a2,129
80003d4c:	02c57e63          	bgeu	a0,a2,80003d88 <_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hfd814709e36eee44E+0x110>
80003d50:	40b007b3          	neg	a5,a1
80003d54:	00c10513          	addi	a0,sp,12
80003d58:	00b50533          	add	a0,a0,a1
80003d5c:	08050713          	addi	a4,a0,128
80003d60:	80005537          	lui	a0,0x80005
80003d64:	c0c50613          	addi	a2,a0,-1012 # 80004c0c <ebss+0xffffdc0c>
80003d68:	00100593          	li	a1,1
80003d6c:	00200693          	li	a3,2
80003d70:	00080513          	mv	a0,a6
80003d74:	fffff097          	auipc	ra,0xfffff
80003d78:	9cc080e7          	jalr	-1588(ra) # 80002740 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE>
80003d7c:	08c12083          	lw	ra,140(sp)
80003d80:	09010113          	addi	sp,sp,144
80003d84:	00008067          	ret
80003d88:	800055b7          	lui	a1,0x80005
80003d8c:	bfc58613          	addi	a2,a1,-1028 # 80004bfc <ebss+0xffffdbfc>
80003d90:	08000593          	li	a1,128
80003d94:	fffff097          	auipc	ra,0xfffff
80003d98:	76c080e7          	jalr	1900(ra) # 80003500 <_ZN4core5slice5index26slice_start_index_len_fail17h00e5ce03f9138bcfE>
80003d9c:	c0001073          	unimp

80003da0 <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E>:
80003da0:	fa010113          	addi	sp,sp,-96
80003da4:	04112e23          	sw	ra,92(sp)
80003da8:	04812c23          	sw	s0,88(sp)
80003dac:	04912a23          	sw	s1,84(sp)
80003db0:	05212823          	sw	s2,80(sp)
80003db4:	05312623          	sw	s3,76(sp)
80003db8:	05412423          	sw	s4,72(sp)
80003dbc:	05512223          	sw	s5,68(sp)
80003dc0:	05612023          	sw	s6,64(sp)
80003dc4:	03712e23          	sw	s7,60(sp)
80003dc8:	03812c23          	sw	s8,56(sp)
80003dcc:	03912a23          	sw	s9,52(sp)
80003dd0:	03a12823          	sw	s10,48(sp)
80003dd4:	03b12623          	sw	s11,44(sp)
80003dd8:	00060913          	mv	s2,a2
80003ddc:	00058993          	mv	s3,a1
80003de0:	00050a93          	mv	s5,a0
80003de4:	00455513          	srli	a0,a0,0x4
80003de8:	27100593          	li	a1,625
80003dec:	02700413          	li	s0,39
80003df0:	02b57663          	bgeu	a0,a1,80003e1c <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E+0x7c>
80003df4:	06300513          	li	a0,99
80003df8:	0f554063          	blt	a0,s5,80003ed8 <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E+0x138>
80003dfc:	00a00513          	li	a0,10
80003e00:	14aad063          	bge	s5,a0,80003f40 <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E+0x1a0>
80003e04:	fff40513          	addi	a0,s0,-1
80003e08:	00510593          	addi	a1,sp,5
80003e0c:	00a585b3          	add	a1,a1,a0
80003e10:	030a8613          	addi	a2,s5,48
80003e14:	00c58023          	sb	a2,0(a1)
80003e18:	1540006f          	j	80003f6c <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E+0x1cc>
80003e1c:	00000493          	li	s1,0
80003e20:	00002537          	lui	a0,0x2
80003e24:	71050a13          	addi	s4,a0,1808 # 2710 <.Lline_table_start0+0x2710>
80003e28:	00010537          	lui	a0,0x10
80003e2c:	fff50b13          	addi	s6,a0,-1 # ffff <.Lline_table_start0+0xffff>
80003e30:	80005537          	lui	a0,0x80005
80003e34:	c0e50b93          	addi	s7,a0,-1010 # 80004c0e <ebss+0xffffdc0e>
80003e38:	00510c13          	addi	s8,sp,5
80003e3c:	05f5e537          	lui	a0,0x5f5e
80003e40:	0ff50c93          	addi	s9,a0,255 # 5f5e0ff <.Lline_table_start0+0x5f3376c>
80003e44:	000a8d13          	mv	s10,s5
80003e48:	000a8513          	mv	a0,s5
80003e4c:	000a0593          	mv	a1,s4
80003e50:	00000097          	auipc	ra,0x0
80003e54:	3d4080e7          	jalr	980(ra) # 80004224 <__udivsi3>
80003e58:	00050a93          	mv	s5,a0
80003e5c:	000a0593          	mv	a1,s4
80003e60:	00000097          	auipc	ra,0x0
80003e64:	4ec080e7          	jalr	1260(ra) # 8000434c <__mulsi3>
80003e68:	40ad0433          	sub	s0,s10,a0
80003e6c:	01647533          	and	a0,s0,s6
80003e70:	06400593          	li	a1,100
80003e74:	00000097          	auipc	ra,0x0
80003e78:	3b0080e7          	jalr	944(ra) # 80004224 <__udivsi3>
80003e7c:	00151d93          	slli	s11,a0,0x1
80003e80:	06400593          	li	a1,100
80003e84:	00000097          	auipc	ra,0x0
80003e88:	4c8080e7          	jalr	1224(ra) # 8000434c <__mulsi3>
80003e8c:	40a40533          	sub	a0,s0,a0
80003e90:	01151513          	slli	a0,a0,0x11
80003e94:	01055513          	srli	a0,a0,0x10
80003e98:	017d85b3          	add	a1,s11,s7
80003e9c:	009c0633          	add	a2,s8,s1
80003ea0:	0005c683          	lbu	a3,0(a1)
80003ea4:	00158583          	lb	a1,1(a1)
80003ea8:	01750533          	add	a0,a0,s7
80003eac:	00150703          	lb	a4,1(a0)
80003eb0:	00054503          	lbu	a0,0(a0)
80003eb4:	02b60223          	sb	a1,36(a2)
80003eb8:	02d601a3          	sb	a3,35(a2)
80003ebc:	02e60323          	sb	a4,38(a2)
80003ec0:	02a602a3          	sb	a0,37(a2)
80003ec4:	ffc48493          	addi	s1,s1,-4
80003ec8:	f7aceee3          	bltu	s9,s10,80003e44 <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E+0xa4>
80003ecc:	02748413          	addi	s0,s1,39
80003ed0:	06300513          	li	a0,99
80003ed4:	f35554e3          	bge	a0,s5,80003dfc <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E+0x5c>
80003ed8:	00010537          	lui	a0,0x10
80003edc:	fff50513          	addi	a0,a0,-1 # ffff <.Lline_table_start0+0xffff>
80003ee0:	00aaf533          	and	a0,s5,a0
80003ee4:	06400593          	li	a1,100
80003ee8:	00000097          	auipc	ra,0x0
80003eec:	33c080e7          	jalr	828(ra) # 80004224 <__udivsi3>
80003ef0:	00050a13          	mv	s4,a0
80003ef4:	06400593          	li	a1,100
80003ef8:	00000097          	auipc	ra,0x0
80003efc:	454080e7          	jalr	1108(ra) # 8000434c <__mulsi3>
80003f00:	40aa8533          	sub	a0,s5,a0
80003f04:	01151513          	slli	a0,a0,0x11
80003f08:	01055513          	srli	a0,a0,0x10
80003f0c:	ffe40413          	addi	s0,s0,-2
80003f10:	800055b7          	lui	a1,0x80005
80003f14:	c0e58593          	addi	a1,a1,-1010 # 80004c0e <ebss+0xffffdc0e>
80003f18:	00b50533          	add	a0,a0,a1
80003f1c:	00150583          	lb	a1,1(a0)
80003f20:	00054503          	lbu	a0,0(a0)
80003f24:	00510613          	addi	a2,sp,5
80003f28:	00860633          	add	a2,a2,s0
80003f2c:	00b600a3          	sb	a1,1(a2)
80003f30:	00a60023          	sb	a0,0(a2)
80003f34:	000a0a93          	mv	s5,s4
80003f38:	00a00513          	li	a0,10
80003f3c:	ecaac4e3          	blt	s5,a0,80003e04 <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E+0x64>
80003f40:	001a9593          	slli	a1,s5,0x1
80003f44:	ffe40513          	addi	a0,s0,-2
80003f48:	80005637          	lui	a2,0x80005
80003f4c:	c0e60613          	addi	a2,a2,-1010 # 80004c0e <ebss+0xffffdc0e>
80003f50:	00c585b3          	add	a1,a1,a2
80003f54:	00158603          	lb	a2,1(a1)
80003f58:	0005c583          	lbu	a1,0(a1)
80003f5c:	00510693          	addi	a3,sp,5
80003f60:	00a686b3          	add	a3,a3,a0
80003f64:	00c680a3          	sb	a2,1(a3)
80003f68:	00b68023          	sb	a1,0(a3)
80003f6c:	00510593          	addi	a1,sp,5
80003f70:	00a58733          	add	a4,a1,a0
80003f74:	02700593          	li	a1,39
80003f78:	40a587b3          	sub	a5,a1,a0
80003f7c:	80005537          	lui	a0,0x80005
80003f80:	ad450613          	addi	a2,a0,-1324 # 80004ad4 <ebss+0xffffdad4>
80003f84:	00090513          	mv	a0,s2
80003f88:	00098593          	mv	a1,s3
80003f8c:	00000693          	li	a3,0
80003f90:	ffffe097          	auipc	ra,0xffffe
80003f94:	7b0080e7          	jalr	1968(ra) # 80002740 <_ZN4core3fmt9Formatter12pad_integral17hffec0aad4097a9caE>
80003f98:	02c12d83          	lw	s11,44(sp)
80003f9c:	03012d03          	lw	s10,48(sp)
80003fa0:	03412c83          	lw	s9,52(sp)
80003fa4:	03812c03          	lw	s8,56(sp)
80003fa8:	03c12b83          	lw	s7,60(sp)
80003fac:	04012b03          	lw	s6,64(sp)
80003fb0:	04412a83          	lw	s5,68(sp)
80003fb4:	04812a03          	lw	s4,72(sp)
80003fb8:	04c12983          	lw	s3,76(sp)
80003fbc:	05012903          	lw	s2,80(sp)
80003fc0:	05412483          	lw	s1,84(sp)
80003fc4:	05812403          	lw	s0,88(sp)
80003fc8:	05c12083          	lw	ra,92(sp)
80003fcc:	06010113          	addi	sp,sp,96
80003fd0:	00008067          	ret

80003fd4 <_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17hf0e441e4f1f8f3a3E>:
80003fd4:	00052503          	lw	a0,0(a0)
80003fd8:	00058613          	mv	a2,a1
80003fdc:	00100593          	li	a1,1
80003fe0:	00000317          	auipc	t1,0x0
80003fe4:	dc030067          	jr	-576(t1) # 80003da0 <_ZN4core3fmt3num3imp7fmt_u3217hbc1562d0c47ac3f2E>

80003fe8 <_ZN53_$LT$core..fmt..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h15719166da781f67E>:
80003fe8:	01c5a603          	lw	a2,28(a1)
80003fec:	0185a503          	lw	a0,24(a1)
80003ff0:	00c62783          	lw	a5,12(a2)
80003ff4:	800055b7          	lui	a1,0x80005
80003ff8:	48c58593          	addi	a1,a1,1164 # 8000548c <ebss+0xffffe48c>
80003ffc:	00500613          	li	a2,5
80004000:	00078067          	jr	a5

80004004 <_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h3f52513a76580b52E>:
80004004:	00452603          	lw	a2,4(a0)
80004008:	00052503          	lw	a0,0(a0)
8000400c:	00c62783          	lw	a5,12(a2)
80004010:	00078067          	jr	a5

80004014 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h1781a2cba79b8ec1E>:
80004014:	00052683          	lw	a3,0(a0)
80004018:	00452603          	lw	a2,4(a0)
8000401c:	00058513          	mv	a0,a1
80004020:	00068593          	mv	a1,a3
80004024:	fffff317          	auipc	t1,0xfffff
80004028:	b3c30067          	jr	-1220(t1) # 80002b60 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E>

8000402c <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17h1ba5312d7b96de56E>:
8000402c:	fe010113          	addi	sp,sp,-32
80004030:	00112e23          	sw	ra,28(sp)
80004034:	00052603          	lw	a2,0(a0)
80004038:	01462503          	lw	a0,20(a2)
8000403c:	00a12a23          	sw	a0,20(sp)
80004040:	01062503          	lw	a0,16(a2)
80004044:	00a12823          	sw	a0,16(sp)
80004048:	00c62503          	lw	a0,12(a2)
8000404c:	00a12623          	sw	a0,12(sp)
80004050:	00862503          	lw	a0,8(a2)
80004054:	00a12423          	sw	a0,8(sp)
80004058:	00462683          	lw	a3,4(a2)
8000405c:	0185a503          	lw	a0,24(a1)
80004060:	00d12223          	sw	a3,4(sp)
80004064:	00062603          	lw	a2,0(a2)
80004068:	01c5a583          	lw	a1,28(a1)
8000406c:	00c12023          	sw	a2,0(sp)
80004070:	00010613          	mv	a2,sp
80004074:	ffffe097          	auipc	ra,0xffffe
80004078:	460080e7          	jalr	1120(ra) # 800024d4 <_ZN4core3fmt5write17hc9cc6c7de730469dE>
8000407c:	01c12083          	lw	ra,28(sp)
80004080:	02010113          	addi	sp,sp,32
80004084:	00008067          	ret

80004088 <_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hc15e38ee1032a5afE>:
80004088:	00052503          	lw	a0,0(a0)
8000408c:	00052683          	lw	a3,0(a0)
80004090:	00452603          	lw	a2,4(a0)
80004094:	00058513          	mv	a0,a1
80004098:	00068593          	mv	a1,a3
8000409c:	fffff317          	auipc	t1,0xfffff
800040a0:	ac430067          	jr	-1340(t1) # 80002b60 <_ZN4core3fmt9Formatter3pad17h8de85b98d3deab22E>

800040a4 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E>:
800040a4:	ff010113          	addi	sp,sp,-16
800040a8:	00112623          	sw	ra,12(sp)
800040ac:	00000713          	li	a4,0
800040b0:	00b51593          	slli	a1,a0,0xb
800040b4:	02000793          	li	a5,32
800040b8:	80005637          	lui	a2,0x80005
800040bc:	49460813          	addi	a6,a2,1172 # 80005494 <ebss+0xffffe494>
800040c0:	02000693          	li	a3,32
800040c4:	0100006f          	j	800040d4 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x30>
800040c8:	00178713          	addi	a4,a5,1
800040cc:	40e687b3          	sub	a5,a3,a4
800040d0:	02d77c63          	bgeu	a4,a3,80004108 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x64>
800040d4:	0017d613          	srli	a2,a5,0x1
800040d8:	00e607b3          	add	a5,a2,a4
800040dc:	00279613          	slli	a2,a5,0x2
800040e0:	01060633          	add	a2,a2,a6
800040e4:	00062603          	lw	a2,0(a2)
800040e8:	00b61613          	slli	a2,a2,0xb
800040ec:	fcb66ee3          	bltu	a2,a1,800040c8 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x24>
800040f0:	00b60a63          	beq	a2,a1,80004104 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x60>
800040f4:	00078693          	mv	a3,a5
800040f8:	40e687b3          	sub	a5,a3,a4
800040fc:	fcd76ce3          	bltu	a4,a3,800040d4 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x30>
80004100:	0080006f          	j	80004108 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x64>
80004104:	00178713          	addi	a4,a5,1
80004108:	01f00693          	li	a3,31
8000410c:	0ee6e063          	bltu	a3,a4,800041ec <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x148>
80004110:	800055b7          	lui	a1,0x80005
80004114:	49458613          	addi	a2,a1,1172 # 80005494 <ebss+0xffffe494>
80004118:	00271793          	slli	a5,a4,0x2
8000411c:	2c300593          	li	a1,707
80004120:	00d70863          	beq	a4,a3,80004130 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x8c>
80004124:	00f605b3          	add	a1,a2,a5
80004128:	0045a583          	lw	a1,4(a1)
8000412c:	0155d593          	srli	a1,a1,0x15
80004130:	fff70693          	addi	a3,a4,-1
80004134:	00d77663          	bgeu	a4,a3,80004140 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x9c>
80004138:	00000713          	li	a4,0
8000413c:	02c0006f          	j	80004168 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0xc4>
80004140:	02000713          	li	a4,32
80004144:	0ce6f263          	bgeu	a3,a4,80004208 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x164>
80004148:	80005737          	lui	a4,0x80005
8000414c:	49470713          	addi	a4,a4,1172 # 80005494 <ebss+0xffffe494>
80004150:	00269693          	slli	a3,a3,0x2
80004154:	00e686b3          	add	a3,a3,a4
80004158:	0006a683          	lw	a3,0(a3)
8000415c:	00200737          	lui	a4,0x200
80004160:	fff70713          	addi	a4,a4,-1 # 1fffff <.Lline_table_start0+0x1d566c>
80004164:	00e6f733          	and	a4,a3,a4
80004168:	00c78633          	add	a2,a5,a2
8000416c:	00062603          	lw	a2,0(a2)
80004170:	01565613          	srli	a2,a2,0x15
80004174:	00160693          	addi	a3,a2,1
80004178:	04d58463          	beq	a1,a3,800041c0 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x11c>
8000417c:	2c300793          	li	a5,707
80004180:	00060813          	mv	a6,a2
80004184:	00c7e463          	bltu	a5,a2,8000418c <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0xe8>
80004188:	2c300813          	li	a6,707
8000418c:	00000793          	li	a5,0
80004190:	40e50733          	sub	a4,a0,a4
80004194:	fff58513          	addi	a0,a1,-1
80004198:	800055b7          	lui	a1,0x80005
8000419c:	51458593          	addi	a1,a1,1300 # 80005514 <ebss+0xffffe514>
800041a0:	02c80863          	beq	a6,a2,800041d0 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x12c>
800041a4:	00b606b3          	add	a3,a2,a1
800041a8:	0006c683          	lbu	a3,0(a3)
800041ac:	00d787b3          	add	a5,a5,a3
800041b0:	00f76863          	bltu	a4,a5,800041c0 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0x11c>
800041b4:	00160613          	addi	a2,a2,1
800041b8:	fec514e3          	bne	a0,a2,800041a0 <_ZN4core7unicode12unicode_data15grapheme_extend6lookup17h3f740e87f73bfdc2E+0xfc>
800041bc:	00050613          	mv	a2,a0
800041c0:	00167513          	andi	a0,a2,1
800041c4:	00c12083          	lw	ra,12(sp)
800041c8:	01010113          	addi	sp,sp,16
800041cc:	00008067          	ret
800041d0:	80005537          	lui	a0,0x80005
800041d4:	46c50613          	addi	a2,a0,1132 # 8000546c <ebss+0xffffe46c>
800041d8:	2c300593          	li	a1,707
800041dc:	00080513          	mv	a0,a6
800041e0:	ffffd097          	auipc	ra,0xffffd
800041e4:	70c080e7          	jalr	1804(ra) # 800018ec <_ZN4core9panicking18panic_bounds_check17h559cb3e10bbb8ef9E>
800041e8:	c0001073          	unimp
800041ec:	80005537          	lui	a0,0x80005
800041f0:	45c50613          	addi	a2,a0,1116 # 8000545c <ebss+0xffffe45c>
800041f4:	02000593          	li	a1,32
800041f8:	00070513          	mv	a0,a4
800041fc:	ffffd097          	auipc	ra,0xffffd
80004200:	6f0080e7          	jalr	1776(ra) # 800018ec <_ZN4core9panicking18panic_bounds_check17h559cb3e10bbb8ef9E>
80004204:	c0001073          	unimp
80004208:	80005537          	lui	a0,0x80005
8000420c:	47c50613          	addi	a2,a0,1148 # 8000547c <ebss+0xffffe47c>
80004210:	02000593          	li	a1,32
80004214:	00068513          	mv	a0,a3
80004218:	ffffd097          	auipc	ra,0xffffd
8000421c:	6d4080e7          	jalr	1748(ra) # 800018ec <_ZN4core9panicking18panic_bounds_check17h559cb3e10bbb8ef9E>
80004220:	c0001073          	unimp

80004224 <__udivsi3>:
80004224:	00000317          	auipc	t1,0x0
80004228:	00830067          	jr	8(t1) # 8000422c <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE>

8000422c <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE>:
8000422c:	00050613          	mv	a2,a0
80004230:	00b57863          	bgeu	a0,a1,80004240 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x14>
80004234:	00000513          	li	a0,0
80004238:	00060593          	mv	a1,a2
8000423c:	00008067          	ret
80004240:	01065713          	srli	a4,a2,0x10
80004244:	00b73533          	sltu	a0,a4,a1
80004248:	00154693          	xori	a3,a0,1
8000424c:	00060513          	mv	a0,a2
80004250:	00b76463          	bltu	a4,a1,80004258 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x2c>
80004254:	00070513          	mv	a0,a4
80004258:	00469693          	slli	a3,a3,0x4
8000425c:	00855793          	srli	a5,a0,0x8
80004260:	00b7b733          	sltu	a4,a5,a1
80004264:	00174713          	xori	a4,a4,1
80004268:	00b7e463          	bltu	a5,a1,80004270 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x44>
8000426c:	00078513          	mv	a0,a5
80004270:	00371713          	slli	a4,a4,0x3
80004274:	00d766b3          	or	a3,a4,a3
80004278:	00455793          	srli	a5,a0,0x4
8000427c:	00b7b733          	sltu	a4,a5,a1
80004280:	00174713          	xori	a4,a4,1
80004284:	00b7e463          	bltu	a5,a1,8000428c <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x60>
80004288:	00078513          	mv	a0,a5
8000428c:	00271713          	slli	a4,a4,0x2
80004290:	00e6e6b3          	or	a3,a3,a4
80004294:	00255793          	srli	a5,a0,0x2
80004298:	00b7b733          	sltu	a4,a5,a1
8000429c:	00174713          	xori	a4,a4,1
800042a0:	00b7e463          	bltu	a5,a1,800042a8 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x7c>
800042a4:	00078513          	mv	a0,a5
800042a8:	00171713          	slli	a4,a4,0x1
800042ac:	00e6e6b3          	or	a3,a3,a4
800042b0:	00155513          	srli	a0,a0,0x1
800042b4:	00b53533          	sltu	a0,a0,a1
800042b8:	00154513          	xori	a0,a0,1
800042bc:	00a6e6b3          	or	a3,a3,a0
800042c0:	00d59733          	sll	a4,a1,a3
800042c4:	40e60633          	sub	a2,a2,a4
800042c8:	00100513          	li	a0,1
800042cc:	00d51533          	sll	a0,a0,a3
800042d0:	06b66a63          	bltu	a2,a1,80004344 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x118>
800042d4:	00074663          	bltz	a4,800042e0 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0xb4>
800042d8:	00050793          	mv	a5,a0
800042dc:	0300006f          	j	8000430c <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0xe0>
800042e0:	00175713          	srli	a4,a4,0x1
800042e4:	fff68693          	addi	a3,a3,-1
800042e8:	00100793          	li	a5,1
800042ec:	40e60833          	sub	a6,a2,a4
800042f0:	00d797b3          	sll	a5,a5,a3
800042f4:	00085663          	bgez	a6,80004300 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0xd4>
800042f8:	00060813          	mv	a6,a2
800042fc:	00c0006f          	j	80004308 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0xdc>
80004300:	00f56533          	or	a0,a0,a5
80004304:	00080613          	mv	a2,a6
80004308:	02b86e63          	bltu	a6,a1,80004344 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x118>
8000430c:	fff78813          	addi	a6,a5,-1
80004310:	02068463          	beqz	a3,80004338 <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0x10c>
80004314:	fff70713          	addi	a4,a4,-1
80004318:	00068793          	mv	a5,a3
8000431c:	fff78793          	addi	a5,a5,-1
80004320:	00161613          	slli	a2,a2,0x1
80004324:	40e60633          	sub	a2,a2,a4
80004328:	41f65593          	srai	a1,a2,0x1f
8000432c:	00e5f5b3          	and	a1,a1,a4
80004330:	00c58633          	add	a2,a1,a2
80004334:	fe0794e3          	bnez	a5,8000431c <_ZN17compiler_builtins3int19specialized_div_rem11u32_div_rem17h9ebd5839b3cb747aE+0xf0>
80004338:	010675b3          	and	a1,a2,a6
8000433c:	00a5e533          	or	a0,a1,a0
80004340:	00d65633          	srl	a2,a2,a3
80004344:	00060593          	mv	a1,a2
80004348:	00008067          	ret

8000434c <__mulsi3>:
8000434c:	02050a63          	beqz	a0,80004380 <__mulsi3+0x34>
80004350:	00050613          	mv	a2,a0
80004354:	00000513          	li	a0,0
80004358:	00100693          	li	a3,1
8000435c:	00060713          	mv	a4,a2
80004360:	00167613          	andi	a2,a2,1
80004364:	40c00633          	neg	a2,a2
80004368:	00b67633          	and	a2,a2,a1
8000436c:	00a60533          	add	a0,a2,a0
80004370:	00175613          	srli	a2,a4,0x1
80004374:	00159593          	slli	a1,a1,0x1
80004378:	fee6e2e3          	bltu	a3,a4,8000435c <__mulsi3+0x10>
8000437c:	00008067          	ret
80004380:	00000513          	li	a0,0
80004384:	00008067          	ret
