#include <iostream>
using namespace std;

struct CandyBar {
  string brand;
  float weight;
  int calories;
};

void print_bar(const CandyBar & candybar);
void set_bar(CandyBar & candybar, string brand = "Snickers", float weight = 1.0, int calories = 100);

int main(void)
{
  CandyBar candybar;
  set_bar(candybar);
  print_bar(candybar);

  return 0;
}

void print_bar(const CandyBar & candybar)
{
  cout << "Candy Bar Info:" << endl;
  cout << "  Brand: " << candybar.brand << endl;
  cout << "  Weight: " << candybar.weight << endl;
  cout << "  Calories: " << candybar.calories << endl;
}

void set_bar(CandyBar & candybar, string brand, float weight, int calories)
{
  CandyBar temp_bar = { brand, weight, calories };
  candybar = temp_bar;
}
