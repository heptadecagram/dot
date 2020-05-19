#include "config.h"

#include <iostream>
#include <fstream>

// Constructors
Configuration::Configuration(std::string Config_Filename) {
	std::ifstream Config_File{Config_Filename};

	if(!Config_File.is_open() ) {
		std::cerr << "Could not open '" << Config_Filename << "' for reading!\nUsing defaults....\n";

		Default_Variable(Config_Variable::Money_Type);
		Default_Variable(Config_Variable::Money_Adjective);
		Default_Variable(Config_Variable::Object_Base_Type);
		Default_Variable(Config_Variable::Object_Type);
		Default_Variable(Config_Variable::Object_Adjective);
		return;
	}

	while(!Config_File.eof() ) {
		std::string Buffer;
		getline(Config_File, Buffer);

		if(Buffer.find("[Money-Type]=")!=std::string::npos) {
			auto Begin_Quote=Buffer.substr(Buffer.find('\'') );
			auto Length=Begin_Quote.find('\'', 1);
			if(Length>0)
				M_Money_Types.push_back(Begin_Quote.substr(1,
					Length-1) );
			else
				std::cerr << "Error reading " << Config_Filename <<
					" for Money Types" << std::endl;
		}

		if(Buffer.find("[Money-Adjective]=")!=std::string::npos) {
			auto Begin_Quote=Buffer.substr(Buffer.find('\'') );
			int Length=Begin_Quote.find('\'', 1);
			if(Length>0)
				M_Money_Adjectives.push_back(
					Begin_Quote.substr(1, Length-1) );
			else
				std::cerr << "Error reading " << Config_Filename <<
					" for Money Adjectives" << std::endl;
		}

		if(Buffer.find("[Money-Start-Amount]=")!=std::string::npos &&
				Buffer.find('\'')!=std::string::npos) {
			auto Begin_Quote=Buffer.substr(Buffer.find('\'') );
			int Length=Begin_Quote.find('\'', 1);
			if(Length>0)
				/*M_Money_Start=atoi(Begin_Quote.substr(1,
					Length-1) );*/
				M_Money_Start=100;
			else
				std::cerr << "Error reading " << Config_Filename <<
					" for starting Money amount" << std::endl;
		}

		if(Buffer.find("[Object-Base-Type]=")!=std::string::npos) {
			auto Begin_Quote=Buffer.substr(Buffer.find('\'') );
			int Length=Begin_Quote.find('\'', 1);
			if(Length>0)
				M_Object_Base_Type=Begin_Quote.substr(1,
					Length-1);
			else
				std::cerr << "Error reading " << Config_Filename <<
					" for Object Base Type" << std::endl;
		}

		if(Buffer.find("[Object-Type]=")!=std::string::npos) {
			auto Begin_Quote=Buffer.substr(Buffer.find('\'') );
			int Length=Begin_Quote.find('\'', 1);
			if(Length>0)
				M_Object_Types.push_back(Begin_Quote.substr(1,
					Length-1) );
			else
				std::cerr << "Error reading " << Config_Filename <<
					" for Object Types" << std::endl;
		}

		if(Buffer.find("[Object-Adjective]=")!=std::string::npos) {
			auto Begin_Quote=Buffer.substr(Buffer.find('\'') );
			int Length=Begin_Quote.find('\'', 1);
			if(Length>0)
				M_Object_Adjectives.push_back(
					Begin_Quote.substr(1, Length-1) );
			else
				std::cerr << "Error reading " << Config_Filename <<
					" for Object Adjectives" << std::endl;
		}
	}

	if(M_Money_Types.size()==0)
		Default_Variable(Config_Variable::Money_Type);
	if(M_Money_Adjectives.size()==0)
		Default_Variable(Config_Variable::Money_Adjective);
	if(M_Object_Base_Type=="")
		Default_Variable(Config_Variable::Object_Base_Type);
	if(M_Object_Types.size()==0)
		Default_Variable(Config_Variable::Object_Type);
	if(M_Object_Adjectives.size()==0)
		Default_Variable(Config_Variable::Object_Adjective);
}


// Inspectors
int Configuration::Get_Variable_Count(Config_Variable Variable) const {
	switch(Variable) {
		case Config_Variable::Money_Type:
			return M_Money_Types.size();
		case Config_Variable::Money_Adjective:
			return M_Money_Adjectives.size();
		case Config_Variable::Object_Type:
			return M_Object_Types.size();
		case Config_Variable::Object_Adjective:
			return M_Object_Adjectives.size();
		default:
			std::cerr << "Get_Variable_Count(" << Variable << ") defaulted!" <<
				std::endl;
			return 0;
	}
}

