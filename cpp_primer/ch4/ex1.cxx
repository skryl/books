#include <iostream>
using namespace std;


int main(void)
{
  char first_name[30];
  char last_name[30];
  char grade[2];
  int age;

  cout << "What is your first_name? ";
  cin.getline(first_name, 30);
  cout << "What is your last_name? ";
  cin.getline(last_name, 30);
  cout << "What letter grade do you deserve? ";
  cin >> grade;
  cout << "What is your age? ";
  cin >> age;

  grade[0] += 1;
  cout << "Name: " << last_name << ", " << first_name << endl;
  cout << "Grade: " << grade << endl;
  cout << "Age: " << age << endl;

  return 0;
}
