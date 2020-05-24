CFLAGS += -std=c17
CFLAGS += -Wall -Wextra -Wpedantic
CFLAGS += -Wwrite-strings -Wfloat-equal -Wconversion
CFLAGS += -Waggregate-return -Winline

# Defined for ncursesw
wind: CPPFLAGS += -D_XOPEN_SOURCE_EXTENDED
wind: LDLIBS += -lncursesw
wind: wind.o log.o walls.o

log.o: CFLAGS += -D_DEFAULT_SOURCE

clean:
	$(RM) *.o
