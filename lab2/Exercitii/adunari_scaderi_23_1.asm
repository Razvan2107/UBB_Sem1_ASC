bits 32 


global start        


extern exit               
import exit msvcrt.dll    

;a,b,c,d - byte
;(a-c)+(b+b+d)

segment data use32 class=data
    ; ...

    a db 78h
    b db 56h
    c db 34h
    d db 12h

segment code use32 class=code
    start:
        ;a-c
        mov al, [a]
        sub al, [c]
        
        ;b+b+d
        mov ah, [b]
        add ah, [b]
        add ah, [d]
        
        ;(a-c)+(b+b+d)
        
        add al, ah
    
        ; exit(0)
        push    dword 0      
        call    [exit]       