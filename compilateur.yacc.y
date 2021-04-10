%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

%union YYSTYPE
{
    char * str;
	int val;
}

%type<str> VAR TYPE

%%


programme: algorithme{
           fprintf(yyout,"Reconnait une suite de declaration de variables\n");
      }
      ;

algorithme: ALGO DECLARATIONS decla DEBUT corps FIN;

decla: VAR ':' TYPE decla{
		fprintf(yyout, "Declaration d'une seule variable : %s et son Type :  %s \n", $1, $3);
		if(strcmp($3,"réel")==0){
			fprintf(yyout, "%s est un réel \n", $1);
		} else {
			fprintf(yyout, "Imossible de reconnaitre réel dans : %s\n", $3);
		}
	}
	|VAR suiteVar ':' TYPE decla{
		fprintf(yyout, "Declaration d'une suite de variables %s \n", $1);
	}
	|
;

suiteVar: ',' VAR suiteVar |
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
