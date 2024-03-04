bits 32 

global start        

extern exit               
import exit msvcrt.dll    

; a,b,c,d-word
; (a+b+c)-(d+d)

segment data use32 class=data
        a dw 400
        b dw 350
        c dw 280
        d dw 260
    
segment code use32 class=code
    start:
        ; a+b+c
        mov ax,[a]
        add ax,[b]
        add ax,[c]
        
        ; d+d
        mov bx,[d]
        add bx,[d]
        
        ; (a+b+c)-(d+d)
        sub ax,bx
        
        ; exit(0)
        push    dword 0      
        call    [exit]