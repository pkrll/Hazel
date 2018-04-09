CC=gcc
CCFLAGS=-g -Wall -pedantic

EXECUTABLE=bin/hazel

# Source & object files
SOURCES = $(shell find src -type f -name '*.c')
OBJECTS = $(patsubst src/%.c, build/%.o, $(SOURCES))

all: $(OBJECTS) $(EXECUTABLE)

build/%.o: src/%.c
	$(CC) $(CCFLAGS) -c $< -o $@

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@

run: $(EXECUTABLE)
	$(EXECUTABLE) --new

clean:
	rm -rf build/*.o
	rm -rf bin/*
	rm -rf bin/.editorconfig
