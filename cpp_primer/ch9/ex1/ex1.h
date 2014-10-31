const int LEN = 40;
const int NUM_GOLFERS = 3;

struct golf
{
  char fullname[LEN];
  int handicap;
};

void setgolf(golf & g, const char * name, int hc);
int setgolf(golf & g);
void handicap(golf & g, int hc);
void showgolf(const golf & g);
void showgolfers(const golf g[]);
