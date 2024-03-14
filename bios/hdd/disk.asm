readDisk:
    pusha

    mov si, .da_struct

    mov word [si], 16
    mov word [si+2], 1
    mov word [si+4], bx
    mov word [si+6], es

	push dx
	push si

	push eax
	push ebp

	mov ah, 0x48
	mov si , .drive_params
	mov word [si], 30 ; buffer_size
	int 0x13
	jc .success
	mov bp, word [si+24] ; bytes per sectors

	mov ax, cx
	shr ecx, 16
	mov dx, cx
	xor cx, cx
	div bp
	test dx, dx
	setnz cl
	add cx, ax

	pop edx
	pop eax

	pop si

	div ebp
	mov dword [si+8], eax
	mov dword [si+12], 0

	pop dx

	.loop:
	    mov ah, 0x42

	    clc
    	int 0x13
    	jc .success

	    add word  [si+4], bp
    	xor ebx, ebx
    	inc dword [si+8]
    	seto bl
    	add dword [si+12], ebx

	    loop .loop

.success:
	popa
	ret
	
  .da_struct:    equ 0x8000
  .drive_params: equ 0x8010