#include <iostream>
#include <cstring>
using namespace std;

struct Stringy {
  char * str;
  int ct;
};

void set(Stringy & stringy, char temp[]);
void show(Stringy & stringy, int count = 1);
template <typename T>
void show(T str, int count = 1);

int main(void)
{

  Stringy beany;
  char testing[] = "Reality isn't what it used to be.";

  set(beany, testing);
  show(beany);
  show(beany, 2);
  testing[0] = 'D';
  testing[1] = 'u';
  show(testing);
  show(testing, 3);
  show("Done!");
  
  return 0;
}

void set(Stringy & stringy, char temp[])
{
  int length = strlen(temp);
  stringy.ct = length;
  stringy.str = new char[length];
  strcpy(stringy.str, temp);
}

void show(Stringy & stringy, int count)
{
  for (int i = 0; i < count; i++) {
    cout << stringy.str << endl;
  }
}

template <typename T>
void show(T str, int count)
{
  for (int i = 0; i < count; i++) {
    cout << str << endl;
  }
}
