#include "cp.h"

void copy_file(const char *src_path, const char *dst_path) {
	FILE *src_file = fopen(src_path, "rb");

	if (src_file == NULL) {
		printf("Error opening file...\n");
		return;
	}

	fseek(src_file, 0, SEEK_END);
	size_t size = ftell(src_file);
	rewind(src_file);

	char *buffer = malloc(sizeof(char) * size);

	if (fread(buffer, 1, size, src_file) != size) {
		printf("Error reading file...\n");
		return;
	}

	FILE *dst_file  = fopen(dst_path, "wb");

	if (dst_file == NULL) {
		printf("Error creating file...\n");
		return;
	}

	fwrite(buffer, 1, size, dst_file);

	fclose(src_file);
	fclose(dst_file);

	free(buffer);
}
