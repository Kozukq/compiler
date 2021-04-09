#ifndef LISTE_H
#define LISTE_H

#include <stdio.h>
#include <string.h>
#include "cellule.h"

typedef struct{
  Cellule * tete;
}Liste;

void initialiser_liste(Liste *);
void detruire_liste(Liste *);
void inserer(Cellule *, Liste *);
void afficher_liste(Liste *);
Cellule * rechercher(char *, Liste);
void supprimer(Cellule *, Liste *);
int compter_liste(Liste);

#endif
