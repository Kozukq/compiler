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
int yylex();
void yyerror(const char* s);
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
           printf("Le fichier source est conforme\n");
      }
      ;

algorithme: ALGO DECLARATIONS decla DEBUT corps FIN;

decla: VAR ':' TYPE decla{
		Cellule *c = malloc(sizeof(Cellule));
		initialiserCellule(c, $1, $3, nbVar);
		nbVar++; 
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
	Cellule * c;
	c = rechercher_hachage(t, $2);
	if(c != NULL){
		fprintf(yyout, "inE;;;%d\n", c->num);
	} else {
		fprintf(stderr,"Erreur de lecture, %s n'a pas été définie\n", $2);
		exit(1);
	}
	
}
;
Ecriture : ECRIRE VAR')'{
	Cellule * c;
	c = rechercher_hachage(t, $2);
	if(c != NULL){
		fprintf(yyout, "outE;;;%d\n", c->num);
	} else {
		fprintf(stderr,"Erreur d'écriture, %s n'a pas été définie\n", $2);
		exit(1);
	}
}
;

	

%%

int main(int argc, char ** argv) {
	initialiser_table_hachage(&t,25);
	FILE * fsrc, * fdest; 
	if(argc !=3){
		fprintf(stderr,"Veuillez indiquer un nom de fichier d'entrée et de sortie\n");
		exit(EXIT_FAILURE);
	}
	fsrc = fopen(argv[1], "r");
	yyin = fsrc;
	fdest = fopen(argv[2], "w");
	yyout = fdest;
	
  yyparse();
  return EXIT_SUCCESS;
}
