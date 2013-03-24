#include <stdio.h>
#include <stdlib.h>

struct stru_demo {
    int x; 
    int y; 
};

struct stru_demo point; 
struct stru_demo point2;
typedef struct stru_demo2 { int x; int y; } point_t; 
point_t point3;
point_t *p_point; 
int a  = 0; 
int *pa;


main() {
    point3.x = point3.y = 0 ; 
    p_point = &point3; 
    printf("%d \n", point3.x ); 
    (*p_point).x = 11; 
    printf("%d \n", point3.x ); 
    p_point->x = 13; 
    printf("%d \n", point3.x ); 


    pa = &a; 
    *pa = 5: 

    printf("%d \n", a );
}
