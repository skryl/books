#include <iostream>
#include <cctype>

using namespace std;

int main(void)
{
  double donations[10];
  bool numeric;

  int i;
  for (i = 0; i < 10; i++) {
    cout << "Enter donation amount: ";
    if (!(cin >> donations[i])) break;
  } 

  int sum = 0;
  for (int n = 0; n < i; sum += donations[n], n++);
  cout << "Average donation: " << sum/i << endl;

  return 0;
}
