#include <iostream>
#include "ex1.h"

using namespace std;

void setgolf(golf & g, const char * name, int hc)
{
  g.handicap = hc;
  strcpy(g.fullname, name);
}

int setgolf(golf & g)
{
  cout << "Enter handicap: ";
  cin >> g.handicap;
  cout << "Enter name: ";
  cin >> g.fullname;
  cin.clear();
}

void handicap(golf & g, int hc)
{
  g.handicap = hc;
}

void showgolf(const golf & g)
{
  cout << "Info: " << endl;
  cout << "  Name: " << g.fullname << endl;
  cout << "  Handicap: " << g.handicap << endl;
}

void showgolfers(const golf g[])
{
  for (int i = 0; i < NUM_GOLFERS; i++) {
    showgolf(g[i]);
  }
}
