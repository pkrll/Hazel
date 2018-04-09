#include <string.h>
#include "cp.h"

void generate_c() {

	if (copy_file("templates/Makefile", "bin/Makefile") == NO_ERR) {
		printf("Created Makefile!\n");
	}

	if (copy_file("templates/.editorconfig", "bin/.editorconfig") == NO_ERR) {
		printf("Created Editor config!\n");
	}

}

int main(int argc, char const *argv[]) {
	if (argc < 2) {
		printf("Usage: %s --new\n", argv[0]);
		return 0;
	}

	if (strcmp(argv[1], "--new") == 0) {
		printf("Generating new project...\n");
		generate_c();
	}

	return 0;
}
