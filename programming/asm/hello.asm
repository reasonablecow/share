.global _start

_start:
	# Hello world
	mov $1, %rax # sys write
	mov $1, %rdi # fd
	lea [hello_world], %rsi # buf
	mov $14, %rdx # len
	syscall

	# Exit
	mov $60, %rax # sys exit
	mov $0, %rdi # error code
	syscall

hello_world:
	.asciz "Hello, World!\n"
