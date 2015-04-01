// File: config.cpp
// Author: Liam Bryan
// Language: C++
// First Created: 2002.07.17
// Last Modified: 2002.07.29

#include "config.h"

// Constructors
Configuration::Configuration(char* Config_Filename) {
	ifstream Config_File ;
	Config_File.open(Config_Filename) ;

	if(!Config_File.is_open() ) {
		cerr << "Could not open '" << Config_Filename <<
			"' for reading!" << endl << "Using defaults...." << 
			endl ;
		Default_Variable(Money_Type) ;
		Default_Variable(Money_Adjective) ;
		Default_Variable(Object_Base_Type) ;
		Default_Variable(Object_Type) ;
		Default_Variable(Object_Adjective) ;
		return ;
	}

	while(!Config_File.eof() ) {
		string Buffer ;
		getline(Config_File, Buffer) ;
		if(Buffer.find("[Money-Type]=")!=string::npos) {
			string Begin_Quote=Buffer.substr(Buffer.find('\'') ) ;
			int Length=Begin_Quote.find('\'', 1) ;
			if(Length>0)
				M_Money_Types.push_back(Begin_Quote.substr(1, 
					Length-1) ) ;
			else
				cerr << "Error reading " << Config_Filename <<
					" for Money Types" << endl ;
		}
		if(Buffer.find("[Money-Adjective]=")!=string::npos) {
			string Begin_Quote=Buffer.substr(Buffer.find('\'') ) ;
			int Length=Begin_Quote.find('\'', 1) ;
			if(Length>0)
				M_Money_Adjectives.push_back(
					Begin_Quote.substr(1, Length-1) ) ;
			else
				cerr << "Error reading " << Config_Filename <<
					" for Money Adjectives" << endl ;
		}
		if(Buffer.find("[Money-Start-Amount]=")!=string::npos &&
				Buffer.find('\'')!=string::npos) {
			string Begin_Quote=Buffer.substr(Buffer.find('\'') ) ;
			int Length=Begin_Quote.find('\'', 1) ;
			if(Length>0)
				/*M_Money_Start=atoi(Begin_Quote.substr(1, 
					Length-1) ) ;*/
				M_Money_Start=100 ;
			else
				cerr << "Error reading " << Config_Filename <<
					" for starting Money amount" << endl ;
		}
		if(Buffer.find("[Object-Base-Type]=")!=string::npos) {
			string Begin_Quote=Buffer.substr(Buffer.find('\'') ) ;
			int Length=Begin_Quote.find('\'', 1) ;
			if(Length>0)
				M_Object_Base_Type=Begin_Quote.substr(1, 
					Length-1) ;
			else
				cerr << "Error reading " << Config_Filename <<
					" for Object Base Type" << endl ;
		}
		if(Buffer.find("[Object-Type]=")!=string::npos) {
			string Begin_Quote=Buffer.substr(Buffer.find('\'') ) ;
			int Length=Begin_Quote.find('\'', 1) ;
			if(Length>0)
				M_Object_Types.push_back(Begin_Quote.substr(1, 
					Length-1) ) ;
			else
				cerr << "Error reading " << Config_Filename <<
					" for Object Types" << endl ;
		}
		if(Buffer.find("[Object-Adjective]=")!=string::npos) {
			string Begin_Quote=Buffer.substr(Buffer.find('\'') ) ;
			int Length=Begin_Quote.find('\'', 1) ;
			if(Length>0)
				M_Object_Adjectives.push_back(
					Begin_Quote.substr(1, Length-1) ) ;
			else
				cerr << "Error reading " << Config_Filename <<
					" for Object Adjectives" << endl ;
		}
	}
	if(M_Money_Types.size()==0)
		Default_Variable(Money_Type) ;
	if(M_Money_Adjectives.size()==0)
		Default_Variable(Money_Adjective) ;
	if(M_Object_Base_Type=="")
		Default_Variable(Object_Base_Type) ;
	if(M_Object_Types.size()==0)
		Default_Variable(Object_Type) ;
	if(M_Object_Adjectives.size()==0)
		Default_Variable(Object_Adjective) ;
	Config_File.close() ;
}


