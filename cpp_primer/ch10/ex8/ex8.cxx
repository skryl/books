#include <iostream>
#include "ex8.h"

using namespace std;

List::List()
{
  top = 0;
}

bool List::is_empty() const
{
  0 == top;
}

bool List::is_full() const
{
  5 == top;
}

bool List::add_item(Item value)
{
  if (top < MAX) {
    items[top] = value;
    ++top;
  }
  else false;
}

void List::print()
{
  cout << "List Contents: " << endl;
  for (int i = 0; i < top; i++) {
    cout << "Item " << i << ": " << items[i] << endl;
  }
}
