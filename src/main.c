#include <string.h>
#include "cp.h"

int main(int argc, char const *argv[]) {
	if (argc < 2) {
		printf("Usage: %s --new\n", argv[0]);
		return 0;
	}

	if (strcmp(argv[1], "--new") == 0) {
		printf("Generating new project...\n");
	}

	return 0;
}
