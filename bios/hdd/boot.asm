;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;boot sequence greatly inpired by Limine
; https://github.com/limine-bootloader/limine/blob/v7.x/stage1/hdd/bootsect.asm
;thanks for the inspiration, no code was copied
;modified from the original file:
; https://github.com/Pokecraft-exe/LeviathanKRNL/blob/601ffb3532a0d93431ba46d8e56825abbdf328da/ASM/boot2.s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[org 0x7c00]
[bits 16]

bios:
    jmp .skip
    nop

    .BPB:
        times 3-($-$$)  db 0
        .OEMId          db "STRAW   "
        .BytsPerSec     dw 512
        .SecPerClus     db 0
        .RsvdSecCnt     dw 0
        .NumFATs        db 0
        .RootEntCnt     dw 0
        .TotSec16       dw 0
        .Media          db 0
        .FATSz16        dw 0
        .SecPerTrk      dw 18
        .NumHeads       dw 2
        .HiDDSec        dd 0
        .TotSec32       dd 0
        .FATSz32        db 0
        .ExtFlags       db 0
        .FSVer          db 0
        .RootClus       dd 0
        .FSInfo         db "STRAWBERRY "
        .FStype         times 8 db 0


.skip:
    cli
    cld
  	xor si, si
    mov ds, si
    mov es, si
    mov gs, si
    mov fs, si
    mov ss, si
    jmp 0x0000:.start
.start:

    mov sp, 0x7c00
    sti

    cmp dl, 0x80
    jb fail.0

    cmp dl, 0x80
    ja fail.1

    mov ah, 0x41
    mov bx, 0x55aa
    int 0x13
    jc fail.2
    
    cmp bx, 0xaa55
    jne fail.2

    push 0x7000
    pop es
    mov di, locs

    mov eax, dword [di]
    mov ebp, dword [di+4]
    xor bx, bx
    xor ecx, ecx
    mov cx, word [di-4]
    call readDisk
    jc fail.4

    mov eax, dword [di+8]
    mov ebp, dword [di+12]
    add bx, cx
    mov cx, word [di-2]
    call readDisk
    jc fail.5

    lgdt [gdt]

    ; protected mode

    cli

  	mov eax, cr0
	  or eax, 1
	  mov cr0, eax

    ; enable A20
  	in al, 0x92
	  or al, 2
	  out 0x92, al

    jmp 0x08:initCS

times 0xda-($-$$) db 0
times 6 db 0

%include "disk.asm"
%include "../gdt.asm"

PrintString:
    push ax
    push bx

    mov ah, 0x0e
    .loop:
    cmp [bx], byte 0
    je .Exit
        mov al, [bx]
        int 0x10
        inc bx
        jmp .loop
    .Exit:

    pop ax
    pop bx
    ret

fail:
  mov ax, si
  .5:
    inc si
  .4:
    inc si
  .3:
    inc si
  .2:
    inc si
  .1:
    inc si
  .0:
    sub ax, si
    neg ax
    sub ax, 0x007b
    add si, '0' | (0x4f << 8)

    push 0xb800
    pop es
    mov word [es:0], si


    mov [bootFailedAtLevelString], al
    mov bx, bootFailedString
    call PrintString

    sti
    .h: hlt
    jmp .h

[bits 32]
initCS:
	mov eax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

  and edx, 0xff
  push 0
  push edx

  push stage2.size
  push 0x70000

  call 0x70000

times 0x1c7-($-$$) db 0
stage2_size_a: dw 0
stage2_size_b: dw 0
locs:
loc_a:  dq 0
loc_b:  dq 0
bootFailedString:
  db "Boot failed at level "
bootFailedAtLevelString:
  db 0, 0
times 0x1fe-($-$$) db 0
times 510-($-$$) db 0
dw 0xaa55
;;; stage 2 ;;;

align 16
stage2:
incbin '../../obj/stage2/strawberry.bin'
.size: equ $ - stage2