#ifndef MOVE_H_
#define MOVE_H_

class Move
{
private:
  double x;
  double y;
public:
  Move(double a = 0, double b = 0);
  void showmove() const;
  void reset(double a = 0, double b = 0);
  Move add(const Move & m) const;
};

#endif
