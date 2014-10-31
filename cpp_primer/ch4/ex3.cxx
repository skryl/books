#include <iostream>
#include <cstring>
using namespace std;

void char_concat(void);
void string_concat(void);

int main(void)
{
  char_concat();
  string_concat();
}

void char_concat(void)
{
  char first_name[30];
  char last_name[30];
  char full_name[62];

  cout << "Enter your first name: ";
  cin >> first_name;
  cout << "Enter your last name: ";
  cin >> last_name;

  strcpy(full_name, last_name);
  strcat(full_name, ", ");
  strcat(full_name, first_name);

  cout << "Your name: " << full_name << endl;
}

void string_concat(void)
{
  string first_name, last_name, full_name;
  cout << "Enter your first name: ";
  cin >> first_name;
  cout << "Enter your last name: ";
  cin >> last_name;

  cout << "Your name: " << (last_name + ", " + first_name) << endl;
}

