dosseg
.model small
.stack 100h
.data
    var1 db 'pakistan zindabad$'
    p db 48
    a db 48
    k db 48
    i db 48
    s db 48
    t db 48
    n db 48
    z db 48
    d db 48
    b db 48

.code
main proc

    mov ax, @data
    mov ds, ax

    mov si, offset var1
l1:
    mov bl, [si]
    cmp bl, '$'
    je endit

    cmp bl, 'p'
    je pcount
    cmp bl, 'a'
    je acount
    cmp bl, 'z'
    je zcount
    cmp bl, 'k'
    je kcount
    cmp bl, 'n'
    je ncount
    cmp bl, 't'
    je tcount
    cmp bl, 'b'
    je bcount
    cmp bl, 'd'
    je dcount
    cmp bl, 'i'
    je icount

    jmp skip_inc


pcount:
    add p, 1
    jmp skip_inc
zcount:
    add z, 1
    jmp skip_inc
tcount:
    add t, 1
    jmp skip_inc
dcount:
    add d, 1
    jmp skip_inc
bcount:
    add b, 1
    inc si
    jmp skip_inc
ncount:
    add n, 1
    jmp skip_inc
kcount:
    add k, 1
    jmp skip_inc
acount:
    add a, 1
    jmp skip_inc
icount:
    add i, 1
    jmp skip_inc
scount:
    add s, 1
    jmp skip_inc

skip_inc:
    inc si
    jmp l1
endit:
    mov dl, 'p'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
    mov dl, p
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 'a'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
     mov dl, a
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 'k'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
     mov dl, k
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 'i'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
     mov dl, i
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 's'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
     mov dl, s
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 't'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
     mov dl, t
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 'n'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
    mov dl, n
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 'z'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h    
     mov dl, z
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 'd'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h    
    mov dl, d
    mov ah, 2
    int 21h
    ; call ENTERKEY
    mov dl, 'b'
    mov ah, 2
    int 21h
    mov dl, ':'
    mov ah, 2
    int 21h
    mov dl, b
    mov ah, 2
    int 21h
    ; call ENTERKEY

    mov ah, 4ch
    int 21h

main endp
end main

ENTERKEY PROC
    MOV DX, 10    ; NEWLINE
    MOV AH, 2
    INT 21H
    MOV DX, 13    ; CARRIAGE RETURN
    MOV AH, 2
    INT 21H
    RET
ENTERKEY ENDP
