#include <stdio.h>
#include <stdlib.h>
#include "cellule.h"

int initialiserCellule(Cellule * c, char * valeur){
  c -> valeur = valeur;
  return 0;
}

