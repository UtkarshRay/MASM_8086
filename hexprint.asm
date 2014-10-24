; Hexadecimal printer
; Takes argument in ax
; Only prints the integer, restores ax
; Doesn't truncate the number (i.e. will always print 4 hex digits)

hexPrint proc
    push ax
    push bx
    push cx
    push dx
    
    ; mov bx, 4
    ; mov cx, 4

    mov bx, ax
    
    mov ah, 2
    mov ax, bx
    
    mov dh, 4
    mov cl, 4
while90:
    rol ax, cl
    mov bx, 0fh
    and bx, ax
    cmp bx, 9
    jg hex
    add bx, '0'
    jmp hex_ch_print
hex:
    add bx, 55
hex_ch_print:
    mov dl, bl
    mov bx, ax
    mov ah, 2
    int 21h
    mov ax, bx
    dec dh
    jnz while90
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
hexPrint endp
