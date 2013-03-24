#include <iostream>
using namespace std; 

class Animal {

    string name;
    int legs;

    public: 

	Animal() {
	    this->legs = 0;
	    this->name = ""; 
	}

	~Animal() {
	}

	void setLeg( int legs ) {
	    this->legs = legs; 
	}

	void setName( string name ) {
	    this->name = name; 
	}

	void dump() {
	    cout << "Name :"  << this->name << "\nlegs :" << this->legs << endl;
	}
}; 
