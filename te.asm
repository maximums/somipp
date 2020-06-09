[BITS 16]	                       
[ORG 0x7C00]


SECTION .data

string: db 'criss> ',0
len: equ $ - string  
buffer: times 256 db 0


SECTION .text

mov di,buffer
mov si,string
call printString

repp: call readKey
jmp repp

printString:

again:
mov al,[si]
inc si
or al,al
jz exit
call printChar
jmp again
exit:
ret

printChar:

; mov cx,1
; mov ah,9h
; mov bl,3
; int 10h

; mov ah,3
; int 10h

; mov ah,2
; inc dl
; int 10h

mov ah,0x0E
int 10h

ret

readKey:

mov ah,0
int 16h

cmp al, 13
jz printNewLine
cmp al,8
jz printbackspace

cmp di,256+buffer
jz fin

call putInBuffer
call printChar
ret

putInBuffer:
mov [di],al
inc di

fin:

ret

printBuffer:
mov si, buffer
call printString

call clearBuffer
mov di,buffer

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

mov si,string
call printString
ret

printNewLine:

mov al, 0xA
mov ah, 0x0E
int 10h

mov al, 0xD
mov ah, 0x0E
int 10h


cmp word [buffer],0
jne printBuffer

call clearBuffer
mov di,buffer

mov si,string
call printString

ret


clearBuffer:

mov si, buffer
ag:
cmp word [si], 0
jz exxx
mov word [si],0
inc si
jmp ag

exxx:
ret


printbackspace:

cmp word [buffer],0
jz ex

; mov ah,3
; int 10h

; inc dl
; cmp dl,len
; jz ex


mov ah,3
int 10h


cmp dl,0
jne skip
dec dh
mov dl,80
skip:

cmp dl,0
je skipp
dec dl
skipp:


mov ah,2
int 10h


mov al, 20h
mov ah, 9
mov bl,0xF
int 10h

; mov ah,3
; int 10h
; dec dl
; mov ah,2
; int 10h


dec di
mov word [di],0


ex:

ret