// Destructor
Configuration::~Configuration(void) {
}


// Inspectors
int Configuration::Get_Variable_Count(Config_Variable Variable) const {
	switch(Variable) {
	case Money_Type:
		return M_Money_Types.size() ;
	case Money_Adjective:
		return M_Money_Adjectives.size() ;
	case Object_Type:
		return M_Object_Types.size() ;
	case Object_Adjective:
		return M_Object_Adjectives.size() ;
	default:
		cerr << "Get_Variable_Count(" << Variable << ") defaulted!" << 
			endl ;
		return 0 ;
	}
}

string Configuration::Get_Variable(Config_Variable Variable, 
		unsigned int Index) const {
	switch(Variable) {
	case Money_Type:
		if(M_Money_Types.size()>Index)
			return M_Money_Types[Index] ;
		else
			break ;
	case Money_Adjective:
		if(M_Money_Adjectives.size()>Index)
			return M_Money_Adjectives[Index] ;
		else
			break ;
	case Money_Start:
		return "Bob" ;
	case Object_Base_Type:
		return M_Object_Base_Type ;
	case Object_Type:
		if(M_Object_Types.size()>Index)
			return M_Object_Types[Index] ;
		else
			break ;
	case Object_Adjective:
		if(M_Object_Adjectives.size()>Index)
			return M_Object_Adjectives[Index] ;
		else
			break ;
	default:
		cerr << "Get_Variable(" << Variable << ", " << Index <<  
			") defaulted!" << endl ;
		return "" ;
	}
	cerr << "Get_Variable(" << Variable << ", " << Index << 
		") out of range!" << endl ;
	return "" ;
}


// Mutators
void Configuration::Set_Variable(Config_Variable Variable, string Value, 
		unsigned int Index) {
	switch(Variable) {
	case Money_Type:
		if(M_Money_Types.size()>Index)
			M_Money_Types[Index]=Value ;
		break ;
	case Money_Adjective:
		if(M_Money_Adjectives.size()>Index)
			M_Money_Adjectives[Index]=Value ;
		break ;
	case Object_Base_Type:
		M_Object_Base_Type=Value ;
		break ;
	case Object_Type:
		if(M_Object_Types.size()>Index)
			M_Object_Types[Index]=Value ;
		break ;
	case Object_Adjective:
		if(M_Object_Adjectives.size()>Index)
			M_Object_Adjectives[Index]=Value ;
		break ;
	default:
		cerr << "Set_Variable(" << Variable << ", " << Index << ", " << 
			Value << ") defaulted!" << endl ;
	}
}
	

// Private Functions
// Facilitators
void Configuration::Default_Variable(Config_Variable Variable) {
	switch(Variable) {
	case Money_Type:
		M_Money_Types.clear() ;
		M_Money_Types.push_back("Singo") ;
		M_Money_Types.push_back("Dingo") ;
		M_Money_Types.push_back("Tringo") ;
		break ;
	case Money_Adjective:
		M_Money_Adjectives.clear() ;
		M_Money_Adjectives.push_back("Red") ;
		M_Money_Adjectives.push_back("Yellow") ;
		M_Money_Adjectives.push_back("Green") ;
		M_Money_Adjectives.push_back("Blue") ;
		break ;
	case Money_Start:
		M_Money_Start=100 ;
		break ;
	case Object_Base_Type:
		M_Object_Base_Type="Pyramid" ;
		break ;
	case Object_Type:
		M_Object_Types.clear() ;
		M_Object_Types.push_back("Small") ;
		M_Object_Types.push_back("Medium") ;
		M_Object_Types.push_back("Large") ;
		break ;
	case Object_Adjective:
		M_Object_Adjectives.clear() ;
		M_Object_Adjectives.push_back("Red") ;
		M_Object_Adjectives.push_back("Yellow") ;
		M_Object_Adjectives.push_back("Green") ;
		M_Object_Adjectives.push_back("Blue") ;
		break ;
	default:
		break ;
	}
}
