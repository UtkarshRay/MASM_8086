; Hexadecimal printer
; Takes argument in ax, restores ax
; Doesn't truncate the number (i.e. will always print 4 hex digits)

hexPrintW proc
    push ax
    push bx
    push cx
    push dx
    
    mov bx, ax
    mov ah, 2
    mov ch, 4
    mov cl, 4
    hexPrintW_loop:
        rol bx, cl
        mov dx, bx
        and dx, 0fh
        cmp dx, 9
        jg hex_ch
        add dx, '0'
        jmp hex_ch_print
    hex_ch:
        add dx, 55
    hex_ch_print:
        int 21h
        dec ch
        jnz hexPrintW_loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
hexPrintW endp
