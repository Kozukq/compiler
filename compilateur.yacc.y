/* Déclarations */
%{
	#include "include/table_hachage.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

 	extern FILE* yyin;
	extern FILE* yyout;

	int nbVar = 0;
	Table_hachage table;

	int yylex();
	void yyerror(const char* s);
%}

%union YYSTYPE {
    char* str;
	int val;
}

/* Définitions des tokens */
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

/* Définitions des types */
%type<str> VAR TYPE

/* Règles de grammaire */
%%
	programme: algorithme{
	           printf("Le fichier source est conforme\n");
	      }
	      ;

	algorithme: ALGO DECLARATIONS decla DEBUT corps FIN;

	decla: VAR ':' TYPE decla{
			Cellule* cell = malloc(sizeof(Cellule));
			initialiserCellule(cell, $1, $3, nbVar);
			nbVar++; 
			inserer_hachage(&table,cell);

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
		Cellule* cell;
		cell = rechercher_hachage(table, $2);
		if(cell != NULL){
			fprintf(yyout, "inE;;;%d\n", cell->num);
		} else {
			fprintf(stderr,"Erreur de lecture, %s n'a pas été définie\n", $2);
			exit(1);
		}
		
	}
	;

	Ecriture : ECRIRE VAR')'{
		Cellule* cell;
		cell = rechercher_hachage(table, $2);
		if(cell != NULL){
			fprintf(yyout, "outE;;;%d\n", cell->num);
		} else {
			fprintf(stderr,"Erreur d'écriture, %s n'a pas été définie\n", $2);
			exit(1);
		}
	}
	;
%%

/* Procédure principale */
int main(int argc, char* argv[]) {

	FILE* file_source;
	FILE* file_dest; 

	/* Vérification du nombre d'arguments */
	if(argc != 3 ){
		fprintf(stderr,"Veuillez préciser deux arguments : fichier source, fichier destination\n");
		exit(EXIT_FAILURE);
	}

	/* Initialisations */
	initialiser_table_hachage(&table,25);

	/* Traitements */
	file_source = fopen(argv[1], "r");
	yyin = file_source;

	file_dest = fopen(argv[2], "w");
	yyout = file_dest;

	yyparse();

	return EXIT_SUCCESS;
}
