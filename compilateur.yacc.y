%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "table_hachage.h"
#include "cellule.h"
#include "liste.h"
extern FILE *yyin, *yyout;
int nbVar = 0;
Table_hachage t;
%}

%token ENTIER
%token ALGO
%token DECLARATIONS
%token DEBUT
%token TYPE
%token FIN
%token VAR
%token FUNCTION
%token PROCEDURE
%token LIRE
%token ECRIRE

%union YYSTYPE
{
    char * str;
	int val;
}

%type<str> VAR TYPE

%%

/*void inserer_hachage(Table_hachage *,Cellule *);
Cellule * rechercher_hachage(Table_hachage, char *);*/

programme: algorithme{
           fprintf(yyout,"Reconnait une suite de declaration de variables\n");
      }
      ;

algorithme: ALGO DECLARATIONS decla DEBUT corps FIN;

decla: VAR ':' TYPE decla{
		Cellule *c = malloc(sizeof(Cellule));
		initialiserCellule(c, $1, $3, nbVar);
		nbVar++; 
		printf("Declaration d'une seule variable : %s et son Type :  %s \n", $1, $3);
		inserer_hachage(&t,c);

	}
	|VAR ',' suiteVar ':' TYPE decla{
		fprintf(yyout, "Declaration d'une suite de variables %s \n", $1);
		free($1);
	}
	|
;

suiteVar: VAR ',' suiteVar | VAR |
;
corps : Lecture corps | Ecriture corps |
;

Lecture : LIRE VAR')' {
	fprintf(yyout, "Lecture de :  %s \n", $2);
	fprintf(yyout, "inE;;;%d\n", nbVar);
	Cellule * c;
	c = rechercher_hachage(t, $2);
	if(c != NULL){
		printf("Lecture de :  %s \n", $2);
		fprintf(yyout, "inE;;;%d\n", c->num);
	} else {
		printf("Erreur de lecture, %s n'a pas été définie\n", $2);
		exit(1);
	}
	
}
;
Ecriture : ECRIRE VAR')'{
	fprintf(yyout, "Ecriture de :  %s \n", $2);
	fprintf(yyout, "outE;;;%d\n", nbVar);
	
}
;

	

%%

int main(int argc, char ** argv) {
	initialiser_table_hachage(&t,25);
	FILE * fsrc, * fdest; 
	if(argc !=3){
		fprintf(stderr,"Veuillez indiquer un nom de fichier d'entrée et de sortie");
		exit(EXIT_FAILURE);
	}
	fsrc = fopen(argv[1], "r");
	yyin = fsrc;
	fdest = fopen(argv[2], "w");
	yyout = fdest;
	
  yyparse();
  return EXIT_SUCCESS;
}
