; tests if 10-byte packed BCD at bx is 0
; ax = 1 if zero
; ax = 0 otherwise
zerop_bcd proc
    push cx
    push dx
    push si
    
    mov dx, 0
    mov si, bx
    mov cx, 9
    cld
    zerop_bcd_loop:
        lodsb
        cmp al, 0
        jne zerop_bcd_cleanup
        loop zerop_bcd_loop
    mov dx, 1
zerop_bcd_cleanup:
    mov ax, dx
    pop si
    pop dx
    pop cx
    ret
zerop_bcd endp
