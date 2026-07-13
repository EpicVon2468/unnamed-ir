SYS_EXIT equ 0x3C ; fn sys_exit(status@rdi: i32) -> !@rax;

section .text
	; Imports
	extern main ; fn main() -> i32@rax;

	; Exports
	global _start
	global exit ; fn exit(status@rdi: i32) -> !@rax;

	; no prefix register = 16-bit
	; 'e' prefix register = 32-bit
	; 'r' prefix register = 64-bit
	; bword = 8-bit; 1 byte
	; word = 16-bit; 2 bytes
	; d(ouble)word = 32-bit; 4 bytes
	; q(uad)word = 64-bit; 8 bytes
	; 0xA = '\n'
	_start:
		call main ; fn main() -> i32@rax;
		; Move the value returned by `main` into `rdi`.
		mov rdi, rax
		call exit ; fn exit(status@rdi: i32) -> !@rax;

	; fn exit(status@rdi: i32) -> !@rax;
	exit:
		mov rax, SYS_EXIT
		syscall
		; ; Exit program (old x86 way).
		; ; SYS_EXIT
		; mov rax, 1
		; ; raise(SIGINT)
		; int 80h
