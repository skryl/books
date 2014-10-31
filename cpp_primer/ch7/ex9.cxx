#include <iostream>
using namespace std;

double add(double x, double y);
double sub(double x, double y); 
double mul(double x, double y);
double div(double x, double y);

int main(void)
{
  double x, y;
  double (*funcs[4])(double, double) = {add, sub, mul, div}; 

  cout << "Enter a pair of numbers: ";
  cin >> x >> y;

  cout << "Results :" << endl;
  for (int i = 0; i < 4; i++) {
    cout << "  " << i << ": " << funcs[i](x,y) << endl;
  }
  
  return 0;
}

double add(double x, double y) 
{
  return x + y;
}

double sub(double x, double y) 
{
  return x - y;
}

double mul(double x, double y) 
{
  return x * y;
}

double div(double x, double y) 
{
  return x / y;
}
