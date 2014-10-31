#include <iostream>
#include <fstream>
using namespace std;

int main(void)
{
  ifstream inFile;
  inFile.open("/Users/rut216/Desktop/test.txt");

  int char_count = 0;
  char value;
  if (inFile.is_open()) {
    while(inFile.good()) {
      inFile >> value;
      char_count++;
    }
  } 
  else {
    cout << "Could not open file!" << endl;
    exit(EXIT_FAILURE);
  }

  cout << "File length: " << char_count << " characters" << endl;
  
  return 0;
}
