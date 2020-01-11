CFLAGS += -std=c17 
CFLAGS += -Wall -Wextra -Wpedantic
CFLAGS += -Wwrite-strings -Wfloat-equal -Wconversion
CFLAGS += -Waggregate-return -Winline -Wstack-usage=256

wind: wind.o log.o

log.o: CFLAGS += -D_DEFAULT_SOURCE

clean:
	$(RM) *.o
