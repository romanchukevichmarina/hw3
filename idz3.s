# Эквивалентное представление переменных в программе на C
# В main:
# rbp[-24] -- `double a`
# rbp[-12] -- `int b`
# rbp[-40] -- `a` (параметр в mabs)
# rbp[-8] -- `double x`
# В mabs:
# rbp[-8] -- `double x` -- формальный параметр
# В L9:
# rbp[-40] -- `x`
# В getX:
# rbp[-24] -- `double a`
# rbp[-8] -- `double x0`
	.intel_syntax noprefix                  # Cинтаксис в стиле Intel
	.text                                   # Начало секции
	.globl	mabs
	.type	mabs, @function
mabs:                                       # Функция mabs
	push	rbp                             # / Сохраняем rbp на стек
	mov	rbp, rsp                            # | Вместо rbp записали rsp (rbp := rsp)
	movsd	QWORD PTR -8[rbp], xmm0         # `double x`
	pxor	xmm0, xmm0                      # обнуление xmm0
	ucomisd	xmm0, QWORD PTR -8[rbp]         # сравнение 0 и `x`
	jbe	.L7                                 # если 0 меньше или равен, переход к .L7 
	movsd	xmm1, QWORD PTR -8[rbp]         # xmm1 := `x`
	movq	xmm0, QWORD PTR .LC1[rip]       # копирование 64 бита .LC1 в xmm0
	xorpd	xmm0, xmm1                      # xmm0 ^= xmm1 (теперь xmm0 = -x)
	jmp	.L5                                 # переход к .L5
.L7:
	movsd	xmm0, QWORD PTR -8[rbp]         # xmm0 = `x`
.L5:
	pop	rbp                                 # извлечение rbp из стека
	ret                                     # выход из функции
	.size	mabs, .-mabs
	.section	.rodata
.LC2:
	.string	"%lf"               # .LC2: "%lf"
	.text                       # секция с кодом
	.globl	main                # Объявляем и экспортируем вовне символ `main`
main:
	push	rbp                 # / Сохраняем rbp на стек
	mov	rbp, rsp                # | Вместо rbp записали rsp (rbp := rsp)
	sub	rsp, 48                 # \ Сдвигаем rsp на 48 байт
	lea	rsi, -24[rbp]           # rsi := `double a`
	lea	rdi, .LC2[rip]          # rdi := "%lf"
	mov	eax, 0                  # eax := 0
	call	__isoc99_scanf@PLT                  # scanf("%lf", &a);
	movsd	xmm1, QWORD PTR -24[rbp]            # / тернарный оператор -- xmm1 = `a`
	pxor	xmm0, xmm0                          # | тернарный оператор -- обнуление xmm0
	ucomisd	xmm0, xmm1                          # | тернарный оператор -- сравнение 0 и `a`
	seta	al                                  # | тернарный оператор
	xor	eax, 1                                  # | тернарный оператор -- eax = eax^1
	movzx	eax, al                             # \ сохраняем в eax результат
	mov	DWORD PTR -12[rbp], eax                 # `int b` = eax
	mov	rax, QWORD PTR -24[rbp]                 # rax = `a`
	mov	QWORD PTR -40[rbp], rax                 # rbp[-40] = `a`
	movsd	xmm0, QWORD PTR -40[rbp]            # xmm0 = `a`
	call	mabs                                # mabs(a)
	movq	rax, xmm0                           # rax = xmm0 (записали в rax то, что вернула mabs)
	mov	QWORD PTR -24[rbp], rax                 # a = rax
	mov	rax, QWORD PTR -24[rbp]                 # rax = `a`
	mov	QWORD PTR -40[rbp], rax                 # rbp[-40] = `a`
	movsd	xmm0, QWORD PTR -40[rbp]            # xmm0 = `a`
	call	getX                                # getX(a)
	movq	rax, xmm0                           # rax = xmm0 (записали в rax то, что вернула getX)
	mov	QWORD PTR -8[rbp], rax                  # `double x` = rax
	cmp	DWORD PTR -12[rbp], 0                   # сравниваем `b` с 0
	jne	.L9                                     # если не b!=0, переход к .L9
	movsd	xmm1, QWORD PTR -8[rbp]             # xmm1 = `x`
	movq	xmm0, QWORD PTR .LC1[rip]           # копирование 64 бита .LC1 в xmm0
	xorpd	xmm0, xmm1                          # xmm0 ^= xmm1 (теперь xmm0 = -x)
	movsd	QWORD PTR -8[rbp], xmm0             # `x` = -x
.L9:
	mov	rax, QWORD PTR -8[rbp]                  # rax = `x`
	mov	QWORD PTR -40[rbp], rax                 # rbp[-40] = `x`
	movsd	xmm0, QWORD PTR -40[rbp]            # xmm0 = x
	lea	rdi, .LC2[rip]                          # rdi 
	mov	eax, 1                                  # eax = 1
	call	printf@PLT                          # printf("%lf", x)
	mov	eax, 0                                  # eax = 0
	leave                                       # завершение программы
	ret                                         
	.size	main, .-main
	.globl	getX
	.type	getX, @function
getX:
	push	rbp                             # помещаем rbp на стек
	mov	rbp, rsp                            # rbp = rsp
	sub	rsp, 24                             # сдвиг rsp на 24 байта
	movsd	QWORD PTR -24[rbp], xmm0        # rbp[-24] = xmm0 (получение параметра `a`)
	movsd	xmm0, QWORD PTR -24[rbp]        # xmm0 = a
	movsd	xmm1, QWORD PTR .LC3[rip]       # xmm1 = 1/5
	divsd	xmm0, xmm1                      # xmm0 /= 5
	movsd	QWORD PTR -8[rbp], xmm0         # rbp[-8] = xmm0 (x0 = a/5)
	jmp	.L12                                # переход к L12
.L13:
	movsd	xmm1, QWORD PTR -8[rbp]         # xmm1 = x0
	movsd	xmm0, QWORD PTR .LC4[rip]       # xmm0 = 0.2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	mulsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	mulsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	mulsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	movsd	xmm2, QWORD PTR -24[rbp]        # xmm2 = a
	divsd	xmm2, xmm0
	movapd	xmm0, xmm2
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC5[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
.L12:
	movsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	mulsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	mulsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	mulsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	mulsd	xmm0, QWORD PTR -8[rbp]         # xmm0 *= x0
	movsd	xmm1, QWORD PTR -24[rbp]        # xmm1 = `a`
	subsd	xmm1, xmm0                      # xmm1 -= xmm0 (a - (x0 * x0 * x0 * x0))
	movapd	xmm0, xmm1                      # xmm0 = xmm1
	call	mabs                            # mabs(a - x0 * x0 * x0 * x0 * x0)
	ucomisd	xmm0, QWORD PTR .LC6[rip]       # xmm0 сравниваем с 0.001
	jnb	.L13                                # если xmm0 не меньше 0.001, переход к .L13
	movsd	xmm0, QWORD PTR -8[rbp]         # xmm0 = x0
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
	.long	-755914244
	.long	1062232653
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
