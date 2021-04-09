#ifndef CELLULE_H
#define CELLULE_H

#include <stdio.h>

typedef struct Cellule_t{
  char * valeur;
  struct Cellule_t * predecesseur;
  struct Cellule_t * successeur;
}Cellule;

int initialiserCellule(Cellule *, char *);

#endif


