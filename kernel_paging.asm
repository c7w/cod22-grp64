
kernel.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <INITLOCATE>:
80000000:	00000d17          	auipc	s10,0x0
80000004:	574d0d13          	addi	s10,s10,1396 # 80000574 <START>
80000008:	000d0067          	jr	s10

8000000c <WRITE_SERIAL>:
8000000c:	100002b7          	lui	t0,0x10000

80000010 <.TESTW>:
80000010:	00528303          	lb	t1,5(t0) # 10000005 <INITLOCATE-0x6ffffffb>
80000014:	02037313          	andi	t1,t1,32
80000018:	00031463          	bnez	t1,80000020 <.WSERIAL>
8000001c:	ff5ff06f          	j	80000010 <.TESTW>

80000020 <.WSERIAL>:
80000020:	00a28023          	sb	a0,0(t0)
80000024:	00008067          	ret

80000028 <WRITE_SERIAL_WORD>:
80000028:	ff810113          	addi	sp,sp,-8
8000002c:	00112023          	sw	ra,0(sp)
80000030:	00812223          	sw	s0,4(sp)
80000034:	00050413          	mv	s0,a0
80000038:	0ff57513          	andi	a0,a0,255
8000003c:	fd1ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000040:	00845513          	srli	a0,s0,0x8
80000044:	0ff57513          	andi	a0,a0,255
80000048:	fc5ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
8000004c:	01045513          	srli	a0,s0,0x10
80000050:	0ff57513          	andi	a0,a0,255
80000054:	fb9ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000058:	01845513          	srli	a0,s0,0x18
8000005c:	0ff57513          	andi	a0,a0,255
80000060:	fadff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000064:	00040513          	mv	a0,s0
80000068:	00012083          	lw	ra,0(sp)
8000006c:	00412403          	lw	s0,4(sp)
80000070:	00810113          	addi	sp,sp,8
80000074:	00008067          	ret

80000078 <WRITE_SERIAL_XLEN>:
80000078:	ffc10113          	addi	sp,sp,-4
8000007c:	00112023          	sw	ra,0(sp)
80000080:	fa9ff0ef          	jal	ra,80000028 <WRITE_SERIAL_WORD>
80000084:	00012083          	lw	ra,0(sp)
80000088:	00410113          	addi	sp,sp,4
8000008c:	00008067          	ret

80000090 <WRITE_SERIAL_STRING>:
80000090:	00050593          	mv	a1,a0
80000094:	00008613          	mv	a2,ra
80000098:	00058503          	lb	a0,0(a1)
8000009c:	f71ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800000a0:	00158593          	addi	a1,a1,1
800000a4:	00058503          	lb	a0,0(a1)
800000a8:	fe051ae3          	bnez	a0,8000009c <WRITE_SERIAL_STRING+0xc>
800000ac:	00060067          	jr	a2

800000b0 <READ_SERIAL>:
800000b0:	100002b7          	lui	t0,0x10000

800000b4 <.TESTR>:
800000b4:	00528303          	lb	t1,5(t0) # 10000005 <INITLOCATE-0x6ffffffb>
800000b8:	00137313          	andi	t1,t1,1
800000bc:	00031463          	bnez	t1,800000c4 <.RSERIAL>
800000c0:	ff5ff06f          	j	800000b4 <.TESTR>

800000c4 <.RSERIAL>:
800000c4:	00028503          	lb	a0,0(t0)
800000c8:	00008067          	ret

800000cc <READ_SERIAL_WORD>:
800000cc:	fec10113          	addi	sp,sp,-20
800000d0:	00112023          	sw	ra,0(sp)
800000d4:	00812223          	sw	s0,4(sp)
800000d8:	00912423          	sw	s1,8(sp)
800000dc:	01212623          	sw	s2,12(sp)
800000e0:	01312823          	sw	s3,16(sp)
800000e4:	fcdff0ef          	jal	ra,800000b0 <READ_SERIAL>
800000e8:	00a06433          	or	s0,zero,a0
800000ec:	fc5ff0ef          	jal	ra,800000b0 <READ_SERIAL>
800000f0:	00a064b3          	or	s1,zero,a0
800000f4:	fbdff0ef          	jal	ra,800000b0 <READ_SERIAL>
800000f8:	00a06933          	or	s2,zero,a0
800000fc:	fb5ff0ef          	jal	ra,800000b0 <READ_SERIAL>
80000100:	00a069b3          	or	s3,zero,a0
80000104:	0ff47413          	andi	s0,s0,255
80000108:	0ff4f493          	andi	s1,s1,255
8000010c:	0ff97913          	andi	s2,s2,255
80000110:	0ff9f993          	andi	s3,s3,255
80000114:	01306533          	or	a0,zero,s3
80000118:	00851513          	slli	a0,a0,0x8
8000011c:	01256533          	or	a0,a0,s2
80000120:	00851513          	slli	a0,a0,0x8
80000124:	00956533          	or	a0,a0,s1
80000128:	00851513          	slli	a0,a0,0x8
8000012c:	00856533          	or	a0,a0,s0
80000130:	00012083          	lw	ra,0(sp)
80000134:	00412403          	lw	s0,4(sp)
80000138:	00812483          	lw	s1,8(sp)
8000013c:	00c12903          	lw	s2,12(sp)
80000140:	01012983          	lw	s3,16(sp)
80000144:	01410113          	addi	sp,sp,20
80000148:	00008067          	ret

