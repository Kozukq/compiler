#include "table_hachage.h"

void initialiser_table_hachage(Table_hachage * table, int taille){
  table -> taille = taille;
  table -> table = malloc(sizeof(Liste)*(taille -1));
  for(int i = 0; i < taille; i = i+1){
    table -> table[i] = malloc(sizeof(Liste));
    initialiser_liste(table -> table[i]);
  }
}
void detruire_table_hachage(Table_hachage * t){
  for(int i = 0; i < t -> taille; i = i+1){
    detruire_liste(t -> table[i]);
  }
  free(t -> table);
}

void afficher_table_hachage(Table_hachage t){
  for(int i = 0; i < t.taille; i = i+1){
    printf("case %d : ",i);
    afficher_liste(t.table[i]);
  }
}

unsigned long long convertir_ch_entier(char * s){
  unsigned long long k = 0;
  int size = strlen(s);
  for(int i = size; i > 0; i = i-1){
    k = k + (s[i -1] * (int) pow(128.0,(double) size-i));
  }
  return k;
}

int hachage(unsigned long long k,int modulo){
  return k % modulo;
}

void inserer_hachage(Table_hachage * t,Cellule * c){
  unsigned long long k = convertir_ch_entier(c -> nom);
  int indice = hachage(k, t -> taille);
  inserer(c, t -> table[indice]);
  
}

Cellule * rechercher_hachage(Table_hachage t, char * s){
  unsigned long long k = convertir_ch_entier(s);
  int indice = hachage(k, t.taille);
  return rechercher(s,*t.table[indice]);
}

void supprimer_hachage(Table_hachage * t, Cellule * c){
  unsigned long long k = convertir_ch_entier(c -> nom);
  int indice = hachage(k, t->taille);
  supprimer(c,t -> table[indice]);
}

int compter_table_hachage(Table_hachage t){
  int total = 0;
  for(int i = 0; i < t.taille; i = i+1){
    total = total + compter_liste(*t.table[i]);
  }
  return total;
}
