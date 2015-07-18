
#ifndef LOG_H
 #define LOG_H

void log_init(void);

void log_level(int verbosity);

void log_err(const char *format, ...);

void log_warn(const char *format, ...);

void log_notice(const char *format, ...);

void log_info(const char *format, ...);

void log_debug(const char *format, ...);

void log_close(void);

#endif
