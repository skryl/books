#include <iostream>
using namespace std;

void inches_to_feet(int inches);
const int INCHES_PER_FOOT = 12;

int main() {
  int inches;

  cout << "Please enter your height in inches: ";
  cin >> inches;
  cout << "Your height in feet is: ";
  inches_to_feet(inches);
  
  return 0;
}

void inches_to_feet(int inches) {
  cout << inches / INCHES_PER_FOOT << "\'" <<  inches % INCHES_PER_FOOT << "\"\n";
}
