bits 32 

global start        

extern exit
import exit msvcrt.dll

; a,b,d-byte
; [(a+b)*2]/(a+d)
segment data use32 class=data
        a db 5
        b db 6
        d db 7
        
segment code use32 class=code
    start:
        ;a+b
        mov al,[a]
        add al,[b]
        
        ;(a+b)*2
        mov ah,2
        mul ah
        
        ;a+d
        mov bl,[a]
        add bl,[d]
        
        ;[(a+b)*2]/(a+d)
        mov cx, ax
        div bl
        
        ; exit(0)
        push    dword 0
        call    [exit]
