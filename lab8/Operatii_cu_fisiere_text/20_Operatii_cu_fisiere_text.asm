;Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici si spatii. Sa se inlocuiasca toate literele de pe pozitii pare cu numarul pozitiei. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
bits 32 

global start        

extern exit,fopen,fclose,fprintf              
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll  

segment data use32 class=data
    s db "Ana are mere"
    len equ $-s
    nume_fisier db 'tema.txt', 0
    mod_acces db 'w', 0
    descriptor_fisier dd -1
    format db "%c", 0
    format1 db "%d", 0

segment code use32 class=code
    start:
    ;deschidere fisier
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        mov [descriptor_fisier], eax
    
    ;parcurgem sirul
        mov esi, 0      ;esi=offset s
        cld
        mov ecx, len/2
        
    ;aifsarea in fisier a rezultatului final
        jecxz Sfarsit
        repeta:
            push ecx
        
            push dword esi
            push dword format1
            push dword [descriptor_fisier]
            call [fprintf]
            add esp, 3*4
            inc esi
            
            push dword [s+esi]
            push dword format
            push dword [descriptor_fisier]
            call [fprintf]
            add esp, 3*4
            inc esi
            
            pop ecx
        loop repeta
        
    ;verificam daca len este un numar impar si afisam in fisier ultimul element
        mov ebx, 1
        test ebx, len
        jz Sfarsit
            push dword esi
            push dword format1
            push dword [descriptor_fisier]
            call [fprintf]
            add esp, 3*4
         
        Sfarsit:
           
    ;inchidere fisier
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4*1
        
        push    dword 0      
        call    [exit]       
