#include <iostream>
#include <cstdlib>
using namespace std; 

class Demo {

    int a; //private by default

    public:
    Demo() {
    }; 

    ~Demo() {
    }; 

    void set( int a ) {
	this->a = a; 
    }

    int get() {
	return this->a; 
    }

}; 


int main() {
    Demo *d = new Demo; 
    d->set(10); 
    cout << d->get() << endl; 
    delete d; 
}
