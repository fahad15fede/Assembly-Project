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

par MACRO p1, p2, p3
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
.model small
.stack 100h

.data
    userinput db ' Select a city : $'
    mainTitle db "Time Zone$"
    city db '1.Amsterdam$    ', '2.Berlin$       ', '3.Dubai$        ', '4.Frankfurt$    ',
          '5.Hong Kong$    ', '6.Istanbul$     ', '7.New York$     ', '8.Paris$        ', 
          '9.Rome$         ', '10.Sydney$      '
    
    minusOne db 'Time difference is -1 hrs, (UTC+4).$'
    minusTwo db 'Time difference is -2 hrs, (UTC+3).$'
    minusFour db 'Time difference is -4 hrs, (UTC+1).$'
    plusThree db 'Time difference is +3 hrs, (UTC+8).$'
    plusSix db 'Time difference is +6 hrs, (UTC+11).$'
    minusNine db 'Time difference is -9 hrs, (UTC-5).$'

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

    lea dx, city
    mov ah, 9
    int 21h

    ; Wait for user input (city selection)
    lea dx, userinput
    mov ah, 9
    int 21h

    mov ah, 1         ; Read character
    int 21h

    ; Process user input (1 to 10)
    sub al, '0'       ; Convert ASCII to integer

    ; Call appropriate procedure based on user input (1-10)
    cmp al, 1
    jmp far ptr call_Ams
    cmp al, 2
    jmp far ptr call_Ber
    cmp al, 3
    jmp far ptr call_Dub
    ; cmp al, 4
    ; je call_Fra
    ; cmp al, 5
    ; je call_Hong
    ; cmp al, 6
    ; je call_Ist
    ; cmp al, 7
    ; je call_New
    ; cmp al, 8
    ; je call_Paris
    ; cmp al, 9
    ; je call_Rome
    ; cmp al, 10
    ; je call_Syd

    ; If input is invalid (not between 1 and 10)
    mov ah, 4Ch
    int 21h

call_Ams:
    par minusOne, currentTimeMsg, amsTime
    CALL exitProg

call_Ber:
    par minusOne, currentTimeMsg ,berTime
    CALL exitProg

call_Dub:
    par minusTwo ,currentTimeMsg, dubTime
    CALL exitProg

; call_Fra:
;     par minusFour currentTimeMsg fraTime
;     CALL exitProg

; call_Hong:
;     par plusThree currentTimeMsg hongTime
;     CALL exitProg

; call_Ist:
;     par plusThree currentTimeMsg istTime
;     CALL exitProg

; call_New:
;     par minusNine currentTimeMsg newTime
;     CALL exitProg

; call_Paris:
;     par minusFour currentTimeMsg parTime
;     CALL exitProg

; call_Rome:
;     par minusFour currentTimeMsg romTime
;     CALL exitProg

; call_Syd:
;     par plusSix currentTimeMsg sydTime
;     CALL exitProg

exitProg:
    mov ah, 4Ch
    int 21h

main endp
ENTERKEY PROC
    MOV DX, 10    ; NEWLINE
    MOV AH, 2
    INT 21H
    MOV DX, 13    ; CARRIAGE RETURN
    MOV AH, 2
    INT 21H
    RET
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
