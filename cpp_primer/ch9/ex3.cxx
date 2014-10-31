#include <iostream>
using namespace std;

const int SIZE = 2;

struct chaff
{
  char dross[20];
  int slag;
};

chaff chaffs[SIZE];

void print_buffer(void);

int main(void)
{

  print_buffer();

  for (int i = 0; i < SIZE; i++) {
    chaff *c = new (chaffs + i * sizeof(chaff)) chaff;
    cout << "Address: " << c << endl;
    cout << "Enter dross: ";
    cin >> c -> dross;
    cout << "Enter slag: ";
    cin >> c -> slag;
  }

  print_buffer();
  
  return 0;
}

void print_buffer(void)
{
  for (int i = 0; i < SIZE; i++) {
    cout << "Chaff Info: " << endl;
    cout << "  Address: " << &chaffs[i] << endl;
    cout << "  Dross: " << chaffs[i].dross << endl;
    cout << "  Slag: " << chaffs[i].slag << endl;
  }
}
