#include "velocidadeIdeal.h"
#include<stdio.h>
#include <stdlib.h>

int main() {
   printf("Insira a distancia ate o local que deseja ir, em KM: \n");   

   int x,y;
   scanf("%d", &x);
   printf("Insira o tempo que tem disponivel para viagem, em Minutos: \n");   
   scanf("%d", &y);  
 
  return velocidadeIdeal(x,y);
}
