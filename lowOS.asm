; /////////////////////////////// 512 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
[bits 16]
[org 0x7C00]
xor ax,ax
mov ds,ax
mov es,ax
mov bx,0x7E00
mov ss,bx
mov sp,ax

retry:
mov ah,2
mov al,2
mov ch,0
mov cl,2
mov dh,0
int 13h

jnc boot2
jmp retry
boot2:
jmp 0x07E0:0x00

msg2 db 'Password', 0
msg1 db 'User', 0
msg db 'Press C to clear the screen', 0
dabro db 'Success!', 0
error db 'Incorrect Password :(', 0
fixedPass db 'everest8849', 0
userName:times 15 db 0
password:times 15 db 0
TIMES 510 - ($ - $$) db 0
leng :times 1 db 0
DW 0xAA55 

; ////////////////////// OUT ///////////////////////////////////////////
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
cmp al, 9
je newline
cmp al, 8
je backspace
cmp al, 13
je checkPass
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

stringPrint:
mov ah, 2
inc dh
inc dh
inc dh
mov dl, 32
int 10h
repeate:
cmp byte [si], 0
je exit
mov al, [si]
mov ah, 9
mov cx, 1
mov bh, 0
mov bl, 00000010b
int 10h
inc si
mov ah, 2
inc dl
int 10h
jmp repeate
exit:
ret


checkPass:
mov di, fixedPass
mov si, password
aga:
mov bl, byte [di]
cmp bl, byte [si]
jne faile
inc si
inc di
cmp byte [si], 0
jne aga
cmp byte [di], 0
je succes
succes:
jmp prompt
jmp outy
faile:
mov si, error
push dx
call stringPrint
mov ah, 2
pop dx
int 10h
outy:
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
cmp dh, 14
je name
pass:
mov ah, 2
mov dl, 32
mov dh, 14
int 10h
mov di, password
jmp tt
name:
mov ah, 2
mov dl, 32
mov dh, 10
int 10h
mov di, userName
tt:
ret

starPrint:
mov [di], al
inc di
mov cx, 1
mov ah, 9
mov al, 2Ah
mov bh, 0
mov bl, 01110000b
int 10h
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

; /////////////////////////////////////////////////////////////////

prompt:
call cls
mov di, msgg
call StringPrint
mov si, string
looop1:
call Print2Screen1
jmp looop1

cls:
mov al, 3
mov ah, 0
int 10h
ret

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
cmp si, 128+string
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
repet11:
cmp word [si], 0
je ex
mov al, [si]
inc si
call CharPrint3
jmp repet11
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
jz outt1
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
outt1:
ret

; mov di, fixedPass
; mov si, password
checkComm:
aga11:
mov bl, byte [di]
cmp bl, byte [si]
jne faile11
inc si
inc di
cmp byte [si], 0
jne aga11
cmp byte [di], 0
je succes11
succes11:
; Execute commands
jmp outy
faile:
mov di, err
; push dx
call StringPrint
; mov ah, 2
; pop dx
; int 10h
outy:
ret

string: times 128 db 0
msgg db 'Dodi:~$ ', 0
cleaaaar db 'cls ', 0
err db 'Unknown command', 0
write db 'w2s ', 0
