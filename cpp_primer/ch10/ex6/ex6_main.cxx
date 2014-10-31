#include <iostream>
#include "ex6.h"

using namespace std;

int main(void)
{
  Move m1;
  Move m2 = Move(10,10);
  Move m3 = Move(20,20);

  m1.showmove();
  m2.showmove();
  m3.showmove();

  Move m4 = m2.add(m3);
  m4.showmove();
  m3.reset();
  m3.showmove();
  
  return 0;
}