8000014c <READ_SERIAL_XLEN>:
8000014c:	ff810113          	addi	sp,sp,-8
80000150:	00112023          	sw	ra,0(sp)
80000154:	00812223          	sw	s0,4(sp)
80000158:	f75ff0ef          	jal	ra,800000cc <READ_SERIAL_WORD>
8000015c:	00050413          	mv	s0,a0
80000160:	00040513          	mv	a0,s0
80000164:	00012083          	lw	ra,0(sp)
80000168:	00412403          	lw	s0,4(sp)
8000016c:	00810113          	addi	sp,sp,8
80000170:	00008067          	ret
	...

80000200 <EXCEPTION_HANDLER>:
80000200:	34011173          	csrrw	sp,mscratch,sp
80000204:	00112023          	sw	ra,0(sp)
80000208:	340110f3          	csrrw	ra,mscratch,sp
8000020c:	00112223          	sw	ra,4(sp)
80000210:	00312423          	sw	gp,8(sp)
80000214:	00412623          	sw	tp,12(sp)
80000218:	00512823          	sw	t0,16(sp)
8000021c:	00612a23          	sw	t1,20(sp)
80000220:	00712c23          	sw	t2,24(sp)
80000224:	00812e23          	sw	s0,28(sp)
80000228:	02912023          	sw	s1,32(sp)
8000022c:	02a12223          	sw	a0,36(sp)
80000230:	02b12423          	sw	a1,40(sp)
80000234:	02c12623          	sw	a2,44(sp)
80000238:	02d12823          	sw	a3,48(sp)
8000023c:	02e12a23          	sw	a4,52(sp)
80000240:	02f12c23          	sw	a5,56(sp)
80000244:	03012e23          	sw	a6,60(sp)
80000248:	05112023          	sw	a7,64(sp)
8000024c:	05212223          	sw	s2,68(sp)
80000250:	05312423          	sw	s3,72(sp)
80000254:	05412623          	sw	s4,76(sp)
80000258:	05512823          	sw	s5,80(sp)
8000025c:	05612a23          	sw	s6,84(sp)
80000260:	05712c23          	sw	s7,88(sp)
80000264:	05812e23          	sw	s8,92(sp)
80000268:	07912023          	sw	s9,96(sp)
8000026c:	07a12223          	sw	s10,100(sp)
80000270:	07b12423          	sw	s11,104(sp)
80000274:	07c12623          	sw	t3,108(sp)
80000278:	07d12823          	sw	t4,112(sp)
8000027c:	07e12a23          	sw	t5,116(sp)
80000280:	07f12c23          	sw	t6,120(sp)
80000284:	341022f3          	csrr	t0,mepc
80000288:	06512e23          	sw	t0,124(sp)
8000028c:	342022f3          	csrr	t0,mcause
80000290:	80000337          	lui	t1,0x80000
80000294:	00730313          	addi	t1,t1,7 # 80000007 <KERNEL_STACK_INIT+0xff800007>
80000298:	04530a63          	beq	t1,t0,800002ec <.HANDLE_TIMER>
8000029c:	80000337          	lui	t1,0x80000
800002a0:	0062f333          	and	t1,t0,t1
800002a4:	04031263          	bnez	t1,800002e8 <.HANDLE_INT>
800002a8:	00800313          	li	t1,8
800002ac:	00530863          	beq	t1,t0,800002bc <.HANDLE_ECALL>
800002b0:	00300313          	li	t1,3
800002b4:	02530863          	beq	t1,t0,800002e4 <.HANDLE_BREAK>
800002b8:	2480006f          	j	80000500 <FATAL>

800002bc <.HANDLE_ECALL>:
800002bc:	07c12283          	lw	t0,124(sp)
800002c0:	00428293          	addi	t0,t0,4
800002c4:	06512e23          	sw	t0,124(sp)
800002c8:	01c12283          	lw	t0,28(sp)
800002cc:	01e00313          	li	t1,30
800002d0:	00628463          	beq	t0,t1,800002d8 <.HANDLE_ECALL_PUTC>
800002d4:	0300006f          	j	80000304 <CONTEXT_SWITCH>

800002d8 <.HANDLE_ECALL_PUTC>:
800002d8:	02412503          	lw	a0,36(sp)
800002dc:	d31ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800002e0:	0240006f          	j	80000304 <CONTEXT_SWITCH>

800002e4 <.HANDLE_BREAK>:
800002e4:	6c40006f          	j	800009a8 <USERRET_MACHINE>

800002e8 <.HANDLE_INT>:
800002e8:	2180006f          	j	80000500 <FATAL>

800002ec <.HANDLE_TIMER>:
800002ec:	300022f3          	csrr	t0,mstatus
800002f0:	00002337          	lui	t1,0x2
800002f4:	80030313          	addi	t1,t1,-2048 # 1800 <INITLOCATE-0x7fffe800>
800002f8:	0062f2b3          	and	t0,t0,t1
800002fc:	00029463          	bnez	t0,80000304 <CONTEXT_SWITCH>
80000300:	69c0006f          	j	8000099c <USERRET_TIMEOUT>

