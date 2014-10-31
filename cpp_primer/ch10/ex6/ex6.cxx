#include <iostream>
#include "ex6.h"

Move::Move(double a, double b)
{
  x = a; y = b;
}

void Move::reset(double a, double b)
{
  x = a; y = b;
}

Move Move::add(const Move & m) const
{
  return Move(x + m.x, y + m.y);
}

void Move::showmove() const
{
  std::cout <<  '(' << x << ", " << y << ')' << std::endl;
}

