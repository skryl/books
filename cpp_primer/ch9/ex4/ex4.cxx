#include <iostream>
#include "ex4.h"

using namespace std; 

namespace SALES
{
  void setSales(Sales & s, const double ar[], int n)
  {
    setSalesDetails(s, ar, n);
  }

  void setSales(Sales & s)
  {
    double ar[QUARTERS];
    for (int i = 0; i < QUARTERS; i++)  {
      cout << "Enter sales for quarter " << i + 1 << ": ";
      cin >> ar[i];
    };
    setSalesDetails(s, ar, QUARTERS);
  }

  void setSalesDetails(Sales & s, const double ar[], int n)
  {
    int i;
    double min, max, total;
    for (i = 0, total = 0; i < QUARTERS; i++) {
      s.sales[i] = (i < n ? ar[i] : 0);
      total += s.sales[i];
      max = (max > s.sales[i] ? max : s.sales[i]);
      min = (min < s.sales[i] ? min : s.sales[i]);
    }
    s.average = total / i;
    s.max = max;
    s.min = min;
  }

  void showSales(const Sales & s)
  {
    cout << "Sales Info" << endl;
    for (int i = 0; i < QUARTERS; i++) {
      cout << "  Quarter " << i + 1 << ": " << s.sales[i] << endl;
    }
    cout << "  Min: " << s.min << endl;
    cout << "  Max: " << s.max << endl;
    cout << "  Ave: " << s.average << endl;
  }
}
