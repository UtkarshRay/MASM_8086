; tests if 80-bit real at bx is 0
; ax = 1 if zero
; ax = 0 otherwise
zerop proc
    push cx
    push dx
    push si
    
    mov dx, 0
    
    mov al, [bx+9]
    test al, 07fh   ; exponent is zero, ignore sign bit
    jne zerop_cleanup
    
    mov si, bx
    mov cx, 9
    cld
    zerop_loop:
        lodsb
        cmp al, 0
        jne zerop_cleanup
        loop zerop_loop
    mov dx, 1
zerop_cleanup:
    mov ax, dx
    pop si
    pop dx
    pop cx
    ret
zerop endp
