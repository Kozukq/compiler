#ifndef NOEUD_H
#define NOEUD_H

#include <stdlib.h>

typedef struct Noeud_t{
  char * mot;
  struct Noeud_t * pere;
  struct Noeud_t * filsG;
  struct Noeud_t * filsD;
}Noeud;

void initialiser_noeud(Noeud *, char *);
void detruire_noeud(Noeud *);

#endif
