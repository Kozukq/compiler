#ifndef QUADRUPLET_H
#define QUADRUPLET_H

typedef struct quadruplet_t{
	char * mnemonique;
	char * arg1;
	char * arg2;
	char * arg3;
} quadruplet;

void initialiser_quadruplet(quadruplet *, char*, char*, char*, char*);
void ecrire_quadruplet(FILE*, quadruplet *);

#endif
