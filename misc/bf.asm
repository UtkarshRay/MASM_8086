; A simple Brainfuck interpreter
; Can't handle nested loops yet
; All the procedures except bf are
; supposed to be used by bf only

write_b proc
    push ax
    push dx
    mov ah, 2
    mov dl, [bx]
    int 21h
    pop dx
    pop ax
    ret
    
write_b endp

read_b proc
    push ax
    mov ah, 1
    int 21h
    mov [bx], al
    pop ax
    ret
    
read_b endp

shift_i proc
    push ax
    mov al, ']'
    cld
    while111:
        scasb
        jz fin_sh_i
        jmp while111
    fin_sh_i:
    pop ax
    ret
    
shift_i endp

shift_i_r proc
    push ax
    mov al, '['
    std
    while111:
        scasb
        jz fin_sh_i_r
        jmp while111
    fin_sh_i_r:
    pop ax
    ret
    
shift_i_r endp

; Instruction is in di
; Array is in bx
; Size of code is in cx
bf proc
start:
    mov al, [di]
    ; Now current instruction is in al
    cmp al, '>'
    jne test_1
    inc bx
    jmp nxt
test_1:
    cmp al, '<'
    jne test_2
    dec bx
    jmp nxt
test_2:
    cmp al, '+'
    jne test_3
    inc [bx]
    jmp nxt
test_3:
    cmp al, '-'
    jne test_4
    dec [bx]
    jmp nxt
test_4:
    cmp al, '.'
    jne test_5
    call write_b
    jmp nxt
test_5:
    cmp al, ','
    jne test_6
    call read_b
    jmp nxt
test_6:
    cmp al, '['
    jne test_7
    cmp [bx], 0
    je 
    inc nst
test_7:
    cmp al, ']'
    jne test_8
    ;
nxt:
    cmp [di], '$'
    je fin
    inc di
    jmp start
fin:
    ret
    
bf endp
