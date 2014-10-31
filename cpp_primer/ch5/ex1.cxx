#include <iostream>
using namespace std;

int main(void)
{
  int start, end;

  cout << "Enter start of sum: ";
  cin >> start;
  cout << "Enter end of sum: ";
  cin >> end;

  for (int i = start; i <= end; start+= i, i++);
  cout << "The sum is " <<  start << endl;

  return 0;
}
