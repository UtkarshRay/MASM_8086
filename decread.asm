; Decimal reader
; Returns the integer in ax

decRead proc
    push bx
    push cx
    push dx
    push si
preread:
    xor si, si  ; Clear si and bx
    xor bx, bx  ; Storing the integer in bx
    mov cx, 10  ; Using cx to multiply
    mov ah, 1   ; Read a character
    int 21h
    cmp al, 0dh ; Quit if CR
    je fin
    cmp al, '+' ; If '+' then read another character
    je read
    cmp al, '-'
    jne check   ; If al is not '-' then check
    mov si, 1   ; If al is '-' then set cx to 1
    
read:
    mov ah, 1
    int 21h
check:
    cmp al, '0'
    jl non_dig
    cmp al, '9'
    jg non_dig
    sub al, '0' ; Convert al from ASCII to value
    xchg ax, bx ; Put current value in ax and use bx to store al
    mov bh, 0   ; Clear bh
    mul cx      ; Multiply current value by 10
    add bx, ax  ; Add the new value to bx
    jmp read
    
non_dig:
    jmp fin
    
fin:
    mov ax, bx  ; Move result to ax
    cmp cx, 1
    jne cleanup
    neg ax      ; If it is negative negate it
cleanup:
    pop si
    pop dx
    pop cx
    pop bx
    ret

decRead endp
