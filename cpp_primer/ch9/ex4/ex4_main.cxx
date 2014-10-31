#include <iostream>
#include "ex4.h"

using namespace std;
using namespace SALES;

int main(void)
{
  double ar[5] = { 10, 20, 30, 40, 50 };
  Sales s1, s2;

  setSales(s1);
  showSales(s1);
  setSales(s2, ar, 3);
  showSales(s2);
  return 0;
}
