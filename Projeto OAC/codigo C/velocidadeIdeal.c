#include<stdio.h>
#include<stdlib.h>

int distancia;
int tempo;
int distanciaMetros;
int tempoSegundos;
int velocidade;

int velocidadeIdeal(int distancia, int tempo) {

	distanciaMetros = distancia * 1000;
	tempoSegundos = tempo * 60;
	velocidade = (distanciaMetros/tempoSegundos);

	printf("Velocidade necessaria: Aproximadamente %d m/s\n", velocidade);
	
	if (velocidade > 31) {
	
		printf("Cuidado isso eh muito rapido!\n");
	}
	
	return velocidade;
}
