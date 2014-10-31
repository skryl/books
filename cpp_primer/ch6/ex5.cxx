#include <iostream>
using namespace std;

int main(void)
{
  double income;
  int income_category;

  for (;;) {
    cout << "Enter your income: ";
    if (!(cin >> income)) break;

    income_category = (income > 35000 ? 2 : (income > 15000 ? 1 : (income > 5000 ? 0 : -1)));

    double tax = 0;
    switch (income_category) {
      case 2: tax += ((income - 35000) * 0.20);
              income = 35000;
      case 1: tax += ((income - 15000) * 0.15);
              income = 15000;
      case 0: tax += ((income - 5000) * 0.10);
    }

    cout << "Your tax amount: " << tax << endl;
  }
  
  return 0;
}