80000304 <CONTEXT_SWITCH>:
80000304:	07c12283          	lw	t0,124(sp)
80000308:	34129073          	csrw	mepc,t0
8000030c:	00012083          	lw	ra,0(sp)
80000310:	00812183          	lw	gp,8(sp)
80000314:	00c12203          	lw	tp,12(sp)
80000318:	01012283          	lw	t0,16(sp)
8000031c:	01412303          	lw	t1,20(sp)
80000320:	01812383          	lw	t2,24(sp)
80000324:	01c12403          	lw	s0,28(sp)
80000328:	02012483          	lw	s1,32(sp)
8000032c:	02412503          	lw	a0,36(sp)
80000330:	02812583          	lw	a1,40(sp)
80000334:	02c12603          	lw	a2,44(sp)
80000338:	03012683          	lw	a3,48(sp)
8000033c:	03412703          	lw	a4,52(sp)
80000340:	03812783          	lw	a5,56(sp)
80000344:	03c12803          	lw	a6,60(sp)
80000348:	04012883          	lw	a7,64(sp)
8000034c:	04412903          	lw	s2,68(sp)
80000350:	04812983          	lw	s3,72(sp)
80000354:	04c12a03          	lw	s4,76(sp)
80000358:	05012a83          	lw	s5,80(sp)
8000035c:	05412b03          	lw	s6,84(sp)
80000360:	05812b83          	lw	s7,88(sp)
80000364:	05c12c03          	lw	s8,92(sp)
80000368:	06012c83          	lw	s9,96(sp)
8000036c:	06412d03          	lw	s10,100(sp)
80000370:	06812d83          	lw	s11,104(sp)
80000374:	06c12e03          	lw	t3,108(sp)
80000378:	07012e83          	lw	t4,112(sp)
8000037c:	07412f03          	lw	t5,116(sp)
80000380:	07812f83          	lw	t6,120(sp)
80000384:	34011073          	csrw	mscratch,sp
80000388:	00412103          	lw	sp,4(sp)
8000038c:	30200073          	mret
80000390:	00000013          	nop
80000394:	00000013          	nop
80000398:	00000013          	nop
8000039c:	00000013          	nop
800003a0:	00000013          	nop
800003a4:	00000013          	nop
800003a8:	00000013          	nop
800003ac:	00000013          	nop
800003b0:	00000013          	nop
800003b4:	00000013          	nop
800003b8:	00000013          	nop
800003bc:	00000013          	nop
800003c0:	00000013          	nop
800003c4:	00000013          	nop
800003c8:	00000013          	nop
800003cc:	00000013          	nop
800003d0:	00000013          	nop
800003d4:	00000013          	nop
800003d8:	00000013          	nop
800003dc:	00000013          	nop
800003e0:	00000013          	nop
800003e4:	00000013          	nop
800003e8:	00000013          	nop
800003ec:	00000013          	nop
800003f0:	00000013          	nop
800003f4:	00000013          	nop
800003f8:	00000013          	nop
800003fc:	00000013          	nop

80000400 <VECTORED_EXCEPTION_HANDLER>:
80000400:	e01ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000404:	dfdff06f          	j	80000200 <EXCEPTION_HANDLER>
80000408:	df9ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000040c:	df5ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000410:	df1ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000414:	dedff06f          	j	80000200 <EXCEPTION_HANDLER>
80000418:	de9ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000041c:	de5ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000420:	de1ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000424:	dddff06f          	j	80000200 <EXCEPTION_HANDLER>
80000428:	dd9ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000042c:	dd5ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000430:	dd1ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000434:	dcdff06f          	j	80000200 <EXCEPTION_HANDLER>
80000438:	dc9ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000043c:	dc5ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000440:	dc1ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000444:	dbdff06f          	j	80000200 <EXCEPTION_HANDLER>
80000448:	db9ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000044c:	db5ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000450:	db1ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000454:	dadff06f          	j	80000200 <EXCEPTION_HANDLER>
80000458:	da9ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000045c:	da5ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000460:	da1ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000464:	d9dff06f          	j	80000200 <EXCEPTION_HANDLER>
80000468:	d99ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000046c:	d95ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000470:	d91ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000474:	d8dff06f          	j	80000200 <EXCEPTION_HANDLER>
80000478:	d89ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000047c:	d85ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000480:	d81ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000484:	d7dff06f          	j	80000200 <EXCEPTION_HANDLER>
80000488:	d79ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000048c:	d75ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000490:	d71ff06f          	j	80000200 <EXCEPTION_HANDLER>
80000494:	d6dff06f          	j	80000200 <EXCEPTION_HANDLER>
80000498:	d69ff06f          	j	80000200 <EXCEPTION_HANDLER>
8000049c:	d65ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004a0:	d61ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004a4:	d5dff06f          	j	80000200 <EXCEPTION_HANDLER>
800004a8:	d59ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004ac:	d55ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004b0:	d51ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004b4:	d4dff06f          	j	80000200 <EXCEPTION_HANDLER>
800004b8:	d49ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004bc:	d45ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004c0:	d41ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004c4:	d3dff06f          	j	80000200 <EXCEPTION_HANDLER>
800004c8:	d39ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004cc:	d35ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004d0:	d31ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004d4:	d2dff06f          	j	80000200 <EXCEPTION_HANDLER>
800004d8:	d29ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004dc:	d25ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004e0:	d21ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004e4:	d1dff06f          	j	80000200 <EXCEPTION_HANDLER>
800004e8:	d19ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004ec:	d15ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004f0:	d11ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004f4:	d0dff06f          	j	80000200 <EXCEPTION_HANDLER>
800004f8:	d09ff06f          	j	80000200 <EXCEPTION_HANDLER>
800004fc:	d05ff06f          	j	80000200 <EXCEPTION_HANDLER>

80000500 <FATAL>:
80000500:	08000513          	li	a0,128
80000504:	b09ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000508:	34102573          	csrr	a0,mepc
8000050c:	b6dff0ef          	jal	ra,80000078 <WRITE_SERIAL_XLEN>
80000510:	34202573          	csrr	a0,mcause
80000514:	b65ff0ef          	jal	ra,80000078 <WRITE_SERIAL_XLEN>
80000518:	34302573          	csrr	a0,mtval
8000051c:	b5dff0ef          	jal	ra,80000078 <WRITE_SERIAL_XLEN>
80000520:	00000517          	auipc	a0,0x0
80000524:	05450513          	addi	a0,a0,84 # 80000574 <START>
80000528:	00050067          	jr	a0
	...

