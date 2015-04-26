# __GNUC__ is the predefined macro for gcc
# __cplusplus is the predefined macro for a C++ compiler

CC=c++
LIBS=-lm
CXXFLAGS+= -Wall -Werror -Wpedantic -Wno-deprecated -std=c++1y
BFLAGS+= -Wall -Werror -Wpedantic -Wno-deprecated
OBJECTS=array.o config.o bank.o main.o

SHELL=/bin/sh

TARGET=MMoney

$(TARGET): main.cpp $(OBJECTS)
	$(CC) $(BFLAGS) $(LIBS) $(OBJECTS) -o $@

main.o: main.cpp config.h
	$(CC) -I$(srcdir) $(CXXFLAGS) -c $< -o $@

bank.o: bank.cpp bank.h config.h array.o
	$(CC) -I$(srcdir) $(CXXFLAGS) -c $< -o $@

config.o: config.cpp config.h
	$(CC) -I$(srcdir) $(CXXFLAGS) -c $< -o $@

array.o: array.cpp array.h
	$(CC) -I$(srcdir) $(CXXFLAGS) -c $< -o $@


.PHONY: clean

clean:
	-rm *.o *~ $(TARGET) core

Backup_Name!=date "+%Y.%m.%d.%H.%M.%S"
backup:
	tar -cf $(TARGET).$(Backup_Name).tar *.h *.cpp
	gzip $(TARGET).$(Backup_Name).tar
	mv $(TARGET).$(Backup_Name).tar.gz ../Backups

