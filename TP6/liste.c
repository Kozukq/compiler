#include <stdio.h>
#include <stdlib.h>
#include "liste.h"

void initialiser_liste(Liste * l){
  if(l == NULL){
    l = malloc(sizeof(Liste));
  }
  (l -> tete) = NULL;
}

void inserer(Cellule * c, Liste * l){
  if( (l -> tete) == NULL){
    // liste vide
    (l -> tete) = c;
  } else {
    // liste non vide
    c -> successeur = ( l -> tete);
    (l -> tete) -> predecesseur = c;
    (l -> tete) = c;
  }
}

void afficher_liste(Liste * l){
  if((l -> tete) != NULL){ // si la liste n'est pas vide
    printf("%s ", (l -> tete) -> valeur); // affiche la tete uniquement
    Cellule * tmp = ((l -> tete -> successeur));
    while(tmp != NULL){
      printf("%s ",(tmp -> valeur));
      tmp = tmp -> successeur;
    }
    printf("\n");
  } else {
    printf("Affichage impossible : liste vide\n");
  }
}

Cellule * rechercher(char * valeur, Liste l){

  if((l.tete) != NULL) {
    if(strcmp((l.tete) -> valeur, valeur)==0){
      return (l.tete);
    } else {
      Cellule * tmp = (l.tete)-> successeur ;
      while( tmp != NULL){
	if(strcmp(tmp -> valeur,valeur)==0){
	  return tmp;
	} else {
	  tmp = tmp -> successeur;
	}
      }
    }
  }
  return NULL;
}

void supprimer(Cellule * c, Liste * l){
  if(c -> predecesseur != NULL) {
    ((c -> predecesseur) -> successeur) = (c -> successeur);
  } else {
    (l -> tete) = (c -> successeur);
  }
  if( c -> successeur != NULL) {
    (c -> successeur) -> predecesseur = ( c -> predecesseur);
  }
}

void detruire_liste(Liste * l){
  while((l -> tete) != NULL){
    supprimer(l -> tete, l);
  }
}

int compter_liste(Liste l){
  int nb = 0;
  if((l.tete) != NULL){
    nb = nb +1;
    Cellule * tmp = ((l.tete -> successeur));
    while(tmp != NULL){
      nb = nb + 1;
      tmp = tmp -> successeur;
    }
  }
  return nb;
}
  
