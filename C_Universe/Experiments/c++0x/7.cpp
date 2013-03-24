#include <iostream>
#include <cstdlib>
#include <cstring>

using namespace std;

class Animal {

    int legs; 
    char _name[10]; 

    public:

    Animal () {
    }

    ~Animal() {
    }

    int say() {
	cout << _name << endl; 
    }

    int walk() {
	cout << legs << endl; 
    }

    int name( char *name ) {
	strcpy( this->_name, name ); 
    }

};


class Parrot : public Animal {

    char memory[10];

    public: 

    Parrot() {
	strcpy(this->memory, "");
    }

    int replay() {
	cout << memory << endl;
    }

    int learn( char *string) {
	strcpy( this->memory, string ); 
    }
};



int main() {

    Animal *animal = new Animal; 
    Parrot *parrot = new Parrot; 

    animal->name((char *)"wolf"); 
    parrot->name((char *)"crunk");

    animal->say(); 
    parrot->say(); 

    parrot->learn((char *)"puppa");
    parrot->replay(); 
}

