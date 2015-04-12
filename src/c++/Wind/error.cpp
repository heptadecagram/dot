// Description of use and declared constants.
#include "error.h"

void Die(char* Format, ...) {
	// This is a temporary string for storing the error.
	char Buffer[1023] ;

	// The caller of Die() chooses the format for the error, so
	// all that is done here is to format the arguments and put
	// them in Buffer.
	va_list List ;
	va_start(List, Format) ;
	vsprintf(Buffer, Format, List) ;
	va_end(List) ;

	// Here, try to open and append to a logfile for errors.
	FILE* ERROR=fopen(LIAM_ERROR_FILE, "a") ;

	// Let the user know that an error occurred, and what it was.
	fprintf(stderr, "\nCritical Error!\n\n\t%s\n\n", Buffer) ;

	// If the logfile could not be opened, let the user know.
	if(!ERROR)
		fprintf(stderr, "Unable to write to %s", LIAM_ERROR_FILE) ;
	// Otherwise, append to the logfile and let the user know.
	else {
		fprintf(ERROR, "%s\n", Buffer) ;
		fclose(ERROR) ;
		fprintf(stderr, "Logged to %s\n\n", LIAM_ERROR_FILE) ;
	}

	// End the program with an error.  EXIT_FAILURE used for portability.
	exit(EXIT_FAILURE) ;
}

void Warn(char* Format, ...) {
	// This is a temporary string for storing the warning.
	char Buffer[1023] ;

	// The caller of Warn() chooses the format for the warning, so
	// all that is done here is to format the arguments and put
	// them in Buffer.
	va_list List ;
	va_start(List, Format) ;
	vsprintf(Buffer, Format, List) ;
	va_end(List) ;

	// Here, try to open and append to a logfile for warnings.
	FILE* WARNING=fopen(LIAM_WARNING_FILE, "a") ;

	// Let the user know that an warning occurred, and what it was.
	fprintf(stderr, "\nWarning!\n\n\t%s\n\n", Buffer) ;

	// If the logfile could not be opened, let the user know.
	if(!WARNING)
		fprintf(stderr, "Unable to write to %s", LIAM_WARNING_FILE) ;
	// Otherwise, append to the logfile and let the user know.
	else {
		fprintf(WARNING, "%s\n", Buffer) ;
		fclose(WARNING) ;
		fprintf(stderr, "Logged to %s\n\n", LIAM_WARNING_FILE) ;
	}
}
