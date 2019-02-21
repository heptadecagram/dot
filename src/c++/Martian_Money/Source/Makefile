
LDLIBS += -lm -lc++
CXXFLAGS += -Wall -Wextra -Wpedantic -Wno-deprecated -std=c++17

.PHONY: clean
TARGET = MMoney
OBJECTS = MMoney.o array.o config.o bank.o

$(TARGET): $(OBJECTS)


clean:
	$(RM) *.o *~ $(TARGET) core
