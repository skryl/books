#include <iostream>
using namespace std;

#define STRLEN 30;
#define ENTRIES 3;

int main(void)
{

  struct Bop {
    char fullname[30];
    char title[30];
    char bopname[30];
    int preference;
  };

  Bop members[3] = {
    {"Bob Allison", "Manger", "Bbop", 0},
    {"John Crebs", "Director", "JC", 1},
    {"Ken Olsen", "CEO", "KO", 2}
  };

  char choice;
  cout << "Display preference:" << endl;
  cout << "a. by name" << endl;
  cout << "b. by title" << endl;
  cout << "c. by bopname" << endl;
  cout << "d. by preference" << endl;
  cout << "q. quit" << endl;
  cout << "enter choice: ";
  cin >> choice;

  for (int i = 0; i < 3; i++) {
    switch (choice) {
      case 'a' : cout << members[i].fullname << endl; break;
      case 'b' : cout << members[i].title << endl; break;
      case 'c' : cout << members[i].bopname << endl; break;
      case 'd' : switch (members[i].preference) {
                   case 0: cout << members[i].fullname << endl; break;
                   case 1: cout << members[i].title << endl; break;
                   case 2: cout << members[i].bopname << endl; break;
                 }
                 break;
      case 'q' : exit(0); break;
      default  : cout << "That's not a choice.\n";
    }
  }
  
  return 0;
}
