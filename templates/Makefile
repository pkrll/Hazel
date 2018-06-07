.PHONY: all test clean
CC=gcc
CFLAGS=-Wall #-Wextra -Werror -pedantic
TFLAGS=-g -lcunit -I/usr/local/Cellar/cunit/2.1-3/include -L/usr/local/Cellar/cunit/2.1-3/lib
## FOLDERS & FILES ##
SRC_DIR=src
OBJ_DIR=obj
BIN_DIR=bin
TST_DIR=tests

SOURCES  = $(wildcard $(SRC_DIR)/*.c)
SOURCES += $(wildcard $(TST_DIR)/*.c)
OBJECTS  = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCES))

## RULES ##

all:
	@echo "No rule chosen. Aborting."

build: $(OBJECTS)

test: build
	$(CC) $(CFLAGS) $(TFLAGS) -I $(SRC_DIR) $(OBJECTS) $(TESTS) -o $(BIN_DIR)/$@
	@./$(BIN_DIR)/$@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf bin/*
	rm -rf obj/*
	@echo "Object files and binaries removed"
