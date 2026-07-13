; read-only data
section .rodata
	str: db "Hello, world!", 0xA
	strlen: equ $ - str
	str2: db "Foo, bar, baz", 0xA
	str2len: equ $ - str2

section .text
	; Imports
	extern print ; fn print(buf@rsi: *const void, count@rdx: size_t) -> ssize_t@rax;

	; Exports
	global main ; fn main() -> i32@rax;

	; fn main() -> i32@rax;
	main:
		; Stack fuckery (actual wizardry, do not touch).
		; Effectively, if you want to do stuff like `mov qword [rbp - 0xF], 5` then you need this.
		push rbp
		mov rbp, rsp

		call print_test

		; The `[rbp - <n>]` syntax is "the byte size(s) that are allocated in the stack frame."
		; So in the case of `[rbp - 0xF]`, you get 0xF (16) bytes off the stack.

		; let foo: i32 = 5;
		mov dword [rbp - 0x4], 5

		; Load `foo` into register `ebx`.
		mov ebx, dword [rbp - 0x4]

		; ebx += 10;
		add ebx, 10

		; let bar: i32 = ebx;
		mov dword [rbp - 0x8], ebx

		; Move result of calculation into return register.
		movsx rax, dword [rbp - 0x8]

		pop rbp
		ret

	print_test:
		mov rsi, str
		mov rdx, strlen
		call print
		mov rsi, str2
		mov rdx, str2len
		call print
		ret
