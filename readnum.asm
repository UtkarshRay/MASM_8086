;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; IMPORTANT NOTE FOR NUMBERS USING FULL PRECISION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; When an integer of order 10^17 or 10^18 is entered
; converting it into real changes its least significant digits
; similar is the case when > 16 digits of precision are entered
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 
; Reads a real number and stores it in memory pointed to by bx
; uses di to access data, needs es == ds
; bx = address
; si = address for number of digits after decimal points
; di = address for word containing 10
readnum proc
    push bp
    mov bp, sp
    sub sp, 2
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    
    mov [bp - 2], di
    
    ; set the data at address to 0
    mov di, bx
    mov ax, 0
    mov cx, 5
    cld
    rep stosw
    mov di, bx
    
    xor cx, cx
    mov cl, 4
    xor dx, dx
    
    mov ah, 1
    int 21h
    cmp al, 0dh
    je readnum_cleanup
    
    cmp al, '-'
    jne chk_pos
    mov byte ptr [bx + 9], 080h
    jmp L100
chk_pos:
    cmp al, '+'
    je L100
    cmp al, '.'
    jne L90
    mov dh, 1
    jmp L100
L90:
    sub al, '0'
    push ax
    inc ch
L100:
    int 21h
    cmp al, '.'
    jne L110
    mov dh, 1
    jmp L100
L110:
    cmp al, 0dh
    je setvalf
    cmp dh, 1   ; to find number of digits after .
    jne L160
    inc dl
L160:
    sub al, '0'
    push ax
    inc ch
    cmp ch, 18
    jl L100
setvalf:
    cmp ch, 0
    jle divides
    dec ch
    pop ax
    mov byte ptr [bx], al
    cmp ch, 0
    jle divides
    dec ch
    pop ax
    shl al, cl
    or  byte ptr [bx], al
    inc bx
    jmp setvalf
    
divides:
    fbld tbyte ptr [di]
    fwait
    cmp dh, 1
    jne readnum_cleanup
    xor cx, cx
    mov cl, dl
    mov [si], cx
    mov bx, [bp - 2]
    call getmul
    ; Now st(1) has number and st(0) has 10^n
    fdivp st(1), st(0)
readnum_cleanup:
    fstp tbyte ptr [di]
    fwait
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    mov sp, bp
    pop bp
    ret
    
readnum endp
