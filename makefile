EXECUTABLE = compilateur

LEX_FILE = compilateur.lex
YACC_FILE = compilateur.yacc.y

LEX = flex
LEXFLAGS = 
LEXLIB =
YACC = yacc
YACCFLAGS = -d
YACCLIB = 

LIB = -lm
FLAGS = -W -Wall

$(EXECUTABLE): y.tab.o lex.yy.o liste.o cellule.o table_hachage.o quadruplet.o
	gcc -o $(EXECUTABLE) lex.yy.o y.tab.o liste.o cellule.o table_hachage.o quadruplet.o $(LEXLIB) $(YACCLIB) $(LIB)
	rm -f *.o

lex.yy.o: lex.yy.c y.tab.h
	gcc -c lex.yy.c

lex.yy.c: $(LEX_FILE)
	$(LEX) $(LEXFLAGS) $(LEX_FILE) 

y.tab.o : y.tab.h y.tab.c
	gcc -c y.tab.c

y.tab.c y.tab.h : $(YACC_FILE)
	$(YACC) $(YACCFLAGS) $(YACC_FILE)

liste.o : include/liste.c include/liste.h
	gcc -c include/liste.c

cellule.o : include/cellule.c include/cellule.h
	gcc -c include/cellule.c

table_hachage.o : include/table_hachage.c include/table_hachage.h
	gcc -c include/table_hachage.c

quadruplet.o : quadruplet.c quadruplet.h
	gcc -c quadruplet.c

clean:
	rm -f *~ \#* *.o
	rm -f $(EXECUTABLE) $(EXECUTABLE:=.exe)
	rm -f *.core *.stackdump
	rm -f lex.yy.c lex.yy.o
	rm -f y.tab.* y.output
