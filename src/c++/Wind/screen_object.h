//
// This file is designed for the manipulation of any graphical object.  It
// defines a class Screen_Object that has a name, picture, and color.

#ifndef LIAM_SCREEN_OBJECT
#define LIAM_SCREEN_OBJECT

#include "error.h"
#include "io.h"

class Screen_Object {
public:
	// Constructors
	Screen_Object(void) ;
	Screen_Object(char* Name, char Image, Color color) ;

	virtual Screen_Object& operator=(const Screen_Object &Screen_Object)=0 ;

	// Destructor
	virtual ~Screen_Object(void) ;

	// Facilitators
	virtual void Put_Image(void) ;

	// Mutators
	void Set_Name(char* Name) ;
	void Set_Image(char Image) ;
	void Set_Color(Color color) ;

	// Inspectors
	char* Get_Name(void) const ;
	char Get_Image(void) const ;
	Color Get_Color(void) const ;

protected:
	// Member Variables
	char* M_Name ;
	char M_Image ;
	Color M_Color ;
} ;

#endif // LIAM_SCREEN_OBJECT