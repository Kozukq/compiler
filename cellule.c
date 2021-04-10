#include <stdio.h>
#include <stdlib.h>
#include "cellule.h"

int initialiserCellule(Cellule * c, char * nom, char * type, int num){
  c -> nom = nom;
	c-> type = type;
	c-> num = num;
  return 0;
}