80000574 <START>:
80000574:	007f0d17          	auipc	s10,0x7f0
80000578:	a8cd0d13          	addi	s10,s10,-1396 # 807f0000 <_sbss>
8000057c:	007f0d97          	auipc	s11,0x7f0
80000580:	b9cd8d93          	addi	s11,s11,-1124 # 807f0118 <_ebss>

80000584 <bss_init>:
80000584:	01bd0863          	beq	s10,s11,80000594 <bss_init_done>
80000588:	000d2023          	sw	zero,0(s10)
8000058c:	004d0d13          	addi	s10,s10,4
80000590:	ff5ff06f          	j	80000584 <bss_init>

80000594 <bss_init_done>:
80000594:	00000417          	auipc	s0,0x0
80000598:	c6c40413          	addi	s0,s0,-916 # 80000200 <EXCEPTION_HANDLER>
8000059c:	30541073          	csrw	mtvec,s0
800005a0:	305022f3          	csrr	t0,mtvec
800005a4:	00828a63          	beq	t0,s0,800005b8 <mtvec_done>
800005a8:	00000417          	auipc	s0,0x0
800005ac:	e5840413          	addi	s0,s0,-424 # 80000400 <VECTORED_EXCEPTION_HANDLER>
800005b0:	00146413          	ori	s0,s0,1
800005b4:	30541073          	csrw	mtvec,s0

800005b8 <mtvec_done>:
800005b8:	08000293          	li	t0,128
800005bc:	30429073          	csrw	mie,t0
800005c0:	00800117          	auipc	sp,0x800
800005c4:	a4010113          	addi	sp,sp,-1472 # 80800000 <KERNEL_STACK_INIT>
800005c8:	800002b7          	lui	t0,0x80000
800005cc:	007f0317          	auipc	t1,0x7f0
800005d0:	a3830313          	addi	t1,t1,-1480 # 807f0004 <uregs_sp>
800005d4:	00532023          	sw	t0,0(t1)
800005d8:	007f0317          	auipc	t1,0x7f0
800005dc:	a4430313          	addi	t1,t1,-1468 # 807f001c <uregs_fp>
800005e0:	00532023          	sw	t0,0(t1)
800005e4:	100002b7          	lui	t0,0x10000
800005e8:	00700313          	li	t1,7
800005ec:	00628123          	sb	t1,2(t0) # 10000002 <INITLOCATE-0x6ffffffe>
800005f0:	08000313          	li	t1,128
800005f4:	006281a3          	sb	t1,3(t0)
800005f8:	00c00313          	li	t1,12
800005fc:	00628023          	sb	t1,0(t0)
80000600:	000280a3          	sb	zero,1(t0)
80000604:	00300313          	li	t1,3
80000608:	006281a3          	sb	t1,3(t0)
8000060c:	00028223          	sb	zero,4(t0)
80000610:	00100313          	li	t1,1
80000614:	006280a3          	sb	t1,1(t0)
80000618:	08000293          	li	t0,128
8000061c:	ffc28293          	addi	t0,t0,-4
80000620:	ffc10113          	addi	sp,sp,-4
80000624:	00012023          	sw	zero,0(sp)
80000628:	fe029ae3          	bnez	t0,8000061c <mtvec_done+0x64>
8000062c:	007f0297          	auipc	t0,0x7f0
80000630:	ad428293          	addi	t0,t0,-1324 # 807f0100 <TCBT>
80000634:	0022a023          	sw	sp,0(t0)
80000638:	00010f93          	mv	t6,sp
8000063c:	08000293          	li	t0,128
80000640:	ffc28293          	addi	t0,t0,-4
80000644:	ffc10113          	addi	sp,sp,-4
80000648:	00012023          	sw	zero,0(sp)
8000064c:	fe029ae3          	bnez	t0,80000640 <mtvec_done+0x88>
80000650:	007f0297          	auipc	t0,0x7f0
80000654:	ab028293          	addi	t0,t0,-1360 # 807f0100 <TCBT>
80000658:	0022a223          	sw	sp,4(t0)
8000065c:	002fa223          	sw	sp,4(t6)
80000660:	007f0397          	auipc	t2,0x7f0
80000664:	aa438393          	addi	t2,t2,-1372 # 807f0104 <TCBT+0x4>
80000668:	0003a383          	lw	t2,0(t2)
8000066c:	34039073          	csrw	mscratch,t2
80000670:	007f0317          	auipc	t1,0x7f0
80000674:	aa030313          	addi	t1,t1,-1376 # 807f0110 <current>
80000678:	00732023          	sw	t2,0(t1)
8000067c:	00002297          	auipc	t0,0x2
80000680:	98428293          	addi	t0,t0,-1660 # 80002000 <PAGE_TABLE>
80000684:	00003317          	auipc	t1,0x3
80000688:	97c30313          	addi	t1,t1,-1668 # 80003000 <PAGE_TABLE_USER_CODE>
8000068c:	30000e13          	li	t3,768
80000690:	00000393          	li	t2,0
80000694:	20040eb7          	lui	t4,0x20040
80000698:	0fbe8e93          	addi	t4,t4,251 # 200400fb <INITLOCATE-0x5ffbff05>
8000069c:	00a39f13          	slli	t5,t2,0xa
800006a0:	01ee8eb3          	add	t4,t4,t5
800006a4:	01d32023          	sw	t4,0(t1)
800006a8:	00430313          	addi	t1,t1,4
800006ac:	00138393          	addi	t2,t2,1
800006b0:	ffc392e3          	bne	t2,t3,80000694 <mtvec_done+0xdc>
800006b4:	00003317          	auipc	t1,0x3
800006b8:	94c30313          	addi	t1,t1,-1716 # 80003000 <PAGE_TABLE_USER_CODE>
800006bc:	00235313          	srli	t1,t1,0x2
800006c0:	0f136313          	ori	t1,t1,241
800006c4:	0062a023          	sw	t1,0(t0)
800006c8:	00002297          	auipc	t0,0x2
800006cc:	93828293          	addi	t0,t0,-1736 # 80002000 <PAGE_TABLE>
800006d0:	00004317          	auipc	t1,0x4
800006d4:	93030313          	addi	t1,t1,-1744 # 80004000 <PAGE_TABLE_KERNEL_CODE>
800006d8:	00235313          	srli	t1,t1,0x2
800006dc:	0f136313          	ori	t1,t1,241
800006e0:	000013b7          	lui	t2,0x1
800006e4:	80038393          	addi	t2,t2,-2048 # 800 <INITLOCATE-0x7ffff800>
800006e8:	007283b3          	add	t2,t0,t2
800006ec:	0063a023          	sw	t1,0(t2)
800006f0:	00005317          	auipc	t1,0x5
800006f4:	91030313          	addi	t1,t1,-1776 # 80005000 <PAGE_TABLE_USER_STACK>
800006f8:	04030313          	addi	t1,t1,64
800006fc:	40000e13          	li	t3,1024
80000700:	01000393          	li	t2,16
80000704:	200fceb7          	lui	t4,0x200fc
80000708:	0f7e8e93          	addi	t4,t4,247 # 200fc0f7 <INITLOCATE-0x5ff03f09>
8000070c:	00a39f13          	slli	t5,t2,0xa
80000710:	01ee8eb3          	add	t4,t4,t5
80000714:	01d32023          	sw	t4,0(t1)
80000718:	00430313          	addi	t1,t1,4
8000071c:	00138393          	addi	t2,t2,1
80000720:	ffc392e3          	bne	t2,t3,80000704 <mtvec_done+0x14c>
80000724:	00005317          	auipc	t1,0x5
80000728:	8dc30313          	addi	t1,t1,-1828 # 80005000 <PAGE_TABLE_USER_STACK>
8000072c:	00235313          	srli	t1,t1,0x2
80000730:	0f136313          	ori	t1,t1,241
80000734:	7fc00393          	li	t2,2044
80000738:	007283b3          	add	t2,t0,t2
8000073c:	0063a023          	sw	t1,0(t2)
80000740:	00002297          	auipc	t0,0x2
80000744:	8c028293          	addi	t0,t0,-1856 # 80002000 <PAGE_TABLE>
80000748:	00c2d293          	srli	t0,t0,0xc
8000074c:	80000337          	lui	t1,0x80000
80000750:	0062e2b3          	or	t0,t0,t1
80000754:	18029073          	csrw	satp,t0
80000758:	12000073          	sfence.vma
8000075c:	00f00293          	li	t0,15
80000760:	3a029073          	csrw	pmpcfg0,t0
80000764:	fff00293          	li	t0,-1
80000768:	3b029073          	csrw	pmpaddr0,t0
8000076c:	0040006f          	j	80000770 <WELCOME>

