# File: Makefile
# Author: Liam Bryan
# Language: sh
# Last Modified: 2002.05.10
#
# __GNUC__ is the predefined macro for gcc
# __cplusplus is the predefined macro for a C++ compiler

CC=c++
CFLAGS+=-DUNIX -O3 -Wall
BFLAGS+=-lncurses -DUNIX -O3 -Wall
OBJECTS=error.o io.o random.o screen_object.o terrain.o monster.o main.o

SHELL=/bin/sh


Eurus: main.cpp $(OBJECTS)
	$(CC) $(BFLAGS) $(OBJECTS) -o $@

main.o: main.cpp io.h terrain.h
	$(CC) -I$(srcdir) -c $(CFLAGS) $< -o $@

monster.o: monster.cpp monster.h screen_object.h
	$(CC) -I$(srcdir) -c $(CFLAGS) $< -o $@

terrain.o: terrain.cpp terrain.h screen_object.h
	$(CC) -I$(srcdir) -c $(CFLAGS) $< -o $@

screen_object.o: screen_object.cpp screen_object.h io.h
	$(CC) -I$(srcdir) -c $(CFLAGS) $< -o $@

random.o: random.cpp random.h
	$(CC) -I$(srcdir) -c $(CFLAGS) $< -o $@

io.o: io.cpp io.h error.h
	$(CC) -I$(srcdir) -c $(CFLAGS) $< -o $@

error.o: error.cpp error.h
	$(CC) -I$(srcdir) -c $(CFLAGS) $< -o $@


.PHONY: clean

clean:
	-rm *.o *~ Eurus core

Backup_Name:=`date "+%Y.%m.%d.%H.%M.%S"`
backup:
	tar -cf $(Backup_Name).tar *.h *.cpp
	gzip $(Backup_Name).tar
	mv $(Backup_Name).tar.gz ../Backups

