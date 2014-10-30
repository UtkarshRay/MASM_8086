; Inserts integer in array such that array remains in ascending order
; Takes address of array in si
; Takes size of array in cx
; Takes integer in ax
insert proc
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push si
    
    cmp cx, 0
    jg do_proper
    mov [si], ax
    jmp cleanup_insert
    
do_proper:
    mov bx, cx
    dec bx
    shl bx, 1
    add si, bx
    
    while_insert:
        cmp ax, [si]
        jge insert_here
        push [si]
        pop  [si+2]
        sub si, 2
        loop while_insert
    
    insert_here:
        mov [si+2], ax
    
cleanup_insert:
    pop si
    pop cx
    pop bx
    pop ax
    
    mov sp, bp
    pop bp
    ret
    
insert endp
