#ifndef MMONEY_CONFIG
# define MMONEY_CONFIG

# include <string>
# include <vector>

const auto DEFAULT_CONFIG{"host.config"};

enum class Config_Variable { Money_Type, Money_Adjective, Object_Base_Type,
		Object_Type, Object_Adjective, Money_Start };
std::ostream& operator<<(std::ostream& os, Config_Variable& v);

class Configuration {
public:
	// Constructors
	Configuration(std::string Config=DEFAULT_CONFIG);

	// Inspectors
	size_t Get_Variable_Count(Config_Variable Variable) const;
	std::string Get_Variable(Config_Variable Variable, size_t Index=0) const;

	// Mutators
	void Set_Variable(Config_Variable Variable, std::string Value, size_t Index=0);

protected:
	std::vector<std::string> M_Money_Types;
	std::vector<std::string> M_Money_Adjectives;
	int M_Money_Start;
	std::string M_Object_Base_Type;
	std::vector<std::string> M_Object_Types;
	std::vector<std::string> M_Object_Adjectives;

private:
	// Facilitators
	void Default_Variable(Config_Variable Variable);
};

#endif // MMONEY_CONFIG
