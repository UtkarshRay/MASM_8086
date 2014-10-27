; Prints the array pointed to
; by si and of size is parameter
; Uses decprint
printarr_w proc
    push bp
    mov bp, sp
    push ax
    push cx
    push si
    
    mov cx, [bp + 4]
    cmp cx, 0
    jle cleanup_printarr_w
    cld
    printarr_w_loop:
        lodsw
        call decprint
        loop printarr_w_loop
    cleanup_printarr_w:
    pop si
    pop cx
    pop ax
    pop bp
    ret 2   ; return and remove the parameter
printarr_w endp
