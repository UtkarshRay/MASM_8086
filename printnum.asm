; Prints real number
; tbyte bx address of number
; word  si address of number of decimal digits
printnum proc
    push ax
    push bx
    push cx
    push dx
    fld tbyte ptr [bx]
    mov cl, [bx + 9]    ; backup sign
    ; n = int(d) + fractional(r)
    ; n
    fld1
    ; n, 1
    fld st(1)
    ; n, 1, n
    fprem
    ; n, 1, r
    fld st(0)
    ; n, 1, r, r
    fchs
    ; n, 1, r, -r
    fadd st(0), st(3)
    ; n, 1, r, d
    fbstp tbyte ptr [bx]
    fwait
    ; n, 1, r
    fstp st(1)
    ; n, r
    call zerop
    cmp ax, 0
    je printnum_nonzero
    test cl, 80h
    jz printnum_nonzero
    mov ah, 2
    mov dl, '-'
    int 21h
    mov dl, '0'
    int 21h
    jmp printnum_fractional
    ; this jmp is only used to avoid useless call of printbcd
    ; since zerop tells that the integral part is zero
printnum_nonzero:
    call printbcd
printnum_fractional:
    mov cx, [si]
    jcxz printnum_cleanup
    mov ah, 2
    mov dl, '.'
    int 21h
    mov ax, bx
    lea bx, ten
    call getmul
    mov bx, ax
    ; n, r, 10^[di]
    fmulp st(1), st(0)
    ; n, r*10^[di]
    frndint
    fbstp tbyte ptr [bx]
    fwait
    ; n
    fldz    ; Done to have a discardable value at TOS
    ; n, 0
    push bx
    push cx
    call bcdout
printnum_cleanup:
    fstp st(0)
    ; n
    fstp tbyte ptr [bx]
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
printnum endp
