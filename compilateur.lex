/* Options */
%option noyywrap

/* Déclarations */
%{
	#include "y.tab.h" 
	#include "include/table_hachage.h"
	#include <string.h>
	
	void yyerror(const char *erreurMsg);
%}

/* Modèles */
%%
	/* Délimiteur algorithme */
Algorithme {
	return ALGO;
}

	/* Délimiteur bloc de déclarations */
Déclarations {
	return DECLARATIONS;
}

	/* Délimiteur de début du bloc de code */
Début {
	return DEBUT;
}

	/* Délimiteur de fin du bloc de code */
Fin {
	return FIN;
}

	/* Type */
entier|réel {
	char* tmp = malloc(sizeof(char) * strlen(yytext));
	strcpy(tmp,yytext);
	yylval.str = tmp;
	printf("test type : %s\n", yylval.str);
	return TYPE;
}

	/* Fonction lire */
lire[(] {
	return LIRE;
}

	/* Fonction écrire */
écrire[(] {
	return ECRIRE;
}

	/* Cas Parmi */

Cas {
	return CAS;
}

Parmi {
	return PARMI;
}


défaut {
	return DEFAUT;
}

Fin {
	return FIN;
}

FinCas {
	return FIN_CAS;
}

	/* Texte */
[A-z]+ {
	char* tmp = malloc(sizeof(char) * strlen(yytext));
	strcpy(tmp,yytext);
	yylval.str = tmp;
	printf("test var : %s\n", yylval.str);
	return VAR;
}

	/* Nombre */
[0-9]+ {
	yylval.val = atoi(yytext);
	return ENTIER;
}

	/* Opérateur d'assignation */
:= {
	return ASSIGNATION;
}

	/* Opérateurs de calculs */
[+*-/%]	{
	switch(*yytext) {

		case '+':
			return ADDITION;
		
		case '*':
			return MULTIPLICATION;
		
		case '-':
			return SOUSTRACTION;

		case '/':
			return DIVISION;

		case '%':
			return MODULO;
	}
}

	/* Opérateurs de comparaison */
== {
	return EGAL_A;
}

!= {
	return DIFFERENT_DE;
}

[<] {
	return INFERIEUR_A;
}

(<=) {
	return INFERIEUR_OU_EGAL_A;
}

[>] {
	return SUPERIEUR_A;
}

(>=) {
	return SUPERIEUR_OU_EGAL_A;
}	

	/* Caractères à ignorer */
[ \t\n] {}

	/* Comportement par défaut */
yyerror("Caractère non valide");
%%

/* Traitement des erreurs */
void yyerror(const char *erreurMsg) {
	fprintf(stderr, "\n Erreur '%s' sur '%s'.\n", erreurMsg, yytext);
	exit(EXIT_FAILURE);
}
