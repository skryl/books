#include <iostream>
using namespace std;

int main(void)
{
  string months[12] = { "January", "February", "March", "April", 
                        "May", "June", "July", "August", "September", 
                        "October", "November", "December" };
  int sales[12] = { 0,0,0,0,0,0,0,0,0,0,0,0 };

  for (int i = 0; i < 12 ; i++) {
    cout << "Enter sales for " << months[i] << ": ";
    cin >> sales[i];
  }

  int total_sales = 0;
  for (int i = 0; i < 12 ; total_sales += sales[i], i++);
  cout << "Total Sales: " << total_sales << endl;

  return 0;
}
