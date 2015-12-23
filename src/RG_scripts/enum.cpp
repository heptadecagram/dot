//
// Project  Name: None
// File / Folder: enum.cpp
// File Language: cpp
// First Created: 2006.08.16 07:48:48
// Last Modified: 2006.08.16 13:00:36

#include <iostream>

#define to_string(k) NUM_ ## k

enum num {NUM_1, NUM_2, NUM_3, NUM_4};
int main() {
	num val = NUM_1;

	std::cout << "It is: " << to_string(2) << std::endl;

	return 0;
}
