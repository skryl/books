#include <iostream>
using namespace std;

long int factorial(int val);

int main(void)
{
  int val;

  cout << "Enter an integer: ";
  cin >> val;
  cout << "Factorial of " << val << " is " << factorial(val) << endl;
  
  return 0;
}

long int factorial(int val)
{
  if (1 == val)
    return 1;
  else
    return val * factorial(val - 1);
}
