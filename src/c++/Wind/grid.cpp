#ifndef HAVE_IMPLEMENTED_LIAM_GRID
#define HAVE_IMPLEMENTED_LIAM_GRID
#include "Grid.h"
#endif

// Constructors
template <class Type>
Grid<Type>::Grid(int X_Size, int Y_Size) {
	X_Size=MAX_X_VIEW+4*(MAX_X_VIEW/4)*(X_Size-1) ;
	Y_Size=MAX_Y_VIEW+4*(MAX_Y_VIEW/4)*(Y_Size-1) ;

	M_Grid=new Type[X_Size*Y_Size] ;

	M_Zoom=1 ;
	M_Size=Point(X_Size, Y_Size) ;
	Set_View(0, 0) ;
}

// Destructors
template <class Type>
Grid<Type>::~Grid(void) {
	delete [] M_Grid ;
}

// Facilitators
template <class Type>
void Grid<Type>::Put(void) {
	int X_Coord=M_Offset.Get_X(), Y_Coord=M_Offset.Get_Y() ;
	for (int n=X_Coord; n<X_Coord+MAX_X_VIEW; n++) {
		for (int nn=Y_Coord; nn<Y_Coord+MAX_Y_VIEW; nn++) {
			Get_Thing(n, nn).Put(n-X_Coord+1, nn-Y_Coord+1) ;
		}
	}
}
template <class Type>
void Grid<Type>::Put_Thing(int X_Coord, int Y_Coord) {
	int X_Offset=M_Offset.Get_X(), Y_Offset=M_Offset.Get_Y() ;
	if(X_Coord>=X_Offset && Y_Coord>=Y_Offset && 
			X_Coord<X_Offset+MAX_X_VIEW &&
			Y_Coord<Y_Offset+MAX_Y_VIEW)
		Get_Thing(X_Coord, Y_Coord).Put(X_Coord-X_Offset+1, 
				Y_Coord-Y_Offset+1) ;
}

template <class Type>
bool Grid<Type>::Scroll(Direction direction, int Range) {
	int X_Min=M_Offset.Get_X()-MAX_X_VIEW/Range ;
	int X_Max=M_Offset.Get_X()+MAX_X_VIEW/Range ;

	int Y_Min=M_Offset.Get_Y()-MAX_Y_VIEW/Range ;
	int Y_Max=M_Offset.Get_Y()+MAX_Y_VIEW/Range ;
	bool Did_Scroll=false ;

	switch(direction) {
	case SW:
	case S:
	case SE:
		Did_Scroll=Did_Scroll||Set_View(X_Max, M_Offset.Get_Y() ) ;
		break ;
	case NW:
	case N:
	case NE:
		Did_Scroll=Did_Scroll||Set_View(X_Min, M_Offset.Get_Y() ) ;
		break ;
	default:
		break ;
	}
	switch(direction) {
	case SW:
	case W:
	case NW:
		Did_Scroll=Did_Scroll||Set_View(M_Offset.Get_X(), Y_Min) ;
		break ;
	case SE:
	case E:
	case NE:
		Did_Scroll=Did_Scroll||Set_View(M_Offset.Get_X(), Y_Max) ;
		break ;
	default:
		break ;
	}
	return Did_Scroll ;
}

// Inspectors
template <class Type>
Point Grid<Type>::Get_View(void) const {
	return M_Offset ;
}

template <class Type>
Point Grid<Type>::Get_Size(void) const {
	return M_Size ;
}

template <class Type>
Type &Grid<Type>::Get_Thing(int X_Coord, int Y_Coord) const {
	if (X_Coord>M_Size.Get_X() || Y_Coord>M_Size.Get_Y() ) {
		char Error[96] ;
		sprintf(Error, "Grid::Get_Thing(%d, %d)", X_Coord, Y_Coord) ;
		Die(Error) ;
	}
	return M_Grid[X_Coord*(M_Size.Get_Y() )+Y_Coord] ;
}

template <class Type>
Type &Grid<Type>::Get_Thing(Point Position) const {
	return Get_Thing(Position.Get_X(), Position.Get_Y() ) ;
}

template <class Type>
int Grid<Type>::Get_Zoom(void) const {
	return M_Zoom ;
}

// Mutators
template <class Type>
bool Grid<Type>::Set_View(int X_Coord, int Y_Coord) {
	X_Coord=X_Coord<M_Size.Get_X()-MAX_X_VIEW?X_Coord:M_Size.Get_X()-
			MAX_X_VIEW ;
	Y_Coord=Y_Coord<M_Size.Get_Y()-MAX_Y_VIEW?Y_Coord:M_Size.Get_Y()-
			MAX_Y_VIEW ;
	X_Coord=(X_Coord>0?X_Coord:0) ;
	Y_Coord=(Y_Coord>0?Y_Coord:0) ;
	if(Point(X_Coord, Y_Coord)==M_Offset)
		return false ;
	M_Offset=Point(X_Coord, Y_Coord) ;
	return true ;
}

template <class Type>
bool Grid<Type>::Set_View(Point Position) {
	return Set_View(Position.Get_X(), Position.Get_Y() ) ;
}

template <class Type>
void Grid<Type>::Set_Thing(const Type &Thing, int X_Coord, int Y_Coord) {
	if (X_Coord>M_Size.Get_X() || Y_Coord>M_Size.Get_Y() ) {
		char Error[96] ;
		sprintf(Error, "Grid::Set_Thing(%d, %d)", X_Coord, Y_Coord) ;
		Die(Error) ;
	}
	M_Grid[X_Coord*(M_Size.Get_Y() )+Y_Coord]=Thing ;
}

template <class Type>
void Grid<Type>::Set_Thing(const Type &Thing, Point Position) {
	Set_Thing(Thing, Position.Get_X(), Position.Get_Y() ) ;
}

template <class Type>
void Grid<Type>::Set_Zoom(int Zoom) {
	if(Zoom<1||Zoom>4) {
		char Error[96] ;
		sprintf(Error, "Grid::Set_Zoom(%d)", Zoom) ;
		Die(Error) ;
	}
	M_Zoom=Zoom ;
}

template <class Type>
void Grid<Type>::Set_Box(const Type &Thing, Point Start, Point End) {
	for(int n=Start.Get_X(); n<End.Get_X(); n++)
		for(int nn=Start.Get_Y(); nn<End.Get_Y(); nn++)
			Set_Thing(Thing, n, nn) ;
}

template <class Type>
void Grid<Type>::Flood(const Type &Thing) {
	for (int n=0; n<M_Size.Get_X(); n++) {
		for (int nn=0; nn<M_Size.Get_Y(); nn++) {
			Set_Thing(Thing, n, nn) ;
		}
	}
}

