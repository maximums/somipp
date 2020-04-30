[bits 16]
[org 0x7C00]

mov ah, 0x02
mov dl, 0
mov ch, 0
mov dh, 0
mov al, 1
mov cl, 2
mov bx, 0x7C00 + 512
int 0x13
jmp $
