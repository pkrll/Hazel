CC=gcc
CCFLAGS=-g -Wall -pedantic
LDFLAGS=-g

# Source & object files
SOURCES = $(shell find src -type f -name '*.c')
OBJECTS = $(patsubst src/%.c, build/%.o, $(SOURCES))

all: $(OBJECTS) bin/hazel

build/%.o: src/%.c
	$(CC) $(CCFLAGS) -c $< -o $@

bin/hazel: build/*.o
	$(CC) $(LDFLAGS) $^ -o $@

run:
	./bin/hazel --new

clean:
	rm -rf build/*.o
	rm -rf bin/*
