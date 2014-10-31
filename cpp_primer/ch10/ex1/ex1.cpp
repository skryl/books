#include <iostream>
#include "ex1.h"

using namespace std;

Account::Account()
{
  name = "Joe Shmo";
  account_number = "0000000000";
  balance = 0;
}

Account::Account(string p_name, string p_acct_num, double p_balance)
{
  name = p_name;
  account_number = p_acct_num;
  balance = p_balance;
}

bool Account::deposit(double amount)
{
  if (amount < 0) return false;
  else {
    balance += amount;
    return true;
  }
}

bool Account::withdraw(double amount)
{
  if (amount < 0 || amount > balance) return false;
  else {
    balance -= amount;
    return true;
  }
}

void Account::print_details()
{
  cout << "Account Details: " << endl;
  cout << "  Name: " << name << endl;
  cout << "  Acct: " << account_number << endl;
  cout << "  Balance: " << balance << endl;
}
