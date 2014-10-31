#include <iostream>
#include "ex2.h"

using namespace std;

Person::Person(const string & ln, const string & fn)
{
  last_name = ln;
  first_name = fn;
}

void Person::Show() const
{
  cout << first_name << " " << last_name << endl;
}

void Person::FormalShow() const
{
  cout << last_name << " , " << first_name << endl;
}
