#ifndef TABLE_HACHAGE_H
#define TABLE_HACHAGE_H

#include "liste.h"
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct table_hachage_struct{
  Liste ** table;
  int taille;
}Table_hachage;

void initialiser_table_hachage(Table_hachage *, int);
void detruire_table_hachage(Table_hachage *);
void afficher_table_hachage(Table_hachage);
void inserer_hachage(Table_hachage *,Cellule *);
Cellule * rechercher_hachage(Table_hachage, char *);
void supprimer_hachage(Table_hachage *,Cellule *);
int compter_table_hachage(Table_hachage);

#endif
