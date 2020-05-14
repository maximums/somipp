[bits 16]
[org 0x7C00]

mov di, userName
mov bp, msg
call stringPring
mov ah, 0
int 16h
cmp al, 99
je clearScreen
here:
call printBorders
call stringUser
mov ah, 2
mov bh, 0
mov dl, 32
mov dh, 10
int 10h
call stringBlank
call stringPassword
mov ah, 2
mov bh, 0
mov dl, 32
mov dh, 14
int 10h
call stringBlank
mov ah, 2
mov bh, 0
mov dl, 32
mov dh, 10
int 10h

looop:
call Print2Screen
jmp looop

Print2Screen:
mov ah, 0
int 16h
cmp al, 13
je newline
cmp al, 8
je backspace
cmp dl, 45
je out1
cmp dh, 14
je ok
call CharPrint
jmp out1
ok:
call starPrint
out1:
ret

backspace:
cmp dh, 14
je there
mov ah, 9
mov al, 20h
mov bh, 0
mov cx, 1
mov bl, 01110000b
int 10h
mov byte [di], 0
cmp dl, 32
je outt
dec di
mov ah, 2
dec dl
int 10h
jmp outt
there:
mov ah, 9
mov al, 20h
mov bh, 0
mov cx, 1
mov bl, 01110000b
int 10h
cmp dl, 32
je some
mov byte [di], 0
dec di
mov ah, 2
dec dl
int 10h
jmp outt
some:
mov ah, 2
mov dx, [si]
int 10h
mov di, userName
outt:
ret

newline:
mov [si], dx
mov ah, 3
mov bh, 0
int 10h
mov ah, 2
mov dl, 32
mov dh, 14
int 10h
mov di, password
ret

starPrint:
mov cx, 1
mov ah, 9
mov al, 2Ah
mov bh, 0
mov bl, 01110000b
int 10h
mov [di], al
inc di
mov ah, 2
inc dl
int 10h
ret

CharPrint:
mov cx, 1
mov ah, 9
mov bh, 0
mov bl, 01110000b
int 10h
mov [di], al
inc di
mov ah, 2
inc dl
int 10h
ret

printHLine:
repet:
cmp dl, 70
je outOF
call printsym
mov ah, 2
mov bh, 0
inc dl
int 10h
jmp repet
outOF:
ret

printVLine:
repet1:
cmp dh, 21
je outOF1
call printsym
mov ah, 2
mov bh, 0
inc dh
int 10h
jmp repet1
outOF1:
ret

printBorders:
mov ah, 3
mov bh, 0
int 10h
mov dh, 5
mov dl, 5
mov bh, 0
mov ah, 2
int 10h
call printHLine
mov ah, 3
mov bh, 0
int 10h
mov dh, 5
mov bh, 0
mov ah, 2
int 10h
call printVLine
mov ah, 3
mov bh, 0
int 10h
mov dh, 20
mov dl, 6
mov bh, 0
mov ah, 2
int 10h
call printHLine
mov ah, 3
mov bh, 0
int 10h
mov dh, 5
mov dl, 5
mov bh, 0
mov ah, 2
int 10h
call printVLine
ret

printsym:
mov cx, 1
mov ah, 9
mov al, 178
mov bh, 0
mov bl, 2
int 10h
ret

stringPring:
mov ah, 13h
; mov bp, msg
mov al, 1
mov bh, 0
mov bl, 00000010b
mov cx, 27
mov dl, 0
mov dh, 3
int 10h
ret

clearScreen:
mov al, 3
mov ah, 0
int 10h
jmp here


stringUser:
mov ah, 2
mov dh, 9
mov dl, 35
int 10h
mov ah, 13h
mov bp, msg1
mov al, 1
mov bh, 0
mov bl, 00000010b
mov cx, 4
int 10h
ret

stringPassword:
mov ah, 2
mov dh, 13
mov dl, 35
int 10h
mov ah, 13h
mov bp, msg2
mov al, 1
mov bh, 0
mov bl, 00000010b
mov cx, 8
int 10h
ret

stringBlank:
mov cx, 15
mov ah, 9
mov al, 32
mov bh, 0
mov bl, 01110000b
int 10h
ret

msg2 db 'Password', 0
msg1 db 'User', 0
msg db 'Press C to clear the screen', 0
userName:times 15 db 0
password:times 15 db 0