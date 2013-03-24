#include <stdio.h>
#include <stdlib.h>

struct {
    int x;
    int y;
} Demo;

int main() { 

    struct Demo *d = (struct Demo *)malloc( sizeof( Demo ) ); 
    d->x = 10; 
    d->y = 11; 

    (*d).x = 10; 
    (*d).y = 11; 

    struct Demo *pd; 
    struct Demo dallocated; 
    pd = &dallocated; 

    (*pd).x = 12; 
    pd->x  = 12; 

}
