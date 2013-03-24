#include <iostream>
using namespace std; 

template <class TBD, class TDB2 >
class Demo {

    TBD obj; 
    TBD2 obj2; 

    public: 
	Demo() {
	    cout << "starting a template class" << endl; 
	}

	~Demo() {
	    cout << "deleting the template class" << endl; 
	}

	void dump() {
	    cout << this->obj  << endl;	
	    cout << this->obj2 << endl; 
	}

	void set1( TBD value ) {
	    this->obj = value; 
	}
	void set2( TBD2 value ) {
	    this->obj2 = value ; 
	}
	void set1and2( TDB v1, TDB2 v2 ) {
	    this->obj  = v1; 
	    this->obj2 = v2; 

	}

}; 


int main() {
    Demo  <int><string> d; 
    d.set1( 100 ); 
    d.dump();  
    d.set2( "string" ); 
    d.dump();
}

Node<Type> *tmpNode = new Node<Type>(inputData);
