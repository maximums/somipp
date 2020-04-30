[bits 16]
[org 0x7C00]

mov ax, 0b800h
mov es,ax
mov si,String 
mov cx,14 
mov ah,14 
mov di,0

call strg

pop es
jmp $

strg:

mov ax, 0
mov ah, 10000100b
prt:
mov al,[si]
inc si
cmp cx, 0
je outOf
mov [es:di],al
inc di
mov [es:di],ah
inc di
dec cx
jmp prt
outOf:
ret

String DB 'Hello with VGA'

; [bits 16]
; [org 0x7C00]

; mov si, msg

; ; mov ah, 0
; ; mov al, 00h
; ; int 10h

; ; mov ax, 1003h
; ; mov bl, 3
; ; mov bh, 0
; ; int 10h

; call StringPrint
; ; mov si, msg1
; ; mov ah, 2
; ; mov bh, 0
; ; mov dh, 0
; ; mov dl, 60
; ; int 10h
; ; call StringPrint2
; ; call StringPrint3
; ; mov si ,msg3
; ; call StringPrint4
; looop:
; call Print2Screen
; jmp looop
; jmp $

; ; StringPrint3:
; ; mov ah, 13h
; ; mov bp, msg2
; ; mov al, 1
; ; mov bh, 0
; ; mov bl, 11000011b
; ; mov cx, 10
; ; mov dl, 0
; ; mov dh, 3
; ; int 10h
; ; ret

; StringPrint:

; repet:
; mov al, [si]
; inc si
; or al, al
; jz outOf
; call CharPrint
; jmp repet
; outOf:
; ret

; CharPrint:

; mov ah, 3
; mov bh, 0
; int 10h

; mov cx, 1
; mov ah, 9
; mov bh, 0
; mov bl, 11101110b
; int 10h

; mov ah, 2
; mov bh, 0
; inc dl
; int 10h

; ret

; ; CharPrint2:
; ; ; mov ah, 3
; ; ; mov bh, 0
; ; ; int 10h

; ; mov cx, 1
; ; mov ah, 0Ah
; ; mov bh, 0
; ; int 10h

; ; mov ah, 2
; ; mov bh, 0
; ; inc dl
; ; int 10h
; ; ret

; ; StringPrint4:
; ; mov ah, 2
; ; mov dh, 3
; ; mov dl, 60
; ; int 10h

; ; repet3:
; ; mov al, [si]
; ; inc si
; ; or al, al
; ; jz outOf3
; ; call CharPrint3
; ; jmp repet3
; ; outOf3:
; ; ret

; ; CharPrint3:

; ; mov ah, 0x0E
; ; mov bh, 0
; ; mov bl, 8
; ; int 10h


; ; ret

; ; StringPrint2:

; ; repet2:
; ; mov al, [si]
; ; inc si
; ; or al, al
; ; jz outOf2
; ; call CharPrint2
; ; jmp repet2
; ; outOf2:
; ; ret




; Print2Screen:

; mov ah, 0
; int 16h

; cmp al, 13
; je newline

; cmp al, 8
; je backspace

; call CharPrint
; ret

; backspace:
; mov ah, 2
; mov bh, 0
; dec dl
; int 10h
; mov al, 20h
; mov cx, 1
; mov ah, 9
; int 10h
; ret

; newline:
; mov ah, 2
; mov bh, 0
; inc dh
; mov dl, 0
; int 10h
; ret

; msg db 'Hello World!', 0
; msg1 db 'hi friend', 0
; msg2 db 'hey amigo!', 0
; msg3 db 'Gutan Tag' , 0