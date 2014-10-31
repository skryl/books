#ifndef ACCOUNT_H_
#define ACCOUNT_H_

#include <iostream>

class Account 
{
  private:
    std::string name;
    std::string account_number;
    double balance;
  public:
    Account();
    Account(std::string p_name, std::string p_acct_num, double p_balance = 0);
    bool deposit(double amount);
    bool withdraw(double amount);
    void print_details();
};

#endif