80000770 <WELCOME>:
80000770:	00001517          	auipc	a0,0x1
80000774:	a0050513          	addi	a0,a0,-1536 # 80001170 <monitor_version>
80000778:	919ff0ef          	jal	ra,80000090 <WRITE_SERIAL_STRING>
8000077c:	0040006f          	j	80000780 <SHELL>

80000780 <SHELL>:
80000780:	931ff0ef          	jal	ra,800000b0 <READ_SERIAL>
80000784:	05200293          	li	t0,82
80000788:	06550a63          	beq	a0,t0,800007fc <.OP_R>
8000078c:	04400293          	li	t0,68
80000790:	0a550463          	beq	a0,t0,80000838 <.OP_D>
80000794:	04100293          	li	t0,65
80000798:	0e550063          	beq	a0,t0,80000878 <.OP_A>
8000079c:	04700293          	li	t0,71
800007a0:	10550e63          	beq	a0,t0,800008bc <.OP_G>
800007a4:	05400293          	li	t0,84
800007a8:	00550863          	beq	a0,t0,800007b8 <.OP_T>
800007ac:	00400513          	li	a0,4
800007b0:	85dff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800007b4:	2d00006f          	j	80000a84 <.DONE>

800007b8 <.OP_T>:
800007b8:	ff410113          	addi	sp,sp,-12
800007bc:	00912023          	sw	s1,0(sp)
800007c0:	01212223          	sw	s2,4(sp)
800007c4:	180024f3          	csrr	s1,satp
800007c8:	00c49493          	slli	s1,s1,0xc
800007cc:	00912423          	sw	s1,8(sp)
800007d0:	00810493          	addi	s1,sp,8
800007d4:	00400913          	li	s2,4
800007d8:	00048503          	lb	a0,0(s1)
800007dc:	fff90913          	addi	s2,s2,-1
800007e0:	82dff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800007e4:	00148493          	addi	s1,s1,1
800007e8:	fe0918e3          	bnez	s2,800007d8 <.OP_T+0x20>
800007ec:	00012483          	lw	s1,0(sp)
800007f0:	00412903          	lw	s2,4(sp)
800007f4:	00c10113          	addi	sp,sp,12
800007f8:	28c0006f          	j	80000a84 <.DONE>

