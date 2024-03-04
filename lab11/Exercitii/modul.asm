%ifndef _MODUL_ASM_       
%define _MODUL_ASM_       

compare: 
      cld                   
      mov ax,0
      repeta:     
           CMPSB
           jne  nu_e_egal
           inc ax
      loop  repeta    
      nu_e_egal:   
    ret

%endif      