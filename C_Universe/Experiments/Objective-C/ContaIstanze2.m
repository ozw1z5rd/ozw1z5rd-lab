#import <stdio.h>
#import <Foundation/NSObject.h>

// queste dovrebbero essere della classe e non delle istanze
// con static sono inizializzate una sola volta. 
static int n;
static int m;

@interface CI : NSObject {
}

-(void) sing;
-(void) init;
-(void) sayHowMany;

@end


@implementation CI

-(void) sing {
     printf("Sing song\n"); 
}

-(void) init {
    n++;
    printf("Inizializzazione dell'oggetto\n");
    [ super init ];
}

-(void) sayHowMany {
    printf("%d\n", n); 
}


@end


int main( int argn, char *argv[] ) {
    CI *ci = [[CI alloc] init ]; 
    [ci sayHowMany ]; 
    CI *ci1 = [[CI alloc] init ]; 
    [ci sayHowMany ]; 
    CI *ci2 = [[CI alloc] init ]; 
    [ci sayHowMany ]; 
    [ci sing ]; 
    [ci2 release ]; 
    [ci1 release ]; 
    [ci release ]; 
}
