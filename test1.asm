dosseg
.model small
.stack 100h
.data
    var1 db 'pakistan zindabad$'

.code
main proc

mov ax, @data
mov ds, ax

mov ax, 10
        mov cx,'2'
        sub cx, 48

        mul cx

        inc si 
        mov bx, '2'
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



mov ah, 4ch
int 21h

main endp 
end main