; inspectbcd(addr)
; prints (in reverse) 10 bytes starting at addr in hexadecimal
inspectbcd proc
    push bp
    mov bp, sp
    push ax
    push cx
    push si
    
    mov si, [bp + 4]
    add si, 9
    mov cx, 10
    std
    inspectbcd_loop:
        lodsb
        call hexPrintB
        loop inspectbcd_loop
    pop si
    pop cx
    pop ax
    pop bp
    ret 2
inspectbcd endp
