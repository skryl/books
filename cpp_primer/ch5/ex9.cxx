#include <iostream>
using namespace std;

int main(void)
{
  int num_rows = 0;

  cout << "Enter number of rows: ";
  cin >> num_rows;

  int r, c;
  for (r = 1; r <= num_rows; r++) {
    for (c = 1; c <= num_rows; c++) {
      c <= (num_rows - r) ? cout << "." : cout << "*";
    }
    cout << endl;
  }

  return 0;
}
