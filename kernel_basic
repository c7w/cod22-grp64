
kernel.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <INITLOCATE>:
80000000:	00000d17          	auipc	s10,0x0
80000004:	19cd0d13          	addi	s10,s10,412 # 8000019c <START>
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

80000174 <EXCEPTION_HANDLER>:
80000174:	0000006f          	j	80000174 <EXCEPTION_HANDLER>

80000178 <FATAL>:
80000178:	08000513          	li	a0,128
8000017c:	e91ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000180:	00000513          	li	a0,0
80000184:	ef5ff0ef          	jal	ra,80000078 <WRITE_SERIAL_XLEN>
80000188:	ef1ff0ef          	jal	ra,80000078 <WRITE_SERIAL_XLEN>
8000018c:	eedff0ef          	jal	ra,80000078 <WRITE_SERIAL_XLEN>
80000190:	00000517          	auipc	a0,0x0
80000194:	00c50513          	addi	a0,a0,12 # 8000019c <START>
80000198:	00050067          	jr	a0

8000019c <START>:
8000019c:	007f0d17          	auipc	s10,0x7f0
800001a0:	e64d0d13          	addi	s10,s10,-412 # 807f0000 <_sbss>
800001a4:	007f0d97          	auipc	s11,0x7f0
800001a8:	f74d8d93          	addi	s11,s11,-140 # 807f0118 <_ebss>

800001ac <bss_init>:
800001ac:	01bd0863          	beq	s10,s11,800001bc <bss_init_done>
800001b0:	000d2023          	sw	zero,0(s10)
800001b4:	004d0d13          	addi	s10,s10,4
800001b8:	ff5ff06f          	j	800001ac <bss_init>

800001bc <bss_init_done>:
800001bc:	00800117          	auipc	sp,0x800
800001c0:	e4410113          	addi	sp,sp,-444 # 80800000 <KERNEL_STACK_INIT>
800001c4:	807f02b7          	lui	t0,0x807f0
800001c8:	007f0317          	auipc	t1,0x7f0
800001cc:	e3c30313          	addi	t1,t1,-452 # 807f0004 <uregs_sp>
800001d0:	00532023          	sw	t0,0(t1)
800001d4:	007f0317          	auipc	t1,0x7f0
800001d8:	e4830313          	addi	t1,t1,-440 # 807f001c <uregs_fp>
800001dc:	00532023          	sw	t0,0(t1)
800001e0:	100002b7          	lui	t0,0x10000
800001e4:	00700313          	li	t1,7
800001e8:	00628123          	sb	t1,2(t0) # 10000002 <INITLOCATE-0x6ffffffe>
800001ec:	08000313          	li	t1,128
800001f0:	006281a3          	sb	t1,3(t0)
800001f4:	00c00313          	li	t1,12
800001f8:	00628023          	sb	t1,0(t0)
800001fc:	000280a3          	sb	zero,1(t0)
80000200:	00300313          	li	t1,3
80000204:	006281a3          	sb	t1,3(t0)
80000208:	00028223          	sb	zero,4(t0)
8000020c:	00100313          	li	t1,1
80000210:	006280a3          	sb	t1,1(t0)
80000214:	08000293          	li	t0,128
80000218:	ffc28293          	addi	t0,t0,-4
8000021c:	ffc10113          	addi	sp,sp,-4
80000220:	00012023          	sw	zero,0(sp)
80000224:	fe029ae3          	bnez	t0,80000218 <bss_init_done+0x5c>
80000228:	007f0297          	auipc	t0,0x7f0
8000022c:	ed828293          	addi	t0,t0,-296 # 807f0100 <TCBT>
80000230:	0022a023          	sw	sp,0(t0)
80000234:	00010f93          	mv	t6,sp
80000238:	08000293          	li	t0,128
8000023c:	ffc28293          	addi	t0,t0,-4
80000240:	ffc10113          	addi	sp,sp,-4
80000244:	00012023          	sw	zero,0(sp)
80000248:	fe029ae3          	bnez	t0,8000023c <bss_init_done+0x80>
8000024c:	007f0297          	auipc	t0,0x7f0
80000250:	eb428293          	addi	t0,t0,-332 # 807f0100 <TCBT>
80000254:	0022a223          	sw	sp,4(t0)
80000258:	002fa223          	sw	sp,4(t6)
8000025c:	007f0397          	auipc	t2,0x7f0
80000260:	ea838393          	addi	t2,t2,-344 # 807f0104 <TCBT+0x4>
80000264:	0003a383          	lw	t2,0(t2)
80000268:	007f0317          	auipc	t1,0x7f0
8000026c:	ea830313          	addi	t1,t1,-344 # 807f0110 <current>
80000270:	00732023          	sw	t2,0(t1)
80000274:	0040006f          	j	80000278 <WELCOME>

