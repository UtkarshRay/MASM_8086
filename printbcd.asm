; prints compact BCD number in memory pointed to by bx
printbcd proc
    push ax
    push cx
    push dx
    push si
    
    mov si, bx
    mov cl, 4
    mov ah, 2
    add bx, 9
    cmp byte ptr [bx], 080h
    jne skipz
    mov dl, '-'
    int 21h
skipz:
    dec bx
    cmp byte ptr [bx], 0
    je skipz
    
    mov dl, [bx]
    test dl, 0f0h
    jnz printdigs
    and dl, 0fh
    add dl, '0'
    int 21h
    dec bx
printdigs:
    mov dl, [bx]
    shr dl, cl
    add dl, '0'
    int 21h
    mov dl, [bx]
    and dl, 0fh
    add dl, '0'
    int 21h
    dec bx
    cmp bx, si
    jge printdigs
    
printbcd_cleanup:
    mov bx, si
    pop si
    pop dx
    pop cx
    pop ax
    ret
    
printbcd endp
