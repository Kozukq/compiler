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
	yylval.entier = atoi(yytext);
	return ENTIER;
}

	/*Réel*/
[0-9]+[.,][0-9]+ {
	yylval.entier = strtod(yytext,NULL);
	return REEL;
}

	/* Opérateur d'assignation */
:= {
	return ASSIGNATION;
}

	/* Opérateur unaire */
[-]	{
	yylval.car = yytext[0];
	return MOINS;
}

	/* Opérateurs de calculs */
[+*-/%]	{
	yylval.car = yytext[0];
	return OPERATEUR;
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

	/* Caractères génériques */
[:)=*-+%] {
	return *yytext;
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
