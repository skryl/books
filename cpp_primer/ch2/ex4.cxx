#include <iostream>
using namespace std;

int to_fahrenheit(int c);

int main() {
  int celcius;

  cout << "Please enter a Celcius value: ";
  cin >> celcius;
  cout << celcius 
       << " degrees Celcius is " 
       << to_fahrenheit(celcius) 
       << " degrees Fahrenheit";
  
  return 0;
}

int to_fahrenheit(int c) {
  return 1.8 * c + 32;
}
