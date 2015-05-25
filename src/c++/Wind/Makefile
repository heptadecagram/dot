
CPPFLAGS+=-O2 -Wall -Werror -pedantic
LDLIBS+=-lncurses
OBJECTS=error.o io.o random.o screen_object.o terrain.o monster.o main.o

Eurus: $(OBJECTS)
	$(CC) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) $(OBJECTS) -o $@

main.o: main.cpp io.h terrain.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

monster.o: monster.cpp monster.h screen_object.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

terrain.o: terrain.cpp terrain.h screen_object.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

screen_object.o: screen_object.cpp screen_object.h io.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

random.o: random.cpp random.h
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

io.o: io.cpp io.h error.h

error.o: error.cpp error.h


.PHONY: clean

clean:
	-$(RM) *.o *~ Eurus core
