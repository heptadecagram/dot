
#include "log.h"

#include <syslog.h>
#include <stdarg.h>

void log_init(void)
{
	openlog("wind", LOG_PERROR, LOG_LOCAL3);
}

void log_level(int verbosity)
{
	setlogmask(LOG_UPTO(verbosity));
}

void log_err(const char *format, ...)
{
	va_list vargs;
	va_start(vargs, format);
	vsyslog(LOG_ERR, format, vargs);
	va_end(vargs);
}

void log_warn(const char *format, ...)
{
	va_list vargs;
	va_start(vargs, format);
	vsyslog(LOG_WARNING, format, vargs);
	va_end(vargs);
}

void log_notice(const char *format, ...)
{
	va_list vargs;
	va_start(vargs, format);
	vsyslog(LOG_NOTICE, format, vargs);
	va_end(vargs);
}

void log_info(const char *format, ...)
{
	va_list vargs;
	va_start(vargs, format);
	vsyslog(LOG_INFO, format, vargs);
	va_end(vargs);
}

void log_debug(const char *format, ...)
{
	va_list vargs;
	va_start(vargs, format);
	vsyslog(LOG_DEBUG, format, vargs);
	va_end(vargs);
}

void log_close(void)
{
	closelog();
}
