SC=swiftc

EXECUTABLE=bin/hazel

# Source & object files
SOURCES = $(shell find src -type f -name '*.swift')
OBJECTS = $(patsubst src/%.c, build/%.o, $(SOURCES))

all: $(EXECUTABLE)

$(EXECUTABLE): $(SOURCES)
	swiftc $^ -o $@

run: $(EXECUTABLE)
	./$(EXECUTABLE) --new

clean:
	rm -rf bin/*
