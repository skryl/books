#include <iostream>
#include "ex1.h"

int main(void)
{
  using namespace std;

  Account a1;
  Account a2 = Account("Alex Skryl", "1111111111", 5000);

  a1.print_details();
  a2.print_details();
  cout << endl;

  a1.deposit(100);
  a1.print_details();
  a1.withdraw(200);
  a1.print_details();
  a1.deposit(200);
  a1.print_details();
  a1.withdraw(200);
  a1.print_details();
  cout << endl;

  a2.withdraw(10000);
  a2.print_details();
  a2.withdraw(200);
  a2.print_details();
  a2.deposit(1000);
  a2.print_details();
  a2.withdraw(3000);
  a2.print_details();
  cout << endl;

  return 0;
}
