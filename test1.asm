[bits 16]
[org 0x7C00]

mov di, msgg
call StringPrint
mov si, string
looop:
call Print2Screen1
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

Print2Screen1:
mov ah, 0
int 16h
cmp al, 13
je newlinee
cmp al, 8
je backspacee
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

newlinee:
mov si, string
mov al, 0xA
mov ah, 0x0E
int 10h
mov al, 0xD
mov ah, 0x0E
int 10h
cmp word [si], 0
je there2
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
there2:
call clearBuffer
mov di, msgg  
call StringPrint
ret

printbuffer:
repet1:
cmp word [si], 0
je ex
mov al, [si]
inc si
call CharPrint3
jmp repet1
ex:
ret


clearBuffer:
mov si, string
again:
cmp word [si], 0
je exit1
mov word [si], 0
inc si
jmp again
exit1:
mov si, string
ret

backspacee:
cmp word [string], 0
jz outt
mov ah, 3
int 10h
cmp dl,0
jne here11
dec dh
mov dl,80
here11:
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
msgg db 'Dodi:~$ ', 0

