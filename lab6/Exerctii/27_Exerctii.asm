;Problema 27
;Dandu-se un sir de cuvinte, sa se calculeze cel mai lung subsir de cuvinte ordonate crescator din acest sir.

;Solutie:Facem loop in loop. In cel de-al doilea loop aflam cel mai lung subsir crescator pentru elementul aflat pe pozitia curenta din primul loop. Dupa cel de-al doilea loop vedem daca subsirul rezultat din al doilea loop este mai mare decat cel aflat anterior.
bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    s dw 1234h, 5678h, 7842h, 4312h
    len equ ($-s)/2;lungimea sirului (in words)
    sol times len dw 0
    d times len dw 0;subsirul cel mai lung cu elementele in ordine crescatoare

segment code use32 class=code
    start:
        mov ecx, len;vom parcurge elementele sirului intr-o bucla loop cu len iteratii
        mov esi, s;offset-ul sirului sursa
        mov edi, d;offset-ul sirului destinatie
        mov dx, 0
        cld;parcurgem sirul de la stanga la dreapta (DF=0)
        
        jecxz sfarsit
        
    repeta1:
        
        push ecx
        mov ecx, len
        
        lodsw
        push esi
        mov edi, d
        mov dl, 1
        stosw
        repeta2:
            mov bx, ax
            lodsw
            cmp ax, bx
            jbe peste
            stosw
            inc dl
            jmp aici
            peste:
                jmp iesire_loop2
            aici:
        loop repeta2
        
        iesire_loop2:
            cmp dh, dl
            jb actualizeaza
            jmp nu_actualiza
            actualizeaza:
                mov ecx, 0
                mov cl, dl
                mov ch, 0
                mov dh, dl
                mov esi, d
                mov edi, sol
                cld
                rep movsw
            nu_actualiza:
                pop esi
                pop ecx
    
    loop repeta1
        
        sfarsit:
        push    dword 0      
        call    [exit]       
