#include <iostream>
#include <cstdlib>

using namespace std; 

struct Demo { 
    
    Demo() {
    }; 

    ~Demo() {
    };

    int test() {
	cout << "test" << endl; 
    }

}; 

main() {

    Demo *b = new Demo; 
    b->test();
    delete b; 

}
    
