#import "10.a.h"
#import "10.b.h"

#include <iostream>

int main() {

    Animal *a = new Animal; 
    Parrot *p = new Parrot; 

    p->setLeg( 2 ); 
    p->setName( "parrot" );  
    p->listen( "talker" ); 
    p->dump(); 
    p->talk();

    a->setLeg( 4 ); 
    a->setName("dog"); 
    a->dump();

}
