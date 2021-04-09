#include "arbre.h"

void initialiser_arbre(Arbre * a){
  a -> racine = NULL;
}
void detruire_arbre(Arbre * a){
  Noeud * n = a -> racine;
  if(n != NULL){
    detruire_noeud(n -> filsD);
    detruire_noeud(n -> filsG);
    detruire_noeud(n);
  }
}

void copier(Noeud * n, Noeud * n2){
  if(n2 != NULL){
    if(n == NULL){
      n = malloc(sizeof(Noeud));
    }
    n -> mot = n2 -> mot;
    n -> pere = n2 -> pere;
    n -> filsG = n2 -> filsG;
    n -> filsD = n2 -> filsG;
  } else {
    n = NULL;
  }
}

void inserer_arbre(Arbre * a, Noeud * n){
  Noeud * p = NULL;
  Noeud * test = a -> racine;
  while(test != NULL){
    copier(p, test);
    if( strcmp(n -> mot, test -> mot) < 0){
      test = test -> filsG;
  } else {
    test = test -> filsD;
    }
  }
  copier(n -> pere, p);
  if(p == NULL){
    a -> racine = n;
  } else {
    if( strcmp(n -> mot, p -> mot) < 0){
      p -> filsG = n;
    } else {
      p -> filsD = n;
    }
  }
}

Noeud * rechercher_arbre(Arbre a, char * s){
  Noeud * n = a.racine;
  while(n != NULL && strcmp(n -> mot,s) != 0){
    if(strcmp(n -> mot, s) < 0){
      n = n -> filsG;
    } else {
      n = n -> filsD;
    }
  }
  return n;
}

Noeud * minimum_arbre(Noeud * n){
   if(n != NULL){
     while( n -> filsG != NULL){
       n = n -> filsG;
     }
   }
   return n;
}

void transplanter(Arbre * a, Noeud * u, Noeud * v){
  if(u -> pere == NULL){
    a -> racine = v;
  } else {
    if( u == u -> pere -> filsG){
      u -> pere -> filsG = v;
    } else {
      u -> pere -> filsD = v;
    }
  }
  if(v != NULL){
    v -> pere = u -> pere;
  }
}
   
 
void supprimer_arbre(Arbre * a, Noeud * n){
  if(n -> filsG == NULL){
    transplanter(a, n, n -> filsD);
  } else {
    if(n -> filsD == NULL){
      transplanter(a, n, n -> filsG);
    } else {
      Noeud * n2 = minimum_arbre(n -> filsD);
      if(n2 -> pere != n){
	transplanter(a, n2, n2 -> filsD);
	n2 -> filsD = n -> filsD;
	n2 -> filsD -> pere = n2;
      } else {
	transplanter(a, n, n2);
	n2 -> filsG = n -> filsG;
	n2 -> filsG -> pere = n2;
      }
    }
  }
}

void afficher_noeuds(Noeud * n){
  if(n != NULL){
    printf(" %s ", n -> mot);
    afficher_noeuds(n -> filsG);
    afficher_noeuds(n -> filsD);
  }
}

void afficher_arbre(Arbre a){

  afficher_noeuds(a.racine);
  Noeud * n =  minimum_arbre(a.racine);
  printf("\nminimum : %s\n", n -> mot);  
  
}

