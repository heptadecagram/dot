CFLAGS += -std=c17
CFLAGS += -Wall -Wextra -Wpedantic
CFLAGS += -Wwrite-strings -Wfloat-equal -Wconversion
CFLAGS += -Waggregate-return -Winline

# Defined for ncursesw
wind: CPPFLAGS += -D_XOPEN_SOURCE_EXTENDED
wind: wind.o log.o walls.o

uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')

ifeq ($(uname_S), Linux)
# Linux flags
wind: LDLIBS += -lncursesw
else
# Mac flags
wind: LDLIBS += -lncurses
endif


log.o: CFLAGS += -D_DEFAULT_SOURCE

clean:
	$(RM) *.o
