section .text
	global _start

; fn main() -> i32@rax;
extern main

; no prefix register = 16-bit
; 'e' prefix register = 32-bit
; 'r' prefix register = 64-bit
; word = 16-bit
; qword = 64-bit
; dword = 32-bit
_start:
	; fn main() -> i32@rax;
	call main
	; Move the value returned by `main` into `rdi`.
	mov rdi, rax
	; fn exit(status@rdi: i32) -> !@_;
	call exit

; fn exit(status@rdi: i32) -> !@_;
exit:
	; fn SYSCALL_EXIT(status@rdi: i32) -> !@_;
	mov rax, 0x3c
	syscall
	; ; Exit program (old x86 way).
	; ; SYS_EXIT
	; mov rax, 1
	; ; raise(SIGINT)
	; int 80h
