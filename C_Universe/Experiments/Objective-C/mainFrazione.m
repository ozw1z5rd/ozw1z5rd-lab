#import "Frazione.h"
#import <stdio.h>

int main( int argc, char *argv[] ) {

    Frazione *frazione= [Frazione alloc]; 
    [frazione init];

    [frazione setNumeratore: 1 ]; 
    [frazione setDenominatore: 2]; 
    printf("Frazione 1\n"); 
    [frazione print];

    Frazione *frazione2 = [[Frazione alloc] init ];
    [frazione2 setNumeratore : 3 ];
    [frazione2 setDenominatore : 4 ];
    printf("Frazione 2\n"); 
    [frazione2 print ];
    
    printf("Frazione 1\n"); 
    [frazione print ];

    [frazione moltiplica: frazione2 ]; 
    printf("Frazione 1 dopo moltiplicazione\n"); 
    [frazione print ];


    [frazione dividi: frazione2 ]; 
    printf("Frazione dopo divisione 1\n"); 
    [frazione print ]; 

    printf("Frazione 2 dopo moltiplicazione e divisione \n");
    [frazione2 print ]; 

    Frazione *frazione3 = [[Frazione alloc] init ];
    [frazione3 setNumeratore : 1 ];
    [frazione3 setDenominatore : 1 ];

    printf("Frazione 1\n"); 
    [frazione2 print ];
    [frazione2 somma: frazione3 ];
    printf("Frazione 1\n"); 
    [frazione2 print ]; 

    [frazione release]; 
    [frazione2 release]; 
    [frazione3 release]; 
    
}
