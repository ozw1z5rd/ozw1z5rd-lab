#include <iostream>
using namespace std; 

template <class TBD>
class Demo {

    TBD obj; 

    public: 
	Demo() {
	    cout << "starting a template class" << endl; 
	}

	~Demo() {
	    cout << "deleting the template class" << endl; 
	}

	void dump() {
	    cout << this->obj  << endl;	
	}

	void set( TBD value ) {
	    this->obj = value; 
	}

}; 


int main() {
    Demo  <int> d; 
    d.set( 100 ); 
    d.dump();  

    Demo <float> f;
    f.set( 3.141592753 ); 
    f.dump();

    Demo <string> s; 
    s.set("test"); 
    s.dump(); 
}