std::string Configuration::Get_Variable(Config_Variable Variable, size_t Index) const {
	switch(Variable) {
		case Config_Variable::Money_Type:
			if(M_Money_Types.size()>Index)
				return M_Money_Types[Index];
			else
				break;
		case Config_Variable::Money_Adjective:
			if(M_Money_Adjectives.size()>Index)
				return M_Money_Adjectives[Index];
			else
				break;
		case Config_Variable::Money_Start:
			return "Bob";
		case Config_Variable::Object_Base_Type:
			return M_Object_Base_Type;
		case Config_Variable::Object_Type:
			if(M_Object_Types.size()>Index)
				return M_Object_Types[Index];
			else
				break;
		case Config_Variable::Object_Adjective:
			if(M_Object_Adjectives.size()>Index)
				return M_Object_Adjectives[Index];
			else
				break;
		default:
			std::cerr << "Get_Variable(" << Variable << ", " << Index <<
				") defaulted!" << std::endl;
			return "";
	}
	std::cerr << "Get_Variable(" << Variable << ", " << Index <<
		") out of range!" << std::endl;
	return "";
}


// Mutators
void Configuration::Set_Variable(Config_Variable Variable, std::string Value, size_t Index) {
	switch(Variable) {
		case Config_Variable::Money_Type:
			if(M_Money_Types.size()>Index)
				M_Money_Types[Index]=Value;
			break;
		case Config_Variable::Money_Adjective:
			if(M_Money_Adjectives.size()>Index)
				M_Money_Adjectives[Index]=Value;
			break;
		case Config_Variable::Object_Base_Type:
			M_Object_Base_Type=Value;
			break;
		case Config_Variable::Object_Type:
			if(M_Object_Types.size()>Index)
				M_Object_Types[Index]=Value;
			break;
		case Config_Variable::Object_Adjective:
			if(M_Object_Adjectives.size()>Index)
				M_Object_Adjectives[Index]=Value;
			break;
		default:
			std::cerr << "Set_Variable(" << Variable << ", " << Index << ", " <<
				Value << ") defaulted!" << std::endl;
	}
}


// Private Functions
// Facilitators
void Configuration::Default_Variable(Config_Variable Variable) {
	switch(Variable) {
		case Config_Variable::Money_Type:
			M_Money_Types.clear();
			M_Money_Types.push_back("Singo");
			M_Money_Types.push_back("Dingo");
			M_Money_Types.push_back("Tringo");
			break;
		case Config_Variable::Money_Adjective:
			M_Money_Adjectives.clear();
			M_Money_Adjectives.push_back("Red");
			M_Money_Adjectives.push_back("Yellow");
			M_Money_Adjectives.push_back("Green");
			M_Money_Adjectives.push_back("Blue");
			break;
		case Config_Variable::Money_Start:
			M_Money_Start=100;
			break;
		case Config_Variable::Object_Base_Type:
			M_Object_Base_Type="Pyramid";
			break;
		case Config_Variable::Object_Type:
			M_Object_Types.clear();
			M_Object_Types.push_back("Small");
			M_Object_Types.push_back("Medium");
			M_Object_Types.push_back("Large");
			break;
		case Config_Variable::Object_Adjective:
			M_Object_Adjectives.clear();
			M_Object_Adjectives.push_back("Red");
			M_Object_Adjectives.push_back("Yellow");
			M_Object_Adjectives.push_back("Green");
			M_Object_Adjectives.push_back("Blue");
			break;
		default:
			break;
	}
}

std::ostream& operator<<(std::ostream& os, Config_Variable& v) {
	switch(v) {
		case Config_Variable::Money_Type:
			os << "Money-Type";
			break;
		case Config_Variable::Money_Adjective:
			os << "Money-Adjective";
			break;
		case Config_Variable::Money_Start:
			os << "Money-Start";
			break;
		case Config_Variable::Object_Base_Type:
			os << "Object-Base-Type";
			break;
		case Config_Variable::Object_Type:
			os << "Object-Type";
			break;
		case Config_Variable::Object_Adjective:
			os << "Object-Adjective";
			break;
	}

	return os;
}
