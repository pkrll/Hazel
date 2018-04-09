#include <stdio.h>
#include <stdlib.h>

enum CP_ERROR { ERR_OPEN, ERR_READ, ERR_WRITE, NO_ERR };

enum CP_ERROR copy_file(const char *src_path, const char *dst_path);
