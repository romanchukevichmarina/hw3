	.file	"idz3.c"
	.intel_syntax noprefix
	.text
	.globl	mabs
	.type	mabs, @function
mabs:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0
	pxor	xmm0, xmm0
	ucomisd	xmm0, QWORD PTR -8[rbp]
	jbe	.L7
	movsd	xmm1, QWORD PTR -8[rbp]
	movq	xmm0, QWORD PTR .LC1[rip]
	xorpd	xmm0, xmm1
	jmp	.L5
.L7:
	movsd	xmm0, QWORD PTR -8[rbp]
.L5:
	pop	rbp
	ret
	.size	mabs, .-mabs
	.section	.rodata
.LC2:
	.string	"%lf"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	lea	rax, -24[rbp]
	mov	rsi, rax
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	movsd	xmm1, QWORD PTR -24[rbp]
	pxor	xmm0, xmm0
	ucomisd	xmm0, xmm1
	seta	al
	xor	eax, 1
	movzx	eax, al
	mov	DWORD PTR -12[rbp], eax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -40[rbp], rax
	movsd	xmm0, QWORD PTR -40[rbp]
	call	mabs
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -40[rbp], rax
	movsd	xmm0, QWORD PTR -40[rbp]
	call	getX
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	cmp	DWORD PTR -12[rbp], 0
	jne	.L9
	movsd	xmm1, QWORD PTR -8[rbp]
	movq	xmm0, QWORD PTR .LC1[rip]
	xorpd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
.L9:
	mov	rax, QWORD PTR -8[rbp]
	mov	QWORD PTR -40[rbp], rax
	movsd	xmm0, QWORD PTR -40[rbp]
	lea	rdi, .LC2[rip]
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.globl	getX
	.type	getX, @function
getX:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 24
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	movsd	xmm1, QWORD PTR .LC3[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	jmp	.L12
.L13:
	movsd	xmm1, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC4[rip]
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm2, QWORD PTR -24[rbp]
	divsd	xmm2, xmm0
	movapd	xmm0, xmm2
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC5[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
.L12:
	movsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	subsd	xmm1, xmm0
	movapd	xmm0, xmm1
	call	mabs
	ucomisd	xmm0, QWORD PTR .LC6[rip]
	jnb	.L13
	movsd	xmm0, QWORD PTR -8[rbp]
	leave
	ret
	.size	getX, .-getX
	.section	.rodata
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC3:
	.long	0
	.long	1075052544
	.align 8
.LC4:
	.long	0
	.long	1074790400
	.align 8
.LC5:
	.long	2576980378
	.long	1070176665
	.align 8
.LC6:
	.long	2576980378
	.long	1069128089
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
