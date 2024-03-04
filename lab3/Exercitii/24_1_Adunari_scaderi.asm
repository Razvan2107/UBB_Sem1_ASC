bits 32 
global start 
extern exit              
import exit msvcrt.dll

; a-byte; b-word; c-double word; d-qword; Interpretare fara semn
; ((a+b)+(a+c)+(b+c))-d
segment data use32 class=data
    a db 1
    b dw 2
    c dd 3
    d dq 4
segment code use32 class=code
    start:
        ; a+b
        mov eax, 0      ; eax=0
        mov al, [a]     ; eax=a (conversie fara semn)
        add ax, [b]     ; eax=a+b
        
        ; a+c
        mov ebx, 0
        mov bl, [a]     ; ebx=b (conversie fara semn)
        add ebx, [c]    ; ebx=b+c
        
        ; (a+b)+(a+c)
        add eax, ebx    ; eax=eax+ebx
        adc edx, 0
        
        ; b+c
        mov ebx, 0      ; ebx=0
        mov bx, [b]
        add ebx, [c]    ; ebx=b+c
        
        ; (a+b)+(a+c)+(b+c)
        add eax, ebx    ; eax=eax+ebx
        adc edx, 0      
        
        ; ((a+b)+(a+c)+(b+c))-d
        sub eax, [d]
        sbb edx, [d+4]
        
        push    dword 0
        call    [exit]
