#include <iostream>
using namespace std;

double harmonic_mean(double x, double y);

int main(void)
{
  double x, y;

  do {
    cout << "Enter a pair of numbers: ";
    cin >> x >> y;
    cout << "The harmonic mean is: " << harmonic_mean(x,y) << endl;
  } while (x != 0 && y != 0);

  return 0;
}

double harmonic_mean(double x, double y) 
{
  return 2.0 * x * y / (x + y);
}