800007fc <.OP_R>:
800007fc:	ff810113          	addi	sp,sp,-8
80000800:	00912023          	sw	s1,0(sp)
80000804:	01212223          	sw	s2,4(sp)
80000808:	007ef497          	auipc	s1,0x7ef
8000080c:	7f848493          	addi	s1,s1,2040 # 807f0000 <_sbss>
80000810:	07c00913          	li	s2,124
80000814:	00048503          	lb	a0,0(s1)
80000818:	fff90913          	addi	s2,s2,-1
8000081c:	ff0ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000820:	00148493          	addi	s1,s1,1
80000824:	fe0918e3          	bnez	s2,80000814 <.OP_R+0x18>
80000828:	00012483          	lw	s1,0(sp)
8000082c:	00412903          	lw	s2,4(sp)
80000830:	00810113          	addi	sp,sp,8
80000834:	2500006f          	j	80000a84 <.DONE>

80000838 <.OP_D>:
80000838:	ff810113          	addi	sp,sp,-8
8000083c:	00912023          	sw	s1,0(sp)
80000840:	01212223          	sw	s2,4(sp)
80000844:	909ff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
80000848:	000564b3          	or	s1,a0,zero
8000084c:	901ff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
80000850:	00056933          	or	s2,a0,zero
80000854:	00048503          	lb	a0,0(s1)
80000858:	fff90913          	addi	s2,s2,-1
8000085c:	fb0ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000860:	00148493          	addi	s1,s1,1
80000864:	fe0918e3          	bnez	s2,80000854 <.OP_D+0x1c>
80000868:	00012483          	lw	s1,0(sp)
8000086c:	00412903          	lw	s2,4(sp)
80000870:	00810113          	addi	sp,sp,8
80000874:	2100006f          	j	80000a84 <.DONE>

80000878 <.OP_A>:
80000878:	ff810113          	addi	sp,sp,-8
8000087c:	00912023          	sw	s1,0(sp)
80000880:	01212223          	sw	s2,4(sp)
80000884:	8c9ff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
80000888:	000564b3          	or	s1,a0,zero
8000088c:	8c1ff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
80000890:	00056933          	or	s2,a0,zero
80000894:	00295913          	srli	s2,s2,0x2
80000898:	835ff0ef          	jal	ra,800000cc <READ_SERIAL_WORD>
8000089c:	00a4a023          	sw	a0,0(s1)
800008a0:	fff90913          	addi	s2,s2,-1
800008a4:	00448493          	addi	s1,s1,4
800008a8:	fe0918e3          	bnez	s2,80000898 <.OP_A+0x20>
800008ac:	00012483          	lw	s1,0(sp)
800008b0:	00412903          	lw	s2,4(sp)
800008b4:	00810113          	addi	sp,sp,8
800008b8:	1cc0006f          	j	80000a84 <.DONE>

800008bc <.OP_G>:
800008bc:	891ff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
800008c0:	00050d13          	mv	s10,a0
800008c4:	00600513          	li	a0,6
800008c8:	f44ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800008cc:	341d1073          	csrw	mepc,s10
800008d0:	00002537          	lui	a0,0x2
800008d4:	80050513          	addi	a0,a0,-2048 # 1800 <INITLOCATE-0x7fffe800>
800008d8:	30053073          	csrc	mstatus,a0
800008dc:	0200c2b7          	lui	t0,0x200c
800008e0:	ff828293          	addi	t0,t0,-8 # 200bff8 <INITLOCATE-0x7dff4008>
800008e4:	0002a303          	lw	t1,0(t0)
800008e8:	0042a383          	lw	t2,4(t0)
800008ec:	00989e37          	lui	t3,0x989
800008f0:	680e0e13          	addi	t3,t3,1664 # 989680 <INITLOCATE-0x7f676980>
800008f4:	01c30e33          	add	t3,t1,t3
800008f8:	006e3333          	sltu	t1,t3,t1
800008fc:	006383b3          	add	t2,t2,t1
80000900:	020042b7          	lui	t0,0x2004
80000904:	0072a223          	sw	t2,4(t0) # 2004004 <INITLOCATE-0x7dffbffc>
80000908:	01c2a023          	sw	t3,0(t0)
8000090c:	007ef097          	auipc	ra,0x7ef
80000910:	6f408093          	addi	ra,ra,1780 # 807f0000 <_sbss>
80000914:	0820a023          	sw	sp,128(ra)
80000918:	0040a103          	lw	sp,4(ra)
8000091c:	0080a183          	lw	gp,8(ra)
80000920:	00c0a203          	lw	tp,12(ra)
80000924:	0100a283          	lw	t0,16(ra)
80000928:	0140a303          	lw	t1,20(ra)
8000092c:	0180a383          	lw	t2,24(ra)
80000930:	01c0a403          	lw	s0,28(ra)
80000934:	0200a483          	lw	s1,32(ra)
80000938:	0240a503          	lw	a0,36(ra)
8000093c:	0280a583          	lw	a1,40(ra)
80000940:	02c0a603          	lw	a2,44(ra)
80000944:	0300a683          	lw	a3,48(ra)
80000948:	0340a703          	lw	a4,52(ra)
8000094c:	0380a783          	lw	a5,56(ra)
80000950:	03c0a803          	lw	a6,60(ra)
80000954:	0400a883          	lw	a7,64(ra)
80000958:	0440a903          	lw	s2,68(ra)
8000095c:	0480a983          	lw	s3,72(ra)
80000960:	04c0aa03          	lw	s4,76(ra)
80000964:	0500aa83          	lw	s5,80(ra)
80000968:	0540ab03          	lw	s6,84(ra)
8000096c:	0580ab83          	lw	s7,88(ra)
80000970:	05c0ac03          	lw	s8,92(ra)
80000974:	0600ac83          	lw	s9,96(ra)
80000978:	0680ad83          	lw	s11,104(ra)
8000097c:	06c0ae03          	lw	t3,108(ra)
80000980:	0700ae83          	lw	t4,112(ra)
80000984:	0740af03          	lw	t5,116(ra)
80000988:	0780af83          	lw	t6,120(ra)

