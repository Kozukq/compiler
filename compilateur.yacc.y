%{
#include <stdio.h>
#include <stdlib.h>
#include"y.tab.h"
extern FILE *yyin, *yyout;
%}

%token ENTIER
%token ALGO


%%

programme: algorithme{
           fprintf(yyout,"Ok\n");
      }
      ;

algorithme: ALGO{
        $$;
      };

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