80000278 <WELCOME>:
80000278:	00001517          	auipc	a0,0x1
8000027c:	edc50513          	addi	a0,a0,-292 # 80001154 <monitor_version>
80000280:	e11ff0ef          	jal	ra,80000090 <WRITE_SERIAL_STRING>
80000284:	0040006f          	j	80000288 <SHELL>

80000288 <SHELL>:
80000288:	e29ff0ef          	jal	ra,800000b0 <READ_SERIAL>
8000028c:	05200293          	li	t0,82
80000290:	06550863          	beq	a0,t0,80000300 <.OP_R>
80000294:	04400293          	li	t0,68
80000298:	0a550263          	beq	a0,t0,8000033c <.OP_D>
8000029c:	04100293          	li	t0,65
800002a0:	0c550e63          	beq	a0,t0,8000037c <.OP_A>
800002a4:	04700293          	li	t0,71
800002a8:	10550c63          	beq	a0,t0,800003c0 <.OP_G>
800002ac:	05400293          	li	t0,84
800002b0:	00550863          	beq	a0,t0,800002c0 <.OP_T>
800002b4:	00400513          	li	a0,4
800002b8:	d55ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800002bc:	2400006f          	j	800004fc <.DONE>

800002c0 <.OP_T>:
800002c0:	ff410113          	addi	sp,sp,-12
800002c4:	00912023          	sw	s1,0(sp)
800002c8:	01212223          	sw	s2,4(sp)
800002cc:	fff00493          	li	s1,-1
800002d0:	00912423          	sw	s1,8(sp)
800002d4:	00810493          	addi	s1,sp,8
800002d8:	00400913          	li	s2,4
800002dc:	00048503          	lb	a0,0(s1)
800002e0:	fff90913          	addi	s2,s2,-1
800002e4:	d29ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800002e8:	00148493          	addi	s1,s1,1
800002ec:	fe0918e3          	bnez	s2,800002dc <.OP_T+0x1c>
800002f0:	00012483          	lw	s1,0(sp)
800002f4:	00412903          	lw	s2,4(sp)
800002f8:	00c10113          	addi	sp,sp,12
800002fc:	2000006f          	j	800004fc <.DONE>

80000300 <.OP_R>:
80000300:	ff810113          	addi	sp,sp,-8
80000304:	00912023          	sw	s1,0(sp)
80000308:	01212223          	sw	s2,4(sp)
8000030c:	007f0497          	auipc	s1,0x7f0
80000310:	cf448493          	addi	s1,s1,-780 # 807f0000 <_sbss>
80000314:	07c00913          	li	s2,124
80000318:	00048503          	lb	a0,0(s1)
8000031c:	fff90913          	addi	s2,s2,-1
80000320:	cedff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000324:	00148493          	addi	s1,s1,1
80000328:	fe0918e3          	bnez	s2,80000318 <.OP_R+0x18>
8000032c:	00012483          	lw	s1,0(sp)
80000330:	00412903          	lw	s2,4(sp)
80000334:	00810113          	addi	sp,sp,8
80000338:	1c40006f          	j	800004fc <.DONE>

8000033c <.OP_D>:
8000033c:	ff810113          	addi	sp,sp,-8
80000340:	00912023          	sw	s1,0(sp)
80000344:	01212223          	sw	s2,4(sp)
80000348:	e05ff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
8000034c:	000564b3          	or	s1,a0,zero
80000350:	dfdff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
80000354:	00056933          	or	s2,a0,zero
80000358:	00048503          	lb	a0,0(s1)
8000035c:	fff90913          	addi	s2,s2,-1
80000360:	cadff0ef          	jal	ra,8000000c <WRITE_SERIAL>
80000364:	00148493          	addi	s1,s1,1
80000368:	fe0918e3          	bnez	s2,80000358 <.OP_D+0x1c>
8000036c:	00012483          	lw	s1,0(sp)
80000370:	00412903          	lw	s2,4(sp)
80000374:	00810113          	addi	sp,sp,8
80000378:	1840006f          	j	800004fc <.DONE>

