%{
#include "y.tab.h" 
#include "table_hachage.h"
#include <string.h>
void yyerror(const char *erreurMsg);
%}

%%

Algorithme { return ALGO;}

Déclarations {return DECLARATIONS;}

Début {return DEBUT;}

Fin {return FIN;}

entier|réel {
	char * tmp = malloc(sizeof(char) * strlen(yytext));
	strcpy(tmp,yytext);
	yylval.str = tmp;
	printf("test type : %s\n", yylval);
	return TYPE;
}

lire[(] {
	return LIRE;
}
écrire[(] {
	return ECRIRE;
}

[A-z]+ {
	char * tmp = malloc(sizeof(char) * strlen(yytext));
	strcpy(tmp,yytext);
	yylval.str = tmp;
	printf("test var : %s\n", yylval);
	return VAR;
}

[0-9]+ {
	yylval.val = atoi(yytext);
  return ENTIER;
}

[:,()=]	 { return *yytext; }

[ \t\n]
; 
	yyerror("Caractère non valide");

%%

void yyerror(const char *erreurMsg) {
  fprintf(stderr, "\n Erreur '%s' sur '%s'.\n", erreurMsg, yytext);
  exit(EXIT_FAILURE);
}
