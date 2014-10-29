; Hexadecimal printer for single byte
; Prints 1 byte, so argument should be in al
; Doesn't truncate the number (i.e. will always print 2 hex digits)
hexPrintB proc
    push ax
    push bx
    push cx
    push dx
    
    mov bl, al
    ; storing al in bl because
    ; al and dh are changing their values
    ; during the interrupt
    mov ch, 2
    mov cl, 4
    mov ah, 2
    hexPrintB_loop:
        mov dl, bl
        cmp ch, 1
        je no_shr
        shr dl, cl
    no_shr:
        and dl, 0fh
        cmp dl, 9
        jg hex_chr
        add dl, '0'
        jmp chr_prn
    hex_chr:
        add dl, 55
    chr_prn:
        int 21h
        dec ch
        cmp ch, 0
        jne hexPrintB_loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
hexPrintB endp
