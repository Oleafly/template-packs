#include <stdio.h>

/* Greet the world a few times. */
int main(void) {
    const char *name = "World";
    for (int i = 0; i < 3; i++) {
        printf("Hello, %s! (%d)\n", name, i);
    }
    return 0;
}
