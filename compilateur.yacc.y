%{
#include <stdio.h>
#include <stdlib.h>
#include "table_hachage.h"
#include"y.tab.h"
extern FILE *yyin, *yyout;
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

%%

programme: algorithme{
           fprintf(yyout,"Reconnait une suite de declaration de variables %s\n", $1);
      }
      ;

algorithme: ALGO DECLARATIONS decla DEBUT corps FIN;

decla: VAR ':' TYPE decla{
		fprintf(yyout, "Declaration d'une seule variable %d \n", $2);
		$$ = 5;
		printf("test : %d", $$);
	}
	|VAR ',' suiteVar ':' TYPE decla{
		fprintf(yyout, "Declaration d'une suite de variables %d \n", $3);
	}
	|
;

suiteVar: VAR |
	VAR ',' VAR |
;
corps :
;
	

%%

int main(int argc, char ** argv) {
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
