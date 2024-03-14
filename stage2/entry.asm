section text:
global _start
_start:
	mov [0xb8000], byte 'H'
	mov [0xb8002], byte 'e'
	mov [0xb8004], byte 'l'
	mov [0xb8006], byte 'l'
	mov [0xb8008], byte 'o'
	mov [0xb800a], byte ' '
	mov [0xb800c], byte 'W'
	mov [0xb800e], byte 'o'
	mov [0xb8010], byte 'r'
	mov [0xb8012], byte 'l'
	mov [0xb8014], byte 'd'
    jmp _start