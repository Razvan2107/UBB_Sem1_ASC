bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 1
    b dw 2
    c dd 3
    d dq 4

; a-byte, b-word, c-double word, d-qword -Interpretare cu semn
; (a+b+c)-d+(b-c)
segment code use32 class=code
    start:
        ; (a+b+c)
        mov al, [a]
        cbw             ; ax=a (conversie cu semn)
        add ax, [b]     ; ax=a+b
        cwde            ; eax=a+b (conversie cu semn)
        add eax, [c]
        
        ; (a+b+c)-d
        cdq
        sub eax, [d]     
        sbb edx, [d+4]  ; edx:eax=(a+b+c)-d
        
        push eax
        push edx
        pop ecx
        pop ebx
        
        ; b-c
        mov ax, [b]
        cwde            ; eax=b (conversie cu semn)
        sub eax, [c]    ; eax=b+c
        cdq
        
        ; (a+b+c)-d+(b-c)
        add eax, ebx
        adc edx, ecx    ; edx:eax=edx:eax+ecx:ebx
        
        push    dword 0
        call    [exit]