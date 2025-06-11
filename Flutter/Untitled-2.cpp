#include <iostream>
using namespace std;

int main() {
    double width, length;
    
    cout << "Enter the width of the rectangle: ";
    cin >> width;
    
    cout << "Enter the length of the rectangle: ";
    cin >> length;
    
    double area = width * length;
    cout << "The area of the rectangle is: " << area << endl;
    
    return 0;
}
