#ifndef ARBRE_H
#define ARBRE_H

#include "noeud.h"
#include <stdio.h>
#include <string.h>

typedef struct Arbre_t{
  Noeud * racine;
}Arbre;

void initialiser_arbre(Arbre *);
void detruire_arbre(Arbre *);
void inserer_arbre(Arbre *, Noeud *);
Noeud * rechercher_arbre(Arbre, char *);
void supprimer_arbre(Arbre *, Noeud *);
void afficher_arbre(Arbre);
Noeud * minimum_arbre(Noeud *);

#endif
