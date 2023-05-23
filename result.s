	.file	"factorial.c"              ; имя исходного файла из которого сгенерирован код
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d! = %d\n"                 ; строка используемая для вывода на экран
	.section	.text.unlikely,"ax",@progbits     ; строка указывает на начало секции кода .text.unlikely.
.LCOLDB1:
	.section	.text.startup,"ax",@progbits       ;строка указывает на начало секции кода .text.startup.
.LHOTB1:
	.globl	main
	.type	main, @function  ; определена функция main
main:
.LFB14:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0        ; строки с 14 по 24 отвечают за настройку стека и сохранение регистров
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	movl	$1, %ebx
.L2:                                           ; строки 26- 28 Метка L2 указывает на начало этого блока кода. значение 1 загружается в регистры %edx и %eax. %edx будет использоваться для хранения результата вычисления факториала, а %eax будет использоваться для счетчика цикла.
	movl	$1, %edx
	movl	$1, %eax
.L3:                                              ; строки 29-33 Метка .L3 указывает на начало цикла вычисления факториала. Здесь выполняется умножение %eax (счетчик цикла) на %edx (результат факториала). Значение сохраняется в %edx.Затем значение %eax (счетчик цикла) увеличивается на 1.Следующая инструкция cmpl %ebx, %eax сравнивает значение %eax с %ebx (который содержит текущее число для вычисления факториала).Инструкция jle .L3 переходит к метке .L3, если значение %eax меньше или равно %ebx, продолжая выполнение цикла
	imull	%eax, %edx
	incl	%eax
	cmpl	%ebx, %eax
	jle	.L3
	pushl	%edx
	pushl	%ebx
	incl	%ebx        ;строки 34-40 Здесь результат факториала в %edx и текущее число в %ebx сохраняются на стеке. %ebx (текущее число) увеличивается на 1.Затем на стек помещаются аргументы для вызова функции printf: адрес строки формата $.LC0 ("%d! = %d\n") и значение 1. Вызывается функция __printf_chk, которая выводит результат на экран. После вызова функции стек очищается с помощью addl $16, %esp, так как было добавлено 16 байт на стек для аргументов вызова функции.
	pushl	$.LC0
	pushl	$1
	call	__printf_chk
	addl	$16, %esp
	cmpl	$7, %ebx          ;строки 41-42 Здесь сравнивается значение %ebx (текущее число) с 7, чтобы проверить, достигнут ли мы конца вычислений для чисел от 1 до 7. Инструкция jne .L2 переходит к метке L2, если значения не равны, продолжая выполнение цикла.
	jne	.L2
	leal	-8(%ebp), %esp
	xorl	%eax, %eax        
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE14:
	.size	main, .-main
	.section	.text.unlikely
.LCOLDE1:
	.section	.text.startup
.LHOTE1:
	.ident	"GCC: (Ubuntu 4.9.2-10ubuntu13) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
