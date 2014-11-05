; places 10^n on TOS
; cx contains n for 10^n
; bx contains addr for word containing 10
getmul proc
    push cx
    jcxz getmul_cleanup
    fld1
    getmul_1:
        fimul word ptr [bx]
        loop getmul_1
    getmul_cleanup:
    pop cx
    ret
getmul endp
