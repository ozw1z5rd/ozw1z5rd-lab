#import "10.a.h"
#include <iostream>

class Parrot : public Animal {

    string memory; 

    public: 

	Parrot() {
	    this->memory = "";
	}

	~Parrot() {
	}

	void listen( string s ) {
	    this->memory = s; 
	}

	void talk() {
	    cout << this->memory << endl; 
	}
};


