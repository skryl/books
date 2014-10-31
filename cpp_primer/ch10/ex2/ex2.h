#ifndef PERSON_H_
#define PERSON_H_

#include <iostream>
using namespace std;

class Person {

  private:
    string last_name;
    string first_name;
  public:
    Person() { last_name = ""; first_name = ""; }
    Person(const string & ln, const string & fn = "Heyyou");
    void Show() const;
    void FormalShow() const;
};

#endif
