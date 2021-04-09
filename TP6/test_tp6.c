#include <stdio.h>
#include <stdlib.h>
#include "liste.h"
#include <time.h>
#include "table_hachage.h"
#include "arbre.h"

int traitementFichier(char * nom){
  int tmp = 0;
  int total = 0;
  Liste * ltest = malloc(sizeof(Liste));
  initialiser_liste(ltest);

  FILE * f = fopen(nom, "r");
  if( f == NULL ) {
    printf("Le fichier n'a pas pu être lu, merci de vérifier le chemin indiqué.\n");
    return -1;
  }
  char * s = malloc(sizeof(char)*40);
  tmp = fscanf(f,"%s",s);
  while(tmp >0){
    total = total + 1;
    if(rechercher(s,*ltest) == NULL){
      Cellule * c = malloc(sizeof(Cellule));
      initialiserCellule(c, s);
      inserer(c, ltest);
    }
    s = malloc(sizeof(char)*40);
    tmp = fscanf(f,"%s",s);
  }
  fclose(f);
  printf("Pour le fichier %s :\n", nom);
  printf("Nombre total de mots : %d\n",total);
  printf("Nombre de mots dans la liste : %d\n", compter_liste(*ltest));

  return 0;
}

int traitementFichierArbre(char * nom){
  int tmp = 0;
  int total = 0;
  Arbre * arbre = malloc(sizeof(Arbre));
  initialiser_arbre(arbre);

  FILE * f = fopen(nom, "r");
  if( f == NULL ) {
    printf("Le fichier n'a pas pu être lu, merci de vérifier le chemin indiqué.\n");
    return -1;
  }
  char * s = malloc(sizeof(char)*40);
  tmp = fscanf(f,"%s",s);
  while(tmp >0){
    total = total + 1;
    if(rechercher_arbre(*arbre, s) == NULL){
      Noeud * n = malloc(sizeof(Noeud));
      initialiser_noeud(n, s);
      inserer_arbre(arbre, n);
    }
    s = malloc(sizeof(char)*40);
    tmp = fscanf(f,"%s",s);
  }
  fclose(f);
  printf("Pour le fichier %s :\n", nom);
  printf("Nombre total de mots : %d\n",total);
  afficher_arbre(*arbre);
  return 0;
}

int traitementFichierTable(char * nom){
  int tmp = 0;
  int total = 0;
  Table_hachage * table = malloc(sizeof(Table_hachage));
  initialiser_table_hachage(table, 11);

  FILE * f = fopen(nom, "r");
  if( f == NULL ) {
    printf("Le fichier n'a pas pu être lu, merci de vérifier le chemin indiqué.\n");
    return -1;
  }
  char * s = malloc(sizeof(char)*40);
  tmp = fscanf(f,"%s",s);
  while(tmp >0){
    total = total + 1;
    if(rechercher_hachage(*table, s) == NULL){
      Cellule * c = malloc(sizeof(Cellule));
      initialiserCellule(c, s);
      inserer_hachage(table, c);
    }
    s = malloc(sizeof(char)*40);
    tmp = fscanf(f,"%s",s);
  }
  fclose(f);
  printf("Pour le fichier %s :\n", nom);
  printf("Nombre total de mots : %d\n",total);
  printf("Nombre de mots dans la table : %d\n", compter_table_hachage(*table));
  //afficher_table_hachage(*table);
  return 0;
}

int main(int argc, char *argv[]){

  if(argc > 2){
    printf("Utilisation de la commande : ./test_tp6 ou ./test_tp6 fichier.txt\n");
    exit(2);
  }

  char * fichier;
  if(argc == 2){
		fichier = argv[1];
  } else {
		fichier = "texte1.txt";
  }
  
  time_t begin = time(NULL);
  traitementFichier(fichier);
  time_t end = time(NULL);
  printf("Temps pour le fichier %s avec une liste: %ld s\n",fichier, (end - begin));
  begin = time(NULL);
  traitementFichierTable(fichier);
  end = time(NULL);
  printf("Temps pour le fichier %s avec une table: %ld s\n",fichier, (end - begin));

}
