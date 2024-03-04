;Sa se citeasca de la tastatura un numar in baza 16 si sa se afiseze valoarea acelui numar in baza 10.
;Exemplu: Se citeste: 1D; se afiseaza: 29;

bits 32 

global start        

extern exit, printf, scanf               
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll    


segment data use32 class=data
    n dd 0
    message1 db "Numarul citit in baza 16 este n=", 0
    message2 db "Numarul afisat in baza 10 este n=", 0
    format1 db "%x", 0
    format2 db "%d", 0

segment code use32 class=code
    start:
        push dword message1
        call [printf]
        add esp, 1*4
        
        push dword n  
        push dword format1
        call [scanf]
        add esp, 2*4
        
        ; push dword [n]
        ; push dword message2
        ; call [printf]
        ; add esp, 2*4
        
        push dword message2
        call [printf]
        add esp, 1*4

        push dword [n]
        push dword format2
        call [printf]
        add esp, 2*4
        
        ; exit(0)
        push dword 0      
        call [exit]         
