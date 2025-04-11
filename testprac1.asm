dosseg
.model small
.stack 100h

.data
    var1 db 'pakistan zindabad$'
    p db 0
    a db 0
    k db 0
    i db 0
    s db 0
    t db 0
    n db 0
    z db 0
    d db 0
    b db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    mov si, offset var1

next_char:
    mov bl, [si]
    cmp bl, '$'
    je display_result

    ; Compare characters
    cmp bl, 'p'
    je inc_p
    cmp bl, 'a'
    je inc_a
    cmp bl, 'k'
    je inc_k
    cmp bl, 'i'
    je inc_i
    cmp bl, 's'
    je inc_s
    cmp bl, 't'
    je inc_t
    cmp bl, 'n'
    je inc_n
    cmp bl, 'z'
    je inc_z
    cmp bl, 'd'
    je inc_d
    cmp bl, 'b'
    je inc_b

    jmp skip_inc

inc_p:
    inc p
    jmp skip_inc
inc_a:
    inc a
    jmp skip_inc
inc_k:
    inc k
    jmp skip_inc
inc_i:
    inc i
    jmp skip_inc
inc_s:
    inc s
    jmp skip_inc
inc_t:
    inc t
    jmp skip_inc
inc_n:
    inc n
    jmp skip_inc
inc_z:
    inc z
    jmp skip_inc
inc_d:
    inc d
    jmp skip_inc
inc_b:
    inc b

skip_inc:
    inc si
    jmp next_char

; --------------------------------------
; Display Results
; --------------------------------------
display_result:

    mov dl, 'p'
    call print_char
    mov al, p
    call print_num

    mov dl, 'a'
    call print_char
    mov al, a
    call print_num

    mov dl, 'k'
    call print_char
    mov al, k
    call print_num

    mov dl, 'i'
    call print_char
    mov al, i
    call print_num

    mov dl, 's'
    call print_char
    mov al, s
    call print_num

    mov dl, 't'
    call print_char
    mov al, t
    call print_num

    mov dl, 'n'
    call print_char
    mov al, n
    call print_num

    mov dl, 'z'
    call print_char
    mov al, z
    call print_num

    mov dl, 'd'
    call print_char
    mov al, d
    call print_num

    mov dl, 'b'
    call print_char
    mov al, b
    call print_num

    mov ah, 4ch
    int 21h

main endp

; --------------------------------------
; Print single character and colon
; Input: DL = char
; --------------------------------------
print_char proc
    mov ah, 2
    int 21h

    mov dl, ':'
    mov ah, 2
    int 21h

    ret
print_char endp

; --------------------------------------
; Print numeric value in AL
; --------------------------------------
print_num proc
    add al, 30h
    mov dl, al
    mov ah, 2
    int 21h

    call newline
    ret
print_num endp

; --------------------------------------
; Newline: CR + LF
; --------------------------------------
newline proc
    mov dl, 13
    mov ah, 2
    int 21h

    mov dl, 10
    mov ah, 2
    int 21h
    ret
newline endp

end main