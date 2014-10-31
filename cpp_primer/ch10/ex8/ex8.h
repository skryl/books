#ifndef LIST_H_
#define LIST_H_

typedef unsigned long Item;
const int MAX = 5;

class List 
{
  private:
    Item items[MAX];
    int top;
  public:
    bool is_empty() const;
    bool is_full() const;
    bool add_item(Item value);
    void print();
    List();
};

#endif /* end of include guard: LIST_H_ */
