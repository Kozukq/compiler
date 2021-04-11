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
%token ASSIGNATION
%token EGAL_A
%token DIFFERENT_DE
%token INFERIEUR_A
%token INFERIEUR_OU_EGAL_A
%token SUPERIEUR_A
%token SUPERIEUR_OU_EGAL_A
%token ADDITION
%token MULTIPLICATION
%token SOUSTRACTION
%token DIVISION
%token MODULO
%token CAS
%token PARMI
%token DEFAUT
%token FIN_CAS

/* Définitions des types */
%type<str> VAR TYPE

/* Règles de grammaire */
%%
	programme: 
		algorithme {
			printf("Le fichier source est conforme\n");
	    };

	algorithme: 
		ALGO DECLARATIONS decla DEBUT corps FIN;

	decla: 
		VAR ':' TYPE decla {
			Cellule* cell = malloc(sizeof(Cellule));
			initialiserCellule(cell, $1, $3, nbVar);
			nbVar++; 
			inserer_hachage(&table,cell);

		} |
		VAR ',' suite_var ':' TYPE decla {
			fprintf(yyout, "Declaration d'une suite de variables %s \n", $1);
			free($1);
		} |
		;

	suite_var: 
		VAR ',' suite_var | 
		VAR |
		;

	corps : 
		lecture corps | 
		ecriture corps |
		;

	lecture : 
		LIRE VAR')' {
			Cellule* cell;
			cell = rechercher_hachage(table, $2);
			if(cell != NULL){
				if(strcmp(cell->type,"entier")==0){
					fprintf(yyout, "inE;;;%d\n", cell->num);
				} 
				else {
					fprintf(yyout, "inR;;;%d\n", cell->num);
				}
			} 
			else {
				fprintf(stderr,"Erreur de lecture, %s n'a pas été définie\n", $2);
				exit(1);
			}
		};

	ecriture : 
		ECRIRE VAR')' {
			Cellule* cell;
			cell = rechercher_hachage(table, $2);
			if(cell != NULL){
				if(strcmp(cell->type,"entier")==0){
					fprintf(yyout, "outE;;;%d\n", cell->num);
				} 
				else {
					fprintf(yyout, "outR;;;%d\n", cell->num);
				}
			} 
			else {
				fprintf(stderr,"Erreur d'écriture, %s n'a pas été définie\n", $2);
				exit(1);
			}
		};

	assignation : 
		VAR ASSIGNATION VAR |
		VAR ASSIGNATION calcul |
		VAR ASSIGNATION ENTIER;

	structure_conditionnelle : 
		VAR condition VAR |
		VAR condition calcul |
		VAR condition ENTIER;

	condition : 
		EGAL_A | 
		DIFFERENT_DE | 
		INFERIEUR_A | 
		INFERIEUR_OU_EGAL_A | 
		SUPERIEUR_A | 
		SUPERIEUR_OU_EGAL_A;

	calcul :
		VAR operateur calcul |
		VAR operateur VAR |
		VAR operateur ENTIER |
		ENTIER operateur calcul |
		ENTIER operateur VAR |
		ENTIER operateur ENTIER;

	operateur :
		ADDITION |
		SOUSTRACTION |
		MULTIPLICATION |
		DIVISION |
		MODULO;
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
