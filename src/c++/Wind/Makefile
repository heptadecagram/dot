
CXXFLAGS+=-std=c++1y -Wall -Werror -pedantic
LDLIBS+=-lncurses -lstdc++
OBJECTS=error.o io.o random.o screen_object.o terrain.o monster.o

Eurus: $(OBJECTS)

Eurus.o: Eurus.cpp io.h terrain.h

monster.o: monster.cpp monster.h screen_object.h

terrain.o: terrain.cpp terrain.h screen_object.h

screen_object.o: screen_object.cpp screen_object.h io.h

random.o: random.cpp random.h

io.o: io.cpp io.h error.h

error.o: error.cpp error.h


.PHONY: clean

clean:
	-$(RM) *.o *~ Eurus core