8000037c <.OP_A>:
8000037c:	ff810113          	addi	sp,sp,-8
80000380:	00912023          	sw	s1,0(sp)
80000384:	01212223          	sw	s2,4(sp)
80000388:	dc5ff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
8000038c:	000564b3          	or	s1,a0,zero
80000390:	dbdff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
80000394:	00056933          	or	s2,a0,zero
80000398:	00295913          	srli	s2,s2,0x2
8000039c:	d31ff0ef          	jal	ra,800000cc <READ_SERIAL_WORD>
800003a0:	00a4a023          	sw	a0,0(s1)
800003a4:	fff90913          	addi	s2,s2,-1
800003a8:	00448493          	addi	s1,s1,4
800003ac:	fe0918e3          	bnez	s2,8000039c <.OP_A+0x20>
800003b0:	00012483          	lw	s1,0(sp)
800003b4:	00412903          	lw	s2,4(sp)
800003b8:	00810113          	addi	sp,sp,8
800003bc:	1400006f          	j	800004fc <.DONE>

800003c0 <.OP_G>:
800003c0:	d8dff0ef          	jal	ra,8000014c <READ_SERIAL_XLEN>
800003c4:	00050d13          	mv	s10,a0
800003c8:	00600513          	li	a0,6
800003cc:	c41ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800003d0:	007f0097          	auipc	ra,0x7f0
800003d4:	c3008093          	addi	ra,ra,-976 # 807f0000 <_sbss>
800003d8:	0820a023          	sw	sp,128(ra)
800003dc:	0040a103          	lw	sp,4(ra)
800003e0:	0080a183          	lw	gp,8(ra)
800003e4:	00c0a203          	lw	tp,12(ra)
800003e8:	0100a283          	lw	t0,16(ra)
800003ec:	0140a303          	lw	t1,20(ra)
800003f0:	0180a383          	lw	t2,24(ra)
800003f4:	01c0a403          	lw	s0,28(ra)
800003f8:	0200a483          	lw	s1,32(ra)
800003fc:	0240a503          	lw	a0,36(ra)
80000400:	0280a583          	lw	a1,40(ra)
80000404:	02c0a603          	lw	a2,44(ra)
80000408:	0300a683          	lw	a3,48(ra)
8000040c:	0340a703          	lw	a4,52(ra)
80000410:	0380a783          	lw	a5,56(ra)
80000414:	03c0a803          	lw	a6,60(ra)
80000418:	0400a883          	lw	a7,64(ra)
8000041c:	0440a903          	lw	s2,68(ra)
80000420:	0480a983          	lw	s3,72(ra)
80000424:	04c0aa03          	lw	s4,76(ra)
80000428:	0500aa83          	lw	s5,80(ra)
8000042c:	0540ab03          	lw	s6,84(ra)
80000430:	0580ab83          	lw	s7,88(ra)
80000434:	05c0ac03          	lw	s8,92(ra)
80000438:	0600ac83          	lw	s9,96(ra)
8000043c:	0680ad83          	lw	s11,104(ra)
80000440:	06c0ae03          	lw	t3,108(ra)
80000444:	0700ae83          	lw	t4,112(ra)
80000448:	0740af03          	lw	t5,116(ra)
8000044c:	0780af83          	lw	t6,120(ra)

80000450 <.ENTER_UESR>:
80000450:	00000097          	auipc	ra,0x0
80000454:	00c08093          	addi	ra,ra,12 # 8000045c <.USERRET2>
80000458:	000d0067          	jr	s10

