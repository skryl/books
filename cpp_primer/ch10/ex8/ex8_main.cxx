#include <iostream>
#include "ex8.h"

using namespace std;

int main(void)
{
  std::cout.setf(std::ios::boolalpha);
  List l;

  cout << "Empty: " << l.is_empty() << endl;
  cout << "Full: " << l.is_full() << endl;
  l.add_item(10);
  l.add_item(15);
  cout << "Empty: " << l.is_empty() << endl;
  cout << "Full: " << l.is_full() << endl;
  l.add_item(20);
  l.add_item(25);
  l.add_item(30);
  cout << "Empty: " << l.is_empty() << endl;
  cout << "Full: " << l.is_full() << endl;
  l.print();
  
  return 0;
}
