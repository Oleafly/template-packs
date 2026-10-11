#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char** argv) {

 	ofstream plik("strona.html");
 	if(!plik)
 		cout<<"blad zapisu pliku";
 	else
 		{
 		plik<<"<html>";
 		plik<<"<head><title>Moja pierwsza strona www</title></head>";
 		plik<<"<body>Strona WWW</body>";
 		plik<<"</html>";
		
		cout<<"Wygenerowana strona"; 	
		}
    plik.close();
    
    return 0;
}
