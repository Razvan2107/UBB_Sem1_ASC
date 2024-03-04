bits 32 

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dd 1
    b db 2
    c db 8
    d db 4
    x dq 5

; a-doubleword; b,c,d-byte; x-qword; Interpretare fara semn
; a-(7+x)/(b*b-c/d+2)
segment code use32 class=code
    start:
        ;b*b
        mov al, [b]     ; al=b
        mul byte [b]    ; ax=al*b=b*b
        
        push ax         ; mutam ax-ul in stiva
        
        ;c/d
        mov al, [c]
        mov ah, 0       ; ax=c
        div byte [d]    ; al=c/d
        
        ;b*b-c/d+2
        mov ah,0        ; ax=c/d
        mov ebx, 0      ; ebx=0
        pop bx          ; mutam in bx ax-ul care l-am stocat in stiva
        sub bx, ax      ; bx=bx-ax=b*b-c/d
        add bx, 2       ; ebx=b*b-c/d+2
        
        ;7+x
        mov eax, [x+0]    ; eax=x
        mov edx, [x+4]    ; edx:eax=x
        add eax, 7        ; edx:eax=x+7
        
        ;(7+x)/(b*b-c/d+2)
        div ebx         ; eax=edx:eax/ebx=(7+x)/(b*b-c/d+2)
        
        ;a-(7+x)/(b*b-c/d+2)
        mov ecx, [a]
        sub ecx, eax    ;ecx=ecx-eax=a-(7+x)/(b*b-c/d+2)
        
        push    dword 0      
        call    [exit]     
