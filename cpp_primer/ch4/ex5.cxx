#include <iostream>
using namespace std;

struct CandyBar {
  string name;
  float weight;
  int calories;
};

int main(void)
{
  CandyBar snack = {"Snickers", 3.3, 100};
  CandyBar *snack2;

  cout << snack.name << endl;
  cout << snack.weight << endl;
  cout << snack.calories << endl;

  snack2 = new CandyBar;
  snack2 -> name = "Mars"; 
  snack2 -> weight = 2.2;
  snack2 -> calories = 200;

  cout << snack2 -> name << endl;
  cout << snack2 -> weight << endl;
  cout << snack2 -> calories << endl;

  return 0;
}
