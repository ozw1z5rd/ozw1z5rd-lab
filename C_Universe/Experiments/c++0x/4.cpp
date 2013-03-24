#include <iostream>
#include <cstdlib>
using namespace std; 

class Demo {

    static int n; 

    public:
	Demo() {
	    Demo::n++;
	}
	~Demo() {
	    Demo::n--;
	}
	void print () {
	    cout << Demo::n << endl; 
	}
};

int Demo::n = 0; 

int main() {
    Demo *a = new Demo; 
    a->print(); 
    Demo *b = new Demo; 
    a->print();
    Demo *c = new Demo; 
    a->print(); 
    delete a; 
    b->print(); 
    delete b; 
    c->print(); 
}
