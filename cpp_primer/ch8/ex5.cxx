#include <iostream>
using namespace std;

const int SIZE = 2;

template<typename T>
T max(T nums[]);

int main(void)
{
  float nums_f[SIZE];
  int nums_i[SIZE];
  
  for (int i = 0; i < SIZE; i++) {
    cout << "Enter an int: ";
    cin >> nums_i[i];
    cout << "Enter a float: ";
    cin >> nums_f[i];
  }

  cout << "Max int: " << max(nums_i) << endl;
  cout << "Max float: " << max(nums_f) << endl;

  return 0;
}

template<typename T>
T max(T nums[])
{
  T max = nums[0];
  for (int i = 0; i < SIZE; max = (max > nums[i] ? max : nums[i]), i++);
  return max;
}
