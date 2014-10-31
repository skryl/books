#include <iostream>
#include <cstring>
using namespace std;

string & upcase(string & str);

int main(void)
{
  string str;

  for (;;) {
    cout << "Enter a string (q to quit): ";
    if (!(cin >> str) || str == "q") {
      cout << "Bye!" << endl;
      break;
    }
    cout << upcase(str) << endl;
  }

  return 0;
}

string & upcase(string & str)
{
  for (int i = 0; i < str.length(); i++) {
    str[i] = toupper(str[i]);
  }

  return str;
}
