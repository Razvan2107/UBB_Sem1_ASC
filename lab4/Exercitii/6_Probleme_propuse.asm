bits 32 

global start        

extern exit               
import exit msvcrt.dll    
;n=7
segment data use32 class=data
    a dw 8a9fh
    n db 7
    b dw 3f15h
    c dd 0      ; c=15c5_00ffh

;1000_1010_1001_1111b=8a9fh
;0011_1111_0001_0101b=3f15h
    
;Se da cuvantul A. Sa se obtina numarul intreg n reprezentat de bitii 0-2 ai lui A. Sa se obtina apoi in B cuvântul rezultat prin rotirea spre dreapta (fara carry) a lui A cu n pozitii. Sa se obtina dublucuvantul C:
;bitii 8-15 ai lui C sunt 0
;bitii 16-23 ai lui C coincid cu bitii lui 2-9 ai lui B
;bitii 24-31 ai lui C coincid cu bitii lui 7-14 ai lui A
;bitii 0-7 ai lui C sunt 1  

segment code use32 class=code
    start:
        ; vom forma dublucuvantul C in registrul ebx
        mov ebx, 0
        
        ; bitii 0-7 ai lui C sunt 1
        or ebx, 00000000000000000000000011111111b
        
        ; bitii 8-15 ai lui C sunt 0
        and ebx,11111111111111110000000011111111b
        
        ; bitii 16-23 ai lui C coincid cu bitii lui 2-9 ai lui B
        mov eax, 0
        mov ax, [b]     ; eax=b
        and eax, 00000000000000000000001111111100b   ; izolez bitii 2-9 ai lui B
        mov cl, 14
        rol eax, cl     ; deplasez bitii 2-9 in pozitia 16-23
        or ebx,eax      ; concatenez rezultatul
        
        ; bitii 24-31 ai lui C coincid cu bitii lui 7-14 ai lui A
        mov eax, 0
        mov ax, [a]     ; eax=a
        and eax, 00000000000000000111111110000000b  ; izolez bitii 7-14 ai lui A
        mov cl, 17
        rol eax, cl     ; deplasez bitii 7-14 in pozitia 24-31
        or ebx,eax      ; concatenez rezultatul
        
        ; sa se obtina apoi in B cuvântul rezultat prin rotirea spre dreapta (fara carry) a lui A cu n pozitii
        mov ax, [a]
        mov cl, [n]
        ror ax, cl
        
        push    dword 0      
        call    [exit]       