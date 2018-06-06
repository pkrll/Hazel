CC=gcc
CCFLAGS=-g -Wall -pedantic

EXECUTABLE=bin/__PROJECTNAME__

# Source & object files
SOURCES = $(shell find src -type f -name '*.c')
OBJECTS = $(patsubst src/%.c, obj/%.o, $(SOURCES))

all: $(OBJECTS) $(EXECUTABLE)

build/%.o: src/%.c
	$(CC) $(CCFLAGS) -c $< -o $@

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@

run: $(EXECUTABLE)
	.$(EXECUTABLE)

clean:
	rm -rf obj/*.o
	rm -rf bin/*
