test_tp6 : test_tp6.o liste.o cellule.o table_hachage.o noeud.o arbre.o
	gcc -o test_tp6 test_tp6.o liste.o cellule.o table_hachage.o noeud.o arbre.o -lm

test_tp6.o : test_tp6.c liste.h
	gcc -Werror -Wall -Wextra -c test_tp6.c

liste.o : liste.c liste.h cellule.h
	gcc -Werror -Wall -Wextra -c liste.c

cellule.o : cellule.c cellule.h
	gcc -Werror -Wall -Wextra -c cellule.c

table_hachage.o : table_hachage.c table_hachage.h liste.h cellule.h
	gcc -Werror -Wextra -Wall -c table_hachage.c

noeud.o : noeud.c noeud.h
	gcc -Werror -Wextra -Wall -c noeud.c

arbre.o : arbre.c arbre.h
	gcc -c arbre.c
