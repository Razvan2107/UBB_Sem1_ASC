bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    s db 'Ana are un cojoc'
    len equ $-s
    max_cuv equ 50
    cuv resb max_cuv
segment code use32 class=code
    start:
        ; 1. separam cuvintele
        mov ecx, len
        cld
        mov esi,s
    urmator:
        mov ebx, 0      ; numar de litere din fiecare cuvant
        mov edi,cuv
    repeta:
        ; citesc s[i]
        lodsb       ; AL='A' AL <- <DS:ESI> si inc esi

        ; verific daca e spatiu
        cmp al,' '
        je e_spatiu
        
        ; e caracter
        stosb       ; <ES:EDI> <- AL si inc EDI
        inc ebx
        loop repeta
    e_spatiu:
        dec ecx
        ; verific ca e palindrom
        
        ; trec la urmatorul cuvant
        cmp ecx, 0
        jnz urmator
        
        push    dword 0      
        call    [exit]       
