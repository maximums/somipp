[bits 16]
[org 0x7C00]


call printStr

mov ah, 0
cmp al, 13
je newline
int 16h


again:
call ScreenPrint
jmp again

ScreenPrint:

mov ah, 3
mov bh, 0
int 10h

mov ah, 9
mov bl, 4
mov bh, 0
mov cx, 1
int 10h

mov ah, 2
inc dl
int 10h
ret

printStr:
mov ah, 13h
mov al, 1
mov bh, 0
mov bl, 4
mov cx, 19
mov bp, msg1
mov dl, 0
mov dh, 0
int 10h
ret

newline:
mov ah, 2
inc dh
mov bh, 0
mov dl, 0
int 10h
ret

msg1 db 'Enter first number:', 0
msg2 db 'Enter second number:', 0