8000098c <.ENTER_UESR>:
8000098c:	00000097          	auipc	ra,0x0
80000990:	00c08093          	addi	ra,ra,12 # 80000998 <.USERRET_USER>
80000994:	30200073          	mret

80000998 <.USERRET_USER>:
80000998:	00100073          	ebreak

8000099c <USERRET_TIMEOUT>:
8000099c:	08100513          	li	a0,129
800009a0:	e6cff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800009a4:	00c0006f          	j	800009b0 <USERRET_MACHINE+0x8>

800009a8 <USERRET_MACHINE>:
800009a8:	00700513          	li	a0,7
800009ac:	e60ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800009b0:	007ef497          	auipc	s1,0x7ef
800009b4:	65048493          	addi	s1,s1,1616 # 807f0000 <_sbss>
800009b8:	08000913          	li	s2,128
800009bc:	00012503          	lw	a0,0(sp)
800009c0:	00a4a023          	sw	a0,0(s1)
800009c4:	ffc90913          	addi	s2,s2,-4
800009c8:	00448493          	addi	s1,s1,4
800009cc:	00410113          	addi	sp,sp,4
800009d0:	fe0916e3          	bnez	s2,800009bc <USERRET_MACHINE+0x14>
800009d4:	007ef497          	auipc	s1,0x7ef
800009d8:	62c48493          	addi	s1,s1,1580 # 807f0000 <_sbss>
800009dc:	0804a103          	lw	sp,128(s1)
800009e0:	0a40006f          	j	80000a84 <.DONE>

800009e4 <.USERRET2>:
800009e4:	007ef097          	auipc	ra,0x7ef
800009e8:	61c08093          	addi	ra,ra,1564 # 807f0000 <_sbss>
800009ec:	0020a223          	sw	sp,4(ra)
800009f0:	0030a423          	sw	gp,8(ra)
800009f4:	0040a623          	sw	tp,12(ra)
800009f8:	0050a823          	sw	t0,16(ra)
800009fc:	0060aa23          	sw	t1,20(ra)
80000a00:	0070ac23          	sw	t2,24(ra)
80000a04:	0080ae23          	sw	s0,28(ra)
80000a08:	0290a023          	sw	s1,32(ra)
80000a0c:	02a0a223          	sw	a0,36(ra)
80000a10:	02b0a423          	sw	a1,40(ra)
80000a14:	02c0a623          	sw	a2,44(ra)
80000a18:	02d0a823          	sw	a3,48(ra)
80000a1c:	02e0aa23          	sw	a4,52(ra)
80000a20:	02f0ac23          	sw	a5,56(ra)
80000a24:	0300ae23          	sw	a6,60(ra)
80000a28:	0510a023          	sw	a7,64(ra)
80000a2c:	0520a223          	sw	s2,68(ra)
80000a30:	0530a423          	sw	s3,72(ra)
80000a34:	0540a623          	sw	s4,76(ra)
80000a38:	0550a823          	sw	s5,80(ra)
80000a3c:	0560aa23          	sw	s6,84(ra)
80000a40:	0570ac23          	sw	s7,88(ra)
80000a44:	0580ae23          	sw	s8,92(ra)
80000a48:	0790a023          	sw	s9,96(ra)
80000a4c:	07a0a223          	sw	s10,100(ra)
80000a50:	07b0a423          	sw	s11,104(ra)
80000a54:	07c0a623          	sw	t3,108(ra)
80000a58:	07d0a823          	sw	t4,112(ra)
80000a5c:	07e0aa23          	sw	t5,116(ra)
80000a60:	07f0ac23          	sw	t6,120(ra)
80000a64:	0800a103          	lw	sp,128(ra)
80000a68:	00008513          	mv	a0,ra
80000a6c:	00000097          	auipc	ra,0x0
80000a70:	f7808093          	addi	ra,ra,-136 # 800009e4 <.USERRET2>
80000a74:	00152023          	sw	ra,0(a0)
80000a78:	00700513          	li	a0,7
80000a7c:	d90ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000a80:	0040006f          	j	80000a84 <.DONE>

80000a84 <.DONE>:
80000a84:	cfdff06f          	j	80000780 <SHELL>
	...

80001000 <UTEST_SIMPLE>:
80001000:	001f0f13          	addi	t5,t5,1
80001004:	00008067          	ret

80001008 <UTEST_1PTB>:
80001008:	040002b7          	lui	t0,0x4000
8000100c:	fff28293          	addi	t0,t0,-1 # 3ffffff <INITLOCATE-0x7c000001>
80001010:	00000313          	li	t1,0
80001014:	00100393          	li	t2,1
80001018:	00200e13          	li	t3,2
8000101c:	fe0298e3          	bnez	t0,8000100c <UTEST_1PTB+0x4>
80001020:	00008067          	ret

