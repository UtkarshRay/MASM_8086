; Decimal printer
; Takes argument in ax
; Only prints the integer, restores ax

decPrint proc
    push ax
    push bx
    push cx
    push dx
    ; To store number of digits to print (from stack)
    mov cx, 0
    xor dx, dx
    test ax, ax
    jns digits      ; if it is positive then get digits
    
    ; Output a '-' and negate the number (works for -32768)
sign:
    mov bx, ax      ; Backup ax
    mov ah, 2       ; Output a '-'
    mov dl, '-'
    int 21h
    neg bx          ; Negate bx and restore it ax
    mov ax, bx
    xor dx, dx      ; Clear dx again
    
    ; dx:ax, ah:al
    ; dx contains remainder, ax contains quotient
digits:
    mov bx, 10
while10:
    div bx          ; get remainder:quotient
    add dx, '0'     ; convert to ASCII
    push dx         ; push remainder on stack
    xor dx, dx      ; clear dx
    inc cx
    test ax, ax     ; test on ax
    jz pop_digs     ; if number is zero print digits
    jmp while10
    
pop_digs:
    mov ah, 2
again:              ; Print digits here
    pop dx
    int 21h
    loop again
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
decPrint endp
