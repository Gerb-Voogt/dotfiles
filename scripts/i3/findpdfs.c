#include <stdio.h>
#include <string.h>
#include <dirent.h>


void search_dir(const char* dir_path, const char* ext) {
    DIR *dir = opendir(dir_path);

    struct dirent *entry;

    while ((entry = readdir(dir)) != NULL) {
	if (entry->d_type == DT_DIR) {
	    // ignore . and .. directories
	    if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
		continue;
	    }

	    // Recursively search
	    char sub_dir_path[512];
	    snprintf(sub_dir_path, sizeof(sub_dir_path), "%s/%s", dir_path, entry->d_name);
	    search_dir(sub_dir_path, ext);
	} else {
	    // Check if file has the desired extension
	    const char *dot = strrchr(entry->d_name, '.');
	    if (dot != NULL && strcmp(dot + 1, ext) == 0) {
		// File has the desired extension, do something with it
		printf("%s/%s\n", dir_path, entry->d_name);
	    }
	}
    }

    closedir(dir);
}

int main() {
    const char *dir_path = "/home/gerben/uni";
    const char *ext = "pdf";
    search_dir(dir_path, ext);
    return 0;
}
