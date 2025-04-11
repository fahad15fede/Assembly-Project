
getTime MACRO t1
      LOCAL calling_converter1, calling_converter2, skipConverter

        ; Get current time
    mov ah, 2Ch
    int 21h
    ; CH = hour, CL = min, DH = sec

    ; === Print Hour ===
    mov al, ch        ; hour
    add al, t1
   
    cmp al, 0
    jl calling_converter2

    cmp al, 24
    jge calling_converter1

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

    mov dl, ':'
    mov ah, 2
    int 21h

    mov al, cl
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

    jmp skipConverter

calling_converter1:
    call converter1
    jmp skipConverter

calling_converter2:
    call converter2

skipConverter:
ENDM

par MACRO p1, p2, p3 , p4, p5
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

    travel p4, p5

ENDM

travel MACRO t1, t2

    mov si, offset t2

    mov dx , offset t1
    mov ah, 9
    int 21h
    call ENTERKEY

    timeloop:
    mov di, si
    mov ah,1
    int 21h
    cmp al, 13
    je landingTime
    mov [di],al
    inc di
    jmp timeloop


    landingTime:
    mov ax, 10
        mov cx,[si]
        sub cx, 48

        mul cx

        inc si 
        mov bx, [si]
        sub bx, 48  
        add ax, bx
        aam
        mov bh, ah
        mov bl ,al
        add bh, 48
        add bl, 48
        mov dl, bh
        mov ah, 2
        int 21h
        mov dl, bl
        mov ah, 2
        int 21h




    ENDM


    


dosseg
.model small
.stack 100h
.data

    inptime db 100 dup('$') 
    userinput db ' Select a city : $'
    mainTitle db "Time Zone$"
    city db '1.Amsterdam$    ' , '2.Berlin$       ' , '3.Dubai$        ' , '4.Frankfurt$    ' , '5.Hong Kong$    ' , '6.Istanbul$     ' , '7.New York$     ' , '8.Paris$        ' ,  '9.Rome$         ' , '10.Sydney$      '
    
    minusOne db ' Time difference is -1 hrs, (UTC+4).$'
    minusTwo db ' Time difference is -2 hrs, (UTC+3).$'
    minusFour db ' Time difference is -4 hrs, (UTC+1).$'
    minusNine db ' Time difference is -9 hrs, (UTC-4).$'
    plusThree db ' Time difference is +3 hrs, (UTC+8).$'
    plusSix db ' Time difference is +6 hrs, (UTC+11).$'

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
    macroInput db "Enter Your Flight Take off time in this format: hh:mm: $"

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

    CALL ENTERKEY
    choice:
    lea dx, userinput
    MOV ah, 9
    int 21h 

    mov ah, 1
    int 21h

    ; sub al, '0'


    cmp al, '8'
    jmp far ptr calling_Paris

    ; cmp al, '9'
    ; jmp far ptr calling_Rome

    
    ; cmp al, '0'
    ; je calling_Sydney
mov ah, 4ch
int 21h

calling_Paris:
    par minusFour, currentTimeMsg, parTime , macroInput, inptime
    jmp choice    

    mov ah, 4ch
    int 21h

; calling_Rome:
;     par minusFour currentTimeMsg romTime, macroInput, inptime
;     jmp choice    
;     mov ah, 4ch
;     int 21h

; calling_Sydney:
;     par plusSix currentTimeMsg sydTime, macroInput, inptime
;     jmp choice    
;     mov ah, 4ch
;     int 21h

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


converter1 PROC

    sub al, 24
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


    RET ;RETURN

converter1 ENDP

converter2 PROC
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
    RET ;RETURN

converter2 ENDP

end main

