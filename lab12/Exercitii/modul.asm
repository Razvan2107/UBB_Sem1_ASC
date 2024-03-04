bits 32

global _compara_siruri

segment data public data use32
    s1 dd 0
    s2 dd 0
    len dd 0
    
segment code public code use32

_compara_siruri:
    push ebp
    mov ebp, esp
    
    ; la locatia [ebp+4] se afla adresa de return (valoarea din EIP la momentul apelului)
    ; la locatia [ebp] se afla valoarea ebp pentru apelant
    mov eax, [ebp + 8]         
    mov [s1],eax
    mov eax, [ebp + 12]        
    mov [s2],eax
    mov eax, [ebp + 16]        
    mov [len],eax
  
    cld
    mov esi,[s1]
    mov edi,[s2]
    mov eax,0
    mov cx,[len]
    
    repeta:     
        CMPSB
        jne mismatch
        inc eax
    loop  repeta    
      
    mismatch:   
    
    ; refacem cadrul de stiva pentru programul apelant
    mov esp, ebp
    pop ebp

    ret
