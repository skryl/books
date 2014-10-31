#include <iostream>
using namespace std;

#define YARDS_IN_FURLONG 220;

int main() {
  int distance;

  cout << "Please enter distance in furlongs: ";
  cin >> distance;
  cout << "Converted to yards: " << distance * YARDS_IN_FURLONG 
  cout << endl;

  return 0;
}
