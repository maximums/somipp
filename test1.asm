[bits 16]
[org 0x7C00]

mov di, msg
call StringPrint
mov si, string
looop:
call Print2Screen
jmp looop

StringPrint:
ag1:
mov al, [di]
inc di
or al, al
jz outOf3
call CharPrint3
jmp ag1
outOf3:
ret

CharPrint3:
mov ah, 0x0E
mov bh, 0
int 10h
ret

Print2Screen:
mov ah, 0
int 16h
cmp al, 13
je newline
cmp al, 8
je backspace
cmp si, 256+string
jz outOfhere
call CharPrint2
outOfhere:
ret

CharPrint2:
mov ah, 0x0E
mov bh, 0
int 10h
mov [si], al
inc si
ret

newline:
mov si, string
mov al, 0xA
mov ah, 0x0E
int 10h
mov al, 0xD
mov ah, 0x0E
int 10h
cmp word [si], 0
je there
call printbuffer
mov al, 0xA
mov ah, 0x0E
int 10h
mov al, 0xD
mov ah, 0x0E
int 10h
mov al, 0xA
mov ah, 0x0E
int 10h
mov al, 0xD
mov ah, 0x0E
int 10h
there:
call clearBuffer
mov di, msg  
call StringPrint
ret

printbuffer:
repet:
cmp word [si], 0
je ex
mov al, [si]
inc si
call CharPrint3
jmp repet
ex:
ret


clearBuffer:
mov si, string
again:
cmp word [si], 0
je exit
mov word [si], 0
inc si
jmp again
exit:
mov si, string
ret

backspace:
cmp word [string], 0
jz outt
mov ah, 3
int 10h
cmp dl,0
jne here
dec dh
mov dl,80
here:
cmp dl,0
je there1
dec dl
there1:
mov ah, 2
int 10h
mov al, 20h
mov ah, 9
mov bl, 7
int 10h
dec si
mov word [si], 0
outt:
ret




count: times 1 db 0
string: times 256 db 0
msg db 'Dodi:~$ ', 0

