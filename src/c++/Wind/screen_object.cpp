#include "screen_object.h"

// Constructors
Screen_Object::Screen_Object(void) {
	M_Name="" ;
	M_Image=' ' ;
	M_Color=Black ;
}

Screen_Object::Screen_Object(char* Name, char Image, Color color) {
	if(Image<32 || Image>126 || color<0 || color>15)
		Die("Screen_Object(%s,%d,%d) usage", Name, Image, color) ;
	M_Name=Name ;
	M_Image=Image ;
	M_Color=color ;
}


// Destructor
Screen_Object::~Screen_Object(void) {
}


// Facilitators
void Screen_Object::Put_Image(void) {
	Change_Color(M_Color) ;
	Output_Char(M_Image) ;
}


// Mutators
void Screen_Object::Set_Name(char* Name) {
	M_Name=Name ;
}

void Screen_Object::Set_Image(char Image) {
	if(Image<32 || Image>126)
		Die("%s.Set_Image(%d)", M_Name, Image) ;
	M_Image=Image ;
}

void Screen_Object::Set_Color(Color color) {
	if(color<0 || color>15)
		Warn("%s.Set_Color(%d)", M_Name, color) ;
	M_Color=color ;
}


// Inspectors
char* Screen_Object::Get_Name(void) const {
	return M_Name ;
}

char Screen_Object::Get_Image(void) const {
	return M_Image ;
}

Color Screen_Object::Get_Color(void) const {
	return M_Color ;
}
