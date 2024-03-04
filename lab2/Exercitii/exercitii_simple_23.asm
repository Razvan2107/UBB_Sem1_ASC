bits 32      

global start

extern exit               
import exit msvcrt.dll    

;256*1

segment data use32 class=data
        
       a dw 256h
       b db 1h
       
segment code use32 class=code
    start:
        ; a,b-word
        mov ax, [a]
        mul word [b]
        
        push    dword 0      
        call    [exit]       
