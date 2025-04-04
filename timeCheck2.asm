

getTime MACRO t1

        ; Get current time
    mov ah, 2Ch
    int 21h
    ; CH = hour, CL = min, DH = sec

    ; === Print Hour ===
    mov al, ch        ; hour
    add al, t1
   
    cmp al, 0
    jl converter2

    cmp al, 24
    jl converter1



    sub al, 24
    converter1:

    aam               ; split into tens (AH) and units (AL)
    add ah, 48    ; convert to ASCII
    add al, 48

    mov bh, ah
    mov bl, al

    mov dl, bh
    mov ah, 2
    int 21h           ; print tens digit
    mov dl, bl
    mov ah, 2
    int 21h           ; print units digit

    ; Print ':'
    mov dl, ':'
    mov ah, 2
    int 21h

    ; === Print Minute ===
    mov al, cl        ; minute
    aam
    add ah, 48
    add al, 48
    mov bh, ah
    mov bl, al
    mov dl, bh
    mov ah, 2
    int 21h
    mov dl, bl
    mov ah, 2
    int 21h

    mov ah, 4ch
    int 21h

    converter2:

    add al, 24

    aam               ; split into tens (AH) and units (AL)
    add ah, 48    ; convert to ASCII
    add al, 48

    mov bh, ah
    mov bl, al

    mov dl, bh
    mov ah, 2
    int 21h           ; print tens digit
    mov dl, bl
    mov ah, 2
    int 21h           ; print units digit

    ; Print ':'
    mov dl, ':'
    mov ah, 2
    int 21h

    ; === Print Minute ===
    mov al, cl        ; minute
    aam
    add ah, 48
    add al, 48
    mov bh, ah
    mov bl, al
    mov dl, bh
    mov ah, 2
    int 21h
    mov dl, bl
    mov ah, 2
    int 21h

    mov ah, 4ch
    int 21h



 

ENDM

par MACRO p1, p2
    mov dx, offset p1 ; Print time Difference
    mov ah, 9
    int 21H
    CALL ENTERKEY

    lea dx, p2 ; Show Current time
    mov ah, 9
    int 21h
    getTime 0
    CALL ENTERKEY

    lea dx, p3 ; paris time
    mov ah, 9
    int 21h
    getTime -4
    CALL ENTERKEY




ENDM

dosseg
.model small
.stack 100h
.data
    mainTitle db "Time Zone$"
    city db '1.Amsterdam$    ' , '2.Berlin$       ' , '3.Dubai$        ' , '4.Frankfurt$    ' , '5.Hong Kong$    ' , '6.Istanbul$     ' , '7.New York$     ' , '8.Paris$        ' ,  '9.Rome$         ' , '10.Sydney$      '
    
    minusOne db 'Time difference is -1 hrs, (UTC+4).$'
    minusTwo db 'Time difference is -2 hrs, (UTC+3).$'
    minusFour db 'Time difference is -4 hrs, (UTC+1).$'
    minusNine db 'Time difference is -9 hrs, (UTC-4).$'
    plusThree db 'Time difference is +3 hrs, (UTC+8).$'
    plusSix db 'Time difference is +6 hrs, (UTC+11).$'

    amsTime db 'Amsterdam Time: $'
    berTime db 'Berlin Time: $'
    dubTime db 'Dubai Time: $'
    fraTime db 'Frankfurt Time: $'
    hongTime db 'Hong Kong Time: $'
    istTime db 'Istanbul Time: $'
    newTime db 'New York Time: $'
    parTime db 'Paris Time: $'
    romTime db 'Rome Time: $'
    sydTime db 'Sydney Time: $'

    currentTimeMsg db "Your Current Time: $"

.code
main proc

mov ax, @data
mov ds, ax

lea dx, mainTitle
mov ah, 9
int 21h

CALL ENTERKEY
CALL ENTERKEY




mov si, offset city

mov cx, 10
cities:

    lea dx, [si]
    mov ah, 9
    int 21h
   

    CALL ENTERKEY
    add si, 16
 
    loop cities


mov ah, 4ch
int 21h
main endp

ENTERKEY PROC

MOV DX, 10 ;NEWLINE
MOV AH, 2
INT 21H
MOV DX, 13
MOV AH, 2
INT 21H
RET ;RETURN

ENTERKEY ENDP

end main

