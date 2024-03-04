bits 32 

global start        

extern exit               
import exit msvcrt.dll    

; a,b,c - byte, d - word
; [(a+b)*3-c*2]+d

segment data use32 class=data
        a db 25
        b db 14
        c db 45
        d dw 285
        
segment code use32 class=code
    start:
        ; (a+b)*3
        mov al, [a]
        add al, [b]
        mov ah, 3
        mul byte al
        
        ; c*2
        mov bh, 2
        mul byte [2]
        
        ; [(a+b)*3-c*2]+d
        sub ax,bx
        add ax,d
        
        ; exit(0)
        push    dword 0      
        call    [exit]