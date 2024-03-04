//Se dau trei siruri de caractere. Sa se afiseze cel mai lung prefix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.

#include <stdio.h>

//int compSir(char sir1[], char sir2[]);
int compara_siruri(char s1[],char s2[],int l);

int main()
{
    // declaram variabilele
    int cmp1=0,cmp2=0,i;

    char str1[]="1234569";
    char str2[]="1234567";
    char str3[]="1234568";
    char str4[]="";

    // apelam functia scrisa in limbaj de asamblare
    
    cmp1=compara_siruri(str1, str2,strlen(str1));
    cmp2=compara_siruri(str1, str3,strlen(str1)); 
    if (cmp1<cmp2)
        { 
            cmp1=cmp2;
        }  
    
    cmp2=compara_siruri(str2,str3,strlen(str2));
    if (cmp1<cmp2) 
        {
            cmp1=cmp2;
        }
    
    // afisam valoarea calculata de functie
    
    strcpy(str4,str1);
    
    printf(str4);
    return 0;
}