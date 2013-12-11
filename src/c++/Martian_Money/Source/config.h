
#ifndef LIAM_CONFIG
# define LIAM_CONFIG

# define DEFAULT_CONFIG "host.config"

# include <iostream>
# include <fstream>
# include <string>
# include <vector>

enum Config_Variable { Money_Type, Money_Adjective, Object_Base_Type,
		Object_Type, Object_Adjective, Money_Start } ;

class Configuration {
public:
	// Constructors
	Configuration(std::string Config=DEFAULT_CONFIG) ;

	// Inspectors
	int Get_Variable_Count(Config_Variable Variable) const ;
	std::string Get_Variable(Config_Variable Variable, unsigned int Index=0) const ;

	// Mutators
	void Set_Variable(Config_Variable Variable, std::string Value, unsigned int Index=0) ;

protected:
	std::vector<std::string> M_Money_Types ;
	std::vector<std::string> M_Money_Adjectives ;
	int M_Money_Start ;
	std::string M_Object_Base_Type ;
	std::vector<std::string> M_Object_Types ;
	std::vector<std::string> M_Object_Adjectives ;

private:
	// Facilitators
	void Default_Variable(Config_Variable Variable) ;
} ;

#endif // LIAM_CONFIG