#ifndef QUADRUPLET_H
#define QUADRUPLET_H

#include <stdio.h>
#include <stdlib.h>

/*Structure représentant un quadruplet*/
typedef struct quadruplet_t{
	char * mnemonique;
	char * arg1;
	char * arg2;
	char * arg3;
} quadruplet;

/*Initialise le quadruplet*/
void initialiser_quadruplet(quadruplet *, char*, char*, char*, char*);
/*Ecrit le quadruplet dans fichier spécifié en paramètre*/
void ecrire_quadruplet(FILE*, quadruplet *);

#endif
