bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    s1 db '+', '2', '2', 'b', '8', '6', 'X', '8'    ; declararea sirului initial s1
    ls1 equ ($-s1)                                  ; stabilirea lungimii sirului initial ls1
    s2 db 'a', '4', '5'                             ; declararea sirului initial s2
    ls2 equ ($-s2)                                  ; stabilirea lungimii sirului initial ls2
    d times ls1+ls2 db 0                            ; rezervarea unui spatiu de dimensiune ls1+ls2 pentru sirul destinatie d si initializarea acestuia
    
;Se dau doua siruri de caractere S1 si S2. Sa se construiasca sirul D prin concatenarea elementelor sirului S2 in ordine inversa cu elementele de pe pozitiile pare din sirul S1.
;S1: '+', '2', '2', 'b', '8', '6', 'X', '8'
;S2: 'a', '4', '5'
;D: '5', '4', 'a', '2', 'b', '6', '8'

segment code use32 class=code
    start:
        mov ecx, ls2    ; punem lungimea in ecx pentru a putea realiza bucla loop de ecx ori
        mov esi, 0
        mov edi, 0
        jecxz Sfarsit1  ; loop pentru lua sirul s2 in ordine inversa
        repeta1:
            mov al, [s2+esi]
            inc esi
            mov [d+edi], al
            inc edi
        loop repeta1
        Sfarsit1:
        
        mov ecx, ls1
        mov esi, 0
        jecxz Sfarsit2  ; loop pentru a lua elemnetele de pe pozitii pare din sirul s1
        repeta2:
            mov al,[s1+esi]
            inc esi
            inc esi
            mov [d+edi], al
            inc edi
            dec ecx
        loop repeta2
        Sfarsit2:
        
        push    dword 0      
        call    [exit]       
