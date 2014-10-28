; Reads string till newline (excluded)
; Takes address in di
; Maximum length as parameter
; Characters read will be one less than maximum length
; Returns string length in ax
gets proc
    push bp
    mov bp, sp
    push cx
    push di
    
    cld
    dec word ptr [bp + 4]
    mov cx, [bp + 4]
    mov ah, 1
    gets_loop:
        int 21h
        cmp al, 0dh
        je cleanup_gets
        stosb
        loop gets_loop
    cleanup_gets:
    mov byte ptr [di], '$'
    mov ax, [bp + 4]
    sub ax, cx
    pop di
    pop cx
    pop bp
    ret 2
    
gets endp
