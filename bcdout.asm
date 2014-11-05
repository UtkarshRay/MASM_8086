; bcdout(addr, n)
; prints least significant n digits of packed BCD at addr
bcdout proc
    push bp
    mov bp, sp
    push ax
    push cx
    push dx
    push si
    
    mov cx, [bp + 4]    ; digits
    mov si, [bp + 6]    ; address
    
    cmp cx, 0           ; don't print anything
    jle bcdout_cleanup
    cmp cx, 18
    jle bcdout_1
    mov cx, 18          ; print only 18 digits
    
bcdout_1:
    mov dx, cx
    shr cx, 1
    add si, cx
    
    test dx, 01
    jz bcdout_2
    mov dl, [si]
    and dl, 0fh
    mov ah, 2
    add dl, '0'
    int 21h
bcdout_2:
    dec si
    jcxz bcdout_cleanup
    std
    bcdout_loop:
        lodsb
        call hexPrintB
        loop bcdout_loop
bcdout_cleanup:
    pop si
    pop dx
    pop cx
    pop ax
    pop bp
    ret 4
bcdout endp
