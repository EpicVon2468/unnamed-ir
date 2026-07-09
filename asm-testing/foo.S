section .text
	global main

; fn main() -> i32@rax;
main:
	; Stack fuckery (actual wizardry, do not touch).
	; Effectively, if you want to do stuff like `mov qword [rbp - 16], 5` then you need this.
	push rbp ; DO NOT TOUCH
	mov rbp, rsp ; DO NOT TOUCH

	; The `[rbp - <n>]` syntax is "the byte size(s) that are allocated in the stack frame."
	; So in the case of `[rbp - 16]`, you get 16 bytes off the stack.

	; let foo: i32 = 5;
	mov dword [rbp - 4], 5

	; Load `foo` into register `ebx`.
	mov ebx, dword [rbp - 4]

	; ebx += 10;
	add ebx, 10

	; let bar: i32 = ebx;
	mov dword [rbp - 8], ebx

	; Move result of calculation into return register.
	movsx rax, dword [rbp - 8]

	pop rbp ; DO NOT TOUCH
	ret