80001024 <UTEST_2DCT>:
80001024:	010002b7          	lui	t0,0x1000
80001028:	00100313          	li	t1,1
8000102c:	00200393          	li	t2,2
80001030:	00300e13          	li	t3,3
80001034:	0063c3b3          	xor	t2,t2,t1
80001038:	00734333          	xor	t1,t1,t2
8000103c:	0063c3b3          	xor	t2,t2,t1
80001040:	007e4e33          	xor	t3,t3,t2
80001044:	01c3c3b3          	xor	t2,t2,t3
80001048:	007e4e33          	xor	t3,t3,t2
8000104c:	01c34333          	xor	t1,t1,t3
80001050:	006e4e33          	xor	t3,t3,t1
80001054:	01c34333          	xor	t1,t1,t3
80001058:	fff28293          	addi	t0,t0,-1 # ffffff <INITLOCATE-0x7f000001>
8000105c:	fc029ce3          	bnez	t0,80001034 <UTEST_2DCT+0x10>
80001060:	00008067          	ret

80001064 <UTEST_3CCT>:
80001064:	040002b7          	lui	t0,0x4000
80001068:	00029463          	bnez	t0,80001070 <UTEST_3CCT+0xc>
8000106c:	00008067          	ret
80001070:	0040006f          	j	80001074 <UTEST_3CCT+0x10>
80001074:	fff28293          	addi	t0,t0,-1 # 3ffffff <INITLOCATE-0x7c000001>
80001078:	ff1ff06f          	j	80001068 <UTEST_3CCT+0x4>
8000107c:	fff28293          	addi	t0,t0,-1

80001080 <UTEST_4MDCT>:
80001080:	020002b7          	lui	t0,0x2000
80001084:	ffc10113          	addi	sp,sp,-4
80001088:	00512023          	sw	t0,0(sp)
8000108c:	00012303          	lw	t1,0(sp)
80001090:	fff30313          	addi	t1,t1,-1 # 7fffffff <KERNEL_STACK_INIT+0xff7fffff>
80001094:	00612023          	sw	t1,0(sp)
80001098:	00012283          	lw	t0,0(sp)
8000109c:	fe0296e3          	bnez	t0,80001088 <UTEST_4MDCT+0x8>
800010a0:	00410113          	addi	sp,sp,4
800010a4:	00008067          	ret

800010a8 <UTEST_PUTC>:
800010a8:	01e00413          	li	s0,30
800010ac:	04f00513          	li	a0,79
800010b0:	00000073          	ecall
800010b4:	04b00513          	li	a0,75
800010b8:	00000073          	ecall
800010bc:	00008067          	ret

800010c0 <UTEST_SPIN>:
800010c0:	0000006f          	j	800010c0 <UTEST_SPIN>

800010c4 <UTEST_CRYPTONIGHT>:
800010c4:	80400537          	lui	a0,0x80400
800010c8:	002005b7          	lui	a1,0x200
800010cc:	000806b7          	lui	a3,0x80
800010d0:	00200737          	lui	a4,0x200
800010d4:	ffc70713          	addi	a4,a4,-4 # 1ffffc <INITLOCATE-0x7fe00004>
800010d8:	00a585b3          	add	a1,a1,a0
800010dc:	00100413          	li	s0,1
800010e0:	00050613          	mv	a2,a0

800010e4 <.INIT_LOOP>:
800010e4:	00862023          	sw	s0,0(a2)
800010e8:	00d41493          	slli	s1,s0,0xd
800010ec:	00944433          	xor	s0,s0,s1
800010f0:	01145493          	srli	s1,s0,0x11
800010f4:	00944433          	xor	s0,s0,s1
800010f8:	00541493          	slli	s1,s0,0x5
800010fc:	00944433          	xor	s0,s0,s1
80001100:	00460613          	addi	a2,a2,4
80001104:	feb610e3          	bne	a2,a1,800010e4 <.INIT_LOOP>
80001108:	00000613          	li	a2,0
8000110c:	00000293          	li	t0,0

80001110 <.MAIN_LOOP>:
80001110:	00e472b3          	and	t0,s0,a4
80001114:	005502b3          	add	t0,a0,t0
80001118:	0002a283          	lw	t0,0(t0) # 2000000 <INITLOCATE-0x7e000000>
8000111c:	0062c2b3          	xor	t0,t0,t1
80001120:	00544433          	xor	s0,s0,t0
80001124:	00d41493          	slli	s1,s0,0xd
80001128:	00944433          	xor	s0,s0,s1
8000112c:	01145493          	srli	s1,s0,0x11
80001130:	00944433          	xor	s0,s0,s1
80001134:	00541493          	slli	s1,s0,0x5
80001138:	00944433          	xor	s0,s0,s1
8000113c:	00e47333          	and	t1,s0,a4
80001140:	00650333          	add	t1,a0,t1
80001144:	00532023          	sw	t0,0(t1)
80001148:	00028313          	mv	t1,t0
8000114c:	00d41493          	slli	s1,s0,0xd
80001150:	00944433          	xor	s0,s0,s1
80001154:	01145493          	srli	s1,s0,0x11
80001158:	00944433          	xor	s0,s0,s1
8000115c:	00541493          	slli	s1,s0,0x5
80001160:	00944433          	xor	s0,s0,s1
80001164:	00160613          	addi	a2,a2,1
80001168:	fad614e3          	bne	a2,a3,80001110 <.MAIN_LOOP>
8000116c:	00008067          	ret
