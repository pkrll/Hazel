.PHONY: all test clean run
CC=gcc
CFLAGS=-Wall -Werror -pedantic
TFLAGS=-g
## FOLDERS & FILES ##
SRC_DIR=src
OBJ_DIR=obj
BIN_DIR=bin
TST_DIR=tests
BINARY=$(BIN_DIR)/__PROJECTNAME__

SOURCES  = $(wildcard $(SRC_DIR)/*.c)
SOURCES += $(wildcard $(TST_DIR)/*.c)
OBJECTS  = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCES))

## RULES ##

all: build

build: $(OBJECTS)

test: build
	$(CC) $(CFLAGS) $(TFLAGS) -I $(SRC_DIR) $(OBJECTS) $(TESTS) -o $(BIN_DIR)/$@
	@./$(BIN_DIR)/$@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BINARY):
	$(CC) $(OBJECTS) -o $@

run: $(BINARY)
	./$(BINARY)

clean:
	rm -rf bin/*
	rm -rf obj/*
	@echo "Object files and binaries removed"
