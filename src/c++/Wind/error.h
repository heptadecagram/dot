//
// This file is designed for simple error trapping and inspection.  It declares
// two functions, Die() and Warn(), which are identical in arguments to the
// printf(3) function.  Neither have a return value.  Die() is designed for
// critical errors that require the termination of the program.  Die()
// terminates the program after being called.  Warn() is designed to catch
// oddities that are not critical to the execution of the program, and
// hence does not stop execution.  Both write the errors out to files,
// defined below.  The size of the formatted string passed to both Die()
// and Warn() is 1023 characters.

#ifndef LIAM_ERROR
#define LIAM_ERROR

// These are the files that warnings and errors are written to.
#ifdef UNIX
#define LIAM_WARNING_FILE "./.warning_log"
#define LIAM_ERROR_FILE   "./.error_log"
#endif // UNIX

#ifdef __DJGPP__
#define LIAM_WARNING_FILE "./warning.log"
#define LIAM_ERROR_FILE "./error.log"
#endif // __DJGPP__

// Used for formatting and printing messages.
#include <cstdio>
// Used for variable arguments passed to Die() and Warn().
#include <cstdarg>
// Used for exit().
#include <cstdlib>
using namespace std ;

void Die(char* Format, ...) ;

void Warn(char* Format, ...) ;

#endif // LIAM_ERROR
