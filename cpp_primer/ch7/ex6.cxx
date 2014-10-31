#include <iostream>
using namespace std;

int fill_array(int arr[]);
void reverse_array(int arr[], int size);
void show_array(int arr[], int size);

int main(void)
{
  int arr[100];
  int size;

  size = fill_array(arr);
  if (size > 1) {
    show_array(arr, size);
    reverse_array(arr, size);
    show_array(arr, size);
  }

  return 0;
}

int fill_array(int arr[])
{
  int i = -1;
  do {
    ++i;
    cout << "Enter value: ";
  } while (cin >> arr[i] && i < 100);

  return i;
}

void show_array(int arr[], int size)
{
  cout << "Array size: " << size << endl;
  cout << "Array contents: " << endl;
  for (int i = 0; i < size; i++) cout << arr[i] << endl;
}

void reverse_array(int arr[], int size)
{
  int s, e;
  for (s = 0,  e = size - 1; s != e; s++, e--) {
    arr[s] ^= arr[e];
    arr[e] ^= arr[s];
    arr[s] ^= arr[e];
  }
}
