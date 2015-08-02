
LDLIBS+=-lm -lc++
CXXFLAGS+=-Wall -Werror -Wpedantic -Wno-deprecated -std=c++1y
LDFLAGS+=-Wall -Werror -Wpedantic -Wno-deprecated

.PHONY: clean
TARGET=MMoney
OBJECTS=MMoney.o array.o config.o bank.o

$(TARGET): $(OBJECTS)


clean:
	-rm *.o *~ $(TARGET) core
