bits 32

global start

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit

%include "modul.asm"

segment data use32 class=data
    format db "Rezultatul final este: %s", 10, 13, 0
    s1 db 'q', 'w', 'e', 'r','t'    ; declararea sirului initial s1
    l1 equ $-s1                     ; stabilirea lungimea sirului initial l1
    s2 db 'q', 'w', 'e', 'b','n'    ; declararea sirului initial s2
    l2 equ $-s2                     ; stabilirea lungimea sirului initial l2
    s3 db 'q', 'w', 'e', 'r','b'    ; declararea sirului initial s3
    l3 equ $-s3                     ; stabilirea lungimea sirului initial l3
    p1 db '0'
    p2 db '0'
    p3 db '0'
    prefix dd 0
   
segment code use32 class=code

;Se dau trei siruri de caractere. Sa se afiseze cel mai lung prefix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.
start:
        mov eax, 0
        mov ecx, 0
        mov edx, 0
        
        mov cl, l1      ; punem lungimea in ECX pentru a putea realiza bucla loop de ecx ori       
        mov ESI, s1     ; incarcare offset sir_sursa in ESI
        mov EDI, s2     ; incarcare offset sir_dest in EDI
         
	    call compare
        mov  [p1],al
        
        mov cl, l1      
        mov ESI, s1     
        mov EDI, s3     
        
        call compare
        mov [p2],al
        
        mov cl, l2 
        mov ESI, s2 
        mov EDI, s3 
                
        call compare
        mov [p3],al
        
        mov bl,[p1]
        cmp bl,[p2]
        jng number2
        
        cmp bl,[p3]
        jng number3
        
        mov dl,[p1]
        jmp display
        
        number2:
        mov bl,[p2]
        cmp bl,[p3]
        jng number3
        
        number3:
        mov dl,[p3]
        
        display:
        PUSHAD
	    
        mov dl,al  
        mov esi, s1
        mov edi, prefix
        mov ecx,eax
        
        repeta2:
            movsb
        loop repeta2
        
        push dword prefix
	    push dword format       
	    call [printf]           
	    add esp, 4*2            
	
	    POPAD
	  push 0
	  call [exit]