#include <iostream>

#include "config.h"
#include "bank.h"

int main() {
	std::cout << "Executing...\n";

	// The game-wide configuration
	Configuration Config;
	Bank M_Bank(Config);

	std::cout << "Done!\n";
}
