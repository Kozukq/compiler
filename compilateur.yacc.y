%{
#include <stdio.h>
#include <stdlib.h>
#include"y.tab.h"
extern FILE *yyin;
%}

%token ENTIER

%%

programme: expression '.' {
           printf("=%d\n", $1);
      }
      |
      ;

expression: ENTIER
      | expression '+' expression {
        $$ = $1 + $3;
      }
      | expression '-' expression {
        $$ = $1 - $3;
      };

%%

int main(int argc, char ** argv) {
	FILE * f; 
	if(argc !=3){
		fprintf(stderr,"Veuillez indiquer un nom de fichier d'entrée et de sortie");
		exit(EXIT_FAILURE);
	}
	f = fopen(argv[1], "r");
	yyin = f;	
  yyparse();
  return EXIT_SUCCESS;
}
