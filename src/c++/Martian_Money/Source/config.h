// File: config.h
// Author: Liam Bryan
// Language: C++
// First Created: 2002.07.17
// Last Modified: 2002.07.29

#ifndef LIAM_CONFIG
# define LIAM_CONFIG

# define DEFAULT_CONFIG "host.config"

# include <iostream>
# include <fstream>
# include <string>
# include <vector>
using namespace std ;

enum Config_Variable { Money_Type, Money_Adjective, Object_Base_Type, 
		Object_Type, Object_Adjective, Money_Start } ;

class Configuration {
public:
	// Constructors
	Configuration(char* Config=DEFAULT_CONFIG) ;

	// Destructor
	~Configuration(void) ;

	// Facilitators

	// Inspectors
	int Get_Variable_Count(Config_Variable Variable) const ;
	string Get_Variable(Config_Variable Variable, 
			unsigned int Index=0) const ;

	// Mutators
	void Set_Variable(Config_Variable Variable, string Value,
			unsigned int Index=0) ;

protected:
	vector<string> M_Money_Types ;
	vector<string> M_Money_Adjectives ;
	int M_Money_Start ;
	string M_Object_Base_Type ;
	vector<string> M_Object_Types ;
	vector<string> M_Object_Adjectives ;

private:
	// Facilitators
	void Default_Variable(Config_Variable Variable) ;
} ;

#endif // LIAM_CONFIG
