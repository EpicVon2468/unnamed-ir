SYS_WRITE equ 0x1 ; fn sys_write(fd@rdi: i32, buf@rsi: *const void, count@rdx: size_t) -> ssize_t@rax;
STDOUT_FILENO equ 0x1

section .text
	; Imports
	; ...

	; Exports
	global print ; fn print(buf@rsi: *const void, count@rdx: size_t) -> ssize_t@rax;

	; fn print(buf@rsi: *const void, count@rdx: size_t) -> ssize_t@rax;
	print:
		mov rax, SYS_WRITE
		mov rdi, STDOUT_FILENO
		syscall
		ret
