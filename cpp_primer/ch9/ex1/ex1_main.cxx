#include <iostream>
#include "ex1.h"

using namespace std;

int main(void)
{
  golf golfers[NUM_GOLFERS];
  for (int i = 0; i < NUM_GOLFERS; i++) {
    setgolf(golfers[i]); 
  }
  setgolf(golfers[0], "Alex", 3); 
  showgolfers(golfers);
  return 0;
}
