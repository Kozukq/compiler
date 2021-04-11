/* Déclarations */
%{
	#include "quadruplet.h"
	#include "include/table_hachage.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

 	extern FILE* yyin;
	extern FILE* yyout;

	int nbVar = 0;
	int nbQua = 0;
	Table_hachage table;

	int yylex();
	void yyerror(const char* s);
%}

%union YYSTYPE {
	double reel;
    char* str;
	int entier;
	char car;
}

/* Définitions des tokens */
%token ENTIER
%token REEL

%token ALGO
%token DECLARATIONS
%token DEBUT
%token FIN

%token TYPE
%token VAR
%token ASSIGNATION
%token OPERATEUR
%token MOINS

%token EGAL_A
%token DIFFERENT_DE
%token INFERIEUR_A
%token INFERIEUR_OU_EGAL_A
%token SUPERIEUR_A
%token SUPERIEUR_OU_EGAL_A

%token LIRE
%token ECRIRE


/* Définitions des types */
%type<str> VAR TYPE
%type<entier> ENTIER calcul
%type<reel> REEL
%type<car> OPERATEUR MOINS operateur


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
			printf("Declaration d'une suite de variables \n");
		} |
		;

	suite_var: 
		VAR ',' suite_var | 
		VAR |
		;

	corps : 
		lecture corps | 
		ecriture corps |
		assignation corps |
		structure_conditionnelle corps |
		;

	assignation : 
		VAR ASSIGNATION VAR 
		{
			Cellule* cell1, *cell2;
			cell1 = rechercher_hachage(table, $1);
			cell2 = rechercher_hachage(table, $3);
			if(cell1 != NULL && cell2 != NULL){
				if(strcmp(cell1->type,"entier") == 0){
					if(strcmp(cell2->type,"entier") == 0){
						fprintf(yyout, ":=;%d;;%d\n", cell2->num, cell1->num);
						nbQua= nbQua+1;
					} 
					else {
						fprintf(stderr, "Erreur : Affectation d'une valeur réelle à l'entier %s\n", $1);
						exit(EXIT_FAILURE);
					}
				} 
				else {
					if(strcmp(cell2->type,"réel") == 0){
						fprintf(yyout, ":=;%d;;%d\n", cell2->num, cell1->num);
						nbQua= nbQua+1;
					} 
					else {
						fprintf(stderr, "Erreur : Affectation d'une valeur entière au réel %s\n", $1);
						exit(EXIT_FAILURE);
					}
				}
			}
		} |
		VAR ASSIGNATION calcul {
			Cellule* cell;
			cell = rechercher_hachage(table, $1);
			if(cell != NULL){
				if(strcmp(cell->type,"entier") == 0){
					fprintf(yyout, "consE;%d;;%d\n", $3, cell->num);
					nbQua= nbQua+1;
				} 
				else {
					fprintf(yyout, "consR;%d;;%d\n", $3, cell->num);
					nbQua= nbQua+1;
				}
			} 
			else {
				fprintf(stderr,"Erreur d'assignation, %s n'a pas été définie\n", $1);
				exit(EXIT_FAILURE);
			}
		} |
		VAR ASSIGNATION ENTIER {
			Cellule* cell;
			cell = rechercher_hachage(table, $1);
			if(cell != NULL){
				if(strcmp(cell->type,"entier") == 0){
					fprintf(yyout, "consE;%d;;%d\n", $3, cell->num);
					nbQua= nbQua+1;
				}
				else {
					fprintf(stderr, "Erreur : Affectation d'une valeur réelle à l'entier %s\n", $1);
					exit(EXIT_FAILURE);
				}
			} 
			else {
				fprintf(stderr,"Erreur d'assignation, %s n'a pas été définie\n", $1);
				exit(EXIT_FAILURE);
			}
		};

	calcul :
		ENTIER operateur ENTIER {
		switch($2) {

		case '+':
			$$ = $1 + $3;
			break;
		
		case '-':
			$$ = $1 - $3;
			break;

		case '/':
			$$ = $1 / $3;
			break;

		case '%':
			$$ = $1 % $3;
			break;
	
		case '*':
			$$ = $1 * $3;
			break;
			}
		};

	operateur : MOINS {
		$$ = '-';
	} |
		OPERATEUR {
		$$ = $1;
	};

	structure_conditionnelle : 
		VAR condition VAR {} |
		VAR condition ENTIER {};

	condition : 
		EGAL_A | 
		DIFFERENT_DE | 
		INFERIEUR_A | 
		INFERIEUR_OU_EGAL_A | 
		SUPERIEUR_A | 
		SUPERIEUR_OU_EGAL_A;

	lecture : 
		LIRE VAR')' {
			Cellule* cell;
			cell = rechercher_hachage(table, $2);
			if(cell != NULL){
				if(strcmp(cell->type,"entier") == 0){
					fprintf(yyout, "inE;;;%d\n", cell->num);
					nbQua= nbQua+1;
				} 
				else {
					fprintf(yyout, "inR;;;%d\n", cell->num);
					nbQua= nbQua+1;
				}
			} 
			else {
				fprintf(stderr,"Erreur de lecture, %s n'a pas été définie\n", $2);
				exit(EXIT_FAILURE);
			}
		};

	ecriture : 
		ECRIRE VAR')' {
			Cellule* cell;
			cell = rechercher_hachage(table, $2);
			if(cell != NULL){
				if(strcmp(cell->type,"entier") == 0){
					fprintf(yyout, "outE;;;%d\n", cell->num);
					nbQua = nbQua +1;
				} 
				else {
					fprintf(yyout, "outR;;;%d\n", cell->num);
					nbQua= nbQua+1;
				}
			} 
			else {
				fprintf(stderr,"Erreur d'écriture, %s n'a pas été définie\n", $2);
				exit(EXIT_FAILURE);
			}
		};
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
