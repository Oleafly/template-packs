/* UPCASE -- copy SYSIN to SYSPRINT, folding to upper case */
#include <stdio.h>
#include <ctype.h>

int main(void)
{
    FILE *in  = fopen("DD:SYSIN", "r");
    FILE *out = fopen("DD:SYSPRINT", "w");
    char line[81];
    long n = 0;

    if (in == NULL || out == NULL)
        return 8;

    while (fgets(line, sizeof line, in) != NULL) {
        char *p;
        for (p = line; *p != '\0'; p++)
            *p = (char)toupper((unsigned char)*p);
        fputs(line, out);
        n++;
    }
    fprintf(out, "%ld records copied\n", n);
    fclose(in);
    fclose(out);
    return 0;
}