8000045c <.USERRET2>:
8000045c:	007f0097          	auipc	ra,0x7f0
80000460:	ba408093          	addi	ra,ra,-1116 # 807f0000 <_sbss>
80000464:	0020a223          	sw	sp,4(ra)
80000468:	0030a423          	sw	gp,8(ra)
8000046c:	0040a623          	sw	tp,12(ra)
80000470:	0050a823          	sw	t0,16(ra)
80000474:	0060aa23          	sw	t1,20(ra)
80000478:	0070ac23          	sw	t2,24(ra)
8000047c:	0080ae23          	sw	s0,28(ra)
80000480:	0290a023          	sw	s1,32(ra)
80000484:	02a0a223          	sw	a0,36(ra)
80000488:	02b0a423          	sw	a1,40(ra)
8000048c:	02c0a623          	sw	a2,44(ra)
80000490:	02d0a823          	sw	a3,48(ra)
80000494:	02e0aa23          	sw	a4,52(ra)
80000498:	02f0ac23          	sw	a5,56(ra)
8000049c:	0300ae23          	sw	a6,60(ra)
800004a0:	0510a023          	sw	a7,64(ra)
800004a4:	0520a223          	sw	s2,68(ra)
800004a8:	0530a423          	sw	s3,72(ra)
800004ac:	0540a623          	sw	s4,76(ra)
800004b0:	0550a823          	sw	s5,80(ra)
800004b4:	0560aa23          	sw	s6,84(ra)
800004b8:	0570ac23          	sw	s7,88(ra)
800004bc:	0580ae23          	sw	s8,92(ra)
800004c0:	0790a023          	sw	s9,96(ra)
800004c4:	07a0a223          	sw	s10,100(ra)
800004c8:	07b0a423          	sw	s11,104(ra)
800004cc:	07c0a623          	sw	t3,108(ra)
800004d0:	07d0a823          	sw	t4,112(ra)
800004d4:	07e0aa23          	sw	t5,116(ra)
800004d8:	07f0ac23          	sw	t6,120(ra)
800004dc:	0800a103          	lw	sp,128(ra)
800004e0:	00008513          	mv	a0,ra
800004e4:	00000097          	auipc	ra,0x0
800004e8:	f7808093          	addi	ra,ra,-136 # 8000045c <.USERRET2>
800004ec:	00152023          	sw	ra,0(a0)
800004f0:	00700513          	li	a0,7
800004f4:	b19ff0ef          	jal	ra,8000000c <WRITE_SERIAL>
800004f8:	0040006f          	j	800004fc <.DONE>

800004fc <.DONE>:
800004fc:	d8dff06f          	j	80000288 <SHELL>
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
80001090:	fff30313          	addi	t1,t1,-1
80001094:	00612023          	sw	t1,0(sp)
80001098:	00012283          	lw	t0,0(sp)
8000109c:	fe0296e3          	bnez	t0,80001088 <UTEST_4MDCT+0x8>
800010a0:	00410113          	addi	sp,sp,4
800010a4:	00008067          	ret

800010a8 <UTEST_CRYPTONIGHT>:
800010a8:	80400537          	lui	a0,0x80400
800010ac:	002005b7          	lui	a1,0x200
800010b0:	000806b7          	lui	a3,0x80
800010b4:	00200737          	lui	a4,0x200
800010b8:	ffc70713          	addi	a4,a4,-4 # 1ffffc <INITLOCATE-0x7fe00004>
800010bc:	00a585b3          	add	a1,a1,a0
800010c0:	00100413          	li	s0,1
800010c4:	00050613          	mv	a2,a0

800010c8 <.INIT_LOOP>:
800010c8:	00862023          	sw	s0,0(a2)
800010cc:	00d41493          	slli	s1,s0,0xd
800010d0:	00944433          	xor	s0,s0,s1
800010d4:	01145493          	srli	s1,s0,0x11
800010d8:	00944433          	xor	s0,s0,s1
800010dc:	00541493          	slli	s1,s0,0x5
800010e0:	00944433          	xor	s0,s0,s1
800010e4:	00460613          	addi	a2,a2,4
800010e8:	feb610e3          	bne	a2,a1,800010c8 <.INIT_LOOP>
800010ec:	00000613          	li	a2,0
800010f0:	00000293          	li	t0,0

800010f4 <.MAIN_LOOP>:
800010f4:	00e472b3          	and	t0,s0,a4
800010f8:	005502b3          	add	t0,a0,t0
800010fc:	0002a283          	lw	t0,0(t0) # 2000000 <INITLOCATE-0x7e000000>
80001100:	0062c2b3          	xor	t0,t0,t1
80001104:	00544433          	xor	s0,s0,t0
80001108:	00d41493          	slli	s1,s0,0xd
8000110c:	00944433          	xor	s0,s0,s1
80001110:	01145493          	srli	s1,s0,0x11
80001114:	00944433          	xor	s0,s0,s1
80001118:	00541493          	slli	s1,s0,0x5
8000111c:	00944433          	xor	s0,s0,s1
80001120:	00e47333          	and	t1,s0,a4
80001124:	00650333          	add	t1,a0,t1
80001128:	00532023          	sw	t0,0(t1)
8000112c:	00028313          	mv	t1,t0
80001130:	00d41493          	slli	s1,s0,0xd
80001134:	00944433          	xor	s0,s0,s1
80001138:	01145493          	srli	s1,s0,0x11
8000113c:	00944433          	xor	s0,s0,s1
80001140:	00541493          	slli	s1,s0,0x5
80001144:	00944433          	xor	s0,s0,s1
80001148:	00160613          	addi	a2,a2,1
8000114c:	fad614e3          	bne	a2,a3,800010f4 <.MAIN_LOOP>
80001150:	00008067          	ret
