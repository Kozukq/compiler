#include "noeud.h"

void initialiser_noeud(Noeud * n, char * s){
  n -> mot = s;
  n -> pere = NULL;
  n -> filsG = NULL;
  n -> filsD = NULL;
}
void detruire_noeud(Noeud * n){
  n -> mot = NULL;
  if(n -> pere != NULL){
    free(n -> pere);
  }
  if(n -> filsG != NULL){
    free(n -> filsG);
  }
    if(n -> filsD != NULL){
    free(n -> filsD);
  }
}
