#include <cstdlib>
#include <iostream>
using namespace std;

class Demo {

    int x,y;

    public:

    Demo( int x, int y ) {
	Demo::x = x; 
	Demo::y = y;
    }
    ~Demo( ) {
	Demo::x = 0;
	Demo::y = 0;
    }
    
    void sum( int a, int b ) {
	Demo::x += a; 
	Demo::y += b;
    }

    void print() {
	cout << Demo::x << endl;
	cout << Demo::y << endl; 
    }

    private:
    
    void cannotUseThis () {
	int h = 0 ; 
    }
	
};


int main() {
    Demo d(0,3);
    d.sum(0,3);
    Demo *dp = &d;
    dp->print(); 
    dp->cannotUseThis(); 
}
