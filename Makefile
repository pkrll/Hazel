SC=swiftc

EXECUTABLE=.build/x86_64-apple-macosx10.10/debug/Hazel

# Source & object files
SOURCES = $(shell find src -type f -name '*.swift')
OBJECTS = $(patsubst src/%.c, build/%.o, $(SOURCES))

build:
	swift build

run: $(EXECUTABLE)
	./$(EXECUTABLE) --new

clean:
	rm -rf bin/*
	rm -rf .build/x86_64-apple-macosx10.10
