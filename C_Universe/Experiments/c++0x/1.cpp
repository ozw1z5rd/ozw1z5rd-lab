#include <iostream>
using namespace std; 

class Rainbow {

    public: 
	Rainbow() {
	    cout << "Rainbow()" << endl; 
	}
	~Rainbow() {
	    cout << "Rainbow() destructor " << endl;
	}
};

void oz() {
  Rainbow rb;
  for(int i = 0; i < 3; i++)
    cout << "there's no place like home" << endl;
}
 
int main() {;
    oz();
} 
