#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "quadruplet.h"

void initialiser_quadruplet(quadruplet * q, char* mnemonique, char* arg1, char* arg2, char* arg3){
	q->mnemonique = mnemonique;
	strcpy(q->mnemonique, mnemonique);
	strcpy(q->arg3, arg3);
	if(arg1 != NULL){
		strcpy(q->arg1, arg1);
	}
	if(arg2 != NULL){
		strcpy(q->arg2, arg2);
	}
	
}

void ecrire_quadruplet(FILE* out, quadruplet * q){
	if(q-> arg1 == NULL){
		if(q -> arg2 == NULL){
			fprintf(out, "%s;;;%d\n", q->mnemonique,atoi(q->arg3));	
		} else {
			fprintf(out, "%s;;%d;%d\n", q->mnemonique,atoi(q->arg2),atoi(q->arg3));	
		}
	} else {
		if(q -> arg2 == NULL){
			fprintf(out, "%s;%d;;%d\n", q->mnemonique,atoi(q->arg1),atoi(q->arg3));	
		} else {
			fprintf(out, "%s;%d;%d;%d\n", q->mnemonique,atoi(q->arg1),atoi(q->arg2),atoi(q->arg3));	
		}
	}
}
