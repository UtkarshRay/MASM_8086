; Reads an 18 digit integer and stores it
; as a packed BCD number in memory pointed to by bx
; uses di to access data, needs es == ds
readint proc
    push ax
    push bx
    push cx
    push di
    
    mov di, bx
    mov ax, 0
    mov cx, 5
    cld
    rep stosw
    
    xor cx, cx
    mov cl, 4
    
    mov ah, 1
    int 21h
    cmp al, 0dh
    je readint_cleanup
    
    cmp al, '-'
    jne chk_p
    mov byte ptr [bx + 9], 080h
    jmp digs
chk_p:
    cmp al, '+'
    je digs
    sub al, '0'
    push ax
    inc ch
digs:
    int 21h
    cmp al, 0dh
    je setval
    sub al, '0'
    push ax
    inc ch
    cmp ch, 18
    jl digs
setval:
    cmp ch, 0
    jle readint_cleanup
    dec ch
    pop ax
    mov byte ptr [bx], al
    cmp ch, 0
    jle readint_cleanup
    dec ch
    pop ax
    shl al, cl
    or  byte ptr [bx], al
    inc bx
    jmp setval
    
readint_cleanup:
    pop di
    pop cx
    pop bx
    pop ax
    ret
readint endp
