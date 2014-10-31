#include <iostream>
using namespace std;

struct Box {
  char maker[40];
  float height;
  float width;
  float length;
  float volume;
};

void print_box(Box box);
Box* calc_volume(Box *box);

int main(void)
{
  Box box = { "skryl" };

  cout << "Enter box dimensions: ";
  cin >> box.height >> box.width >> box.length;
  calc_volume(&box);
  print_box(box);
  
  return 0;
}

Box* calc_volume(Box *box)
{
  box -> volume = (box -> height * box -> width * box -> length);
  return box;
}

void print_box(Box box)
{
  cout << "Box Info: " << endl;
  cout << "  Maker: " << box.maker << endl; 
  cout << "  Height: " << box.height << endl; 
  cout << "  Width: " << box.width << endl;
  cout << "  Length: " << box.length << endl;
  cout << "  Volume: " << box.volume << endl;
}
