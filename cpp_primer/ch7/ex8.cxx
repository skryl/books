#include <iostream>
using namespace std;

struct student {
  string fullname;
  string hobby;
  int ooplevel;
};

int getinfo(student pa[], int n);
void display1(student s);
void display2(const student * s);
void display3(const student students[], int class_size);

int main(void)
{
  int class_size;

  cout << "Enter class size: ";
  cin >> class_size;
  while (cin.get() != '\n')
    continue;

  student * students = new student[class_size];
  int num_students = getinfo(students, class_size);

  if (num_students > 0) {
    for (int i = 0; i < num_students; i++)
    {
      display1(students[i]);
      display2(&students[i]);
    }
    display3(students, num_students);
  }

  delete [] students;
  cout << "Done\n";
  
  return 0;
}

int getinfo(student students[], int class_size)
{
  cin.clear();
  int i;
  for (i = 0; i < class_size; i++) {
    cout << "Enter student name: ";
    cin >> students[i].fullname;
    cout << "Enter student hobby: ";
    cin >> students[i].hobby;
    cout << "Enter student level: ";
    cin >> students[i].ooplevel;
    // if (students[i].fullname == "" || students[i].hobby == "") break;
  }

  return i;
}

void display1(student s)
{
  cout << "Student Info: " << endl;
  cout << "  Name: " << s.fullname << endl;
  cout << "  Hobby: " << s.hobby << endl; ;
  cout << "  OOP Level: "<< s.ooplevel << endl; ;
}

void display2(const student * s)
{
  cout << "Student Info: " << endl;
  cout << "  Name: " << s -> fullname << endl;
  cout << "  Hobby: " << s -> hobby << endl; ;
  cout << "  OOP Level: "<< s -> ooplevel << endl; ;
}

void display3(const student students[], int n)
{
  for (int i = 0; i < n; i++) {
    display2(&students[i]);
  }
}
