#include <iostream>
#include <cstring>
using namespace std;

const int SIZE = 2;

template <typename T> T max(T members[]);
char* max(char* members[]);

int main(void)
{
  float nums_f[SIZE];
  int nums_i[SIZE];
  char *strings[SIZE];
  char *temp = new char[30];
  
  for (int i = 0; i < SIZE; i++) {
    cout << "Enter an int: ";
    cin >> nums_i[i];
    cout << "Enter a float: ";
    cin >> nums_f[i];
    cout << "Type a word: ";
    cin >> temp;
    strings[i] = new char[strlen(temp)];
    strcpy(strings[i], temp);
  }

  cout << "Max int: " << max(nums_i) << endl;
  cout << "Max float: " << max(nums_f) << endl;
  cout << "Longest word: " << max(strings) << endl;

  return 0;
}

template<typename T> T max(T members[])
{
  T max = members[0];
  for (int i = 0; i < SIZE; max = (max > members[i] ? max : members[i]), i++);
  return max;
}

template <> char* max(char* members[])
{
  char * longest = members[0];
  for (int i = 0; i < SIZE; max = (strlen(longest) > strlen(members[i]) ? longest : members[i]), i++);
  return longest;
}                        
