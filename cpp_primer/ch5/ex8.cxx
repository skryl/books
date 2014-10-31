#include <iostream>
using namespace std;

int main(void)
{
  string words[100];
  int i = 0;
  
  do {
    cout << "Enter word: ";
    cin >> words[i];
    i++;
  } while (i < 100 && words[i-1] != "done");

  cout << "Number of words entered: " << i << endl;

  return 0;
}
