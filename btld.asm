[BITS 16]	                       
[ORG 0x7C00]

xor ax,ax
mov ds,ax
mov es,ax

add ax,0x9000
mov ss,ax
mov sp,0xF000

mov ah,0
int 13h

retry:

mov ax,0x07E0
mov es,ax
xor bx,bx

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

TIMES 510 - ($ - $$) db 0
DW 0xAA55 

;////////////////////////////////////////////////////////////////////



mov bx,1 ; uncolor mode
mov si,info
call printS

mov cx,15
loopp:
mov si,trash
call printS
dec cx
or cx,cx
jz .ex
jmp loopp
.ex:

mov si,msg
call printS

mov ah,0
int 16h

cmp al,63h
jne .skip
call clearScreen
.skip:

call displayUserWindow

jmp $

displayUserWindow:
mov ah,2
mov dl,15
mov dh,5
int 10h

mov al,178
mov cx,50
.loop1:
call printC
dec cx
or cx,cx
jz .ex1
jmp .loop1
.ex1:

mov ah,2
mov dl,15
mov dh,20
int 10h

mov al,178
mov cx,50
.loop11:
call printC
dec cx
or cx,cx
jz .ex11
jmp .loop11
.ex11:
;===============================
mov al,178
mov dh,5
mov cx,15
.loop2:
mov dl,15
mov ah,2
int 10h
inc dh
call printC
dec cx
or cx,cx
jz .ex2
jmp .loop2
.ex2:

mov al,178
mov dh,5
mov cx,15
.loop22:
mov dl,64
mov ah,2
int 10h
inc dh
call printC
dec cx
or cx,cx
jz .ex22
jmp .loop22
.ex22:

;======================
mov ah,2
mov dh,8
mov dl,35
int 10h
mov si,us
call printS

mov ah,2
add dh,2
add dl,-5
int 10h
mov al," "
xor bx,bx ; color mode
mov si,blank
call printS

mov ah,2
mov dh,14
mov dl,35
int 10h
mov bx,1 ; uncolor mode
mov si,psw
call printS

mov ah,2
add dh,2
add dl,-5
int 10h
mov al," "
xor bx,bx ; color mode
mov si,blank
call printS


ret


clearScreen:
mov cx,40
mov al,10
mov ah,0x0E
.loop:
int 10h
dec cx
or cx,cx
jz .ex
jmp .loop
.ex:
mov al,13
int 10h
ret


printS:
.again:
mov al,[si]
inc si
or al,al
jz .ex
or bx,bx
jz .color
call printC
jmp .again
.color:
call printColorC
jmp .again
.ex:
ret

printC:
mov ah,0x0E
int 10h
ret

printColorC:
push bx
mov ah,9
mov cx,1
mov bh,0
mov bl,01111111b
int 10h

mov ah,3
int 10h
mov ah,2
inc dl
int 10h

pop bx

ret

info: db "This OS is developed by great sage MISA!!!",10,13,0
trash: db "PRAISE THE GREAT MISA AND YOU WILL HAVE NO BUGS!!!",10,13,0
msg: db 10,13,"Press 'C' to clear the screen... ",10,13,0
psw: db "Password:",0
us: db "Username:",0
blank: db "                    ",0
pswBuff: times 10 db 0
usBuff: times 10 db 0
TIMES 1024 - ($ - $$) db 0