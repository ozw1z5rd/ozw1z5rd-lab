#include <stdio.h>
#include <stdlib.h>

int main( int n, char * argv[] ) {

    FILE *file;
    file = fopen("/tmp/passwords","a");
    fprintf( file, "Questo è un testo di prova \n");
    fclose(file);
}

