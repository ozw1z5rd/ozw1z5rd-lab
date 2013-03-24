#include <iostream>
#include <string>

using namespace std; 

int main() {

    string s0 ("init");
    string s1 ( s0 ); 
    string s2 ("esempio di stringa "); 

    string::iterator i; 

    for ( i = s2.begin(); i < s2.end(); i++ ) {
	cout << *i ; 
    } 
    cout << endl; 
}
