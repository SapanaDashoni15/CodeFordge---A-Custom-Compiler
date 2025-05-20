#include <stdio.h>

extern int yyparse();
extern FILE *yyin;

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Could not open input file");
            return 1;
        }
        yyin = file;
    }

    printf("Starting parser...\n");
    int result = yyparse();

    if (result == 0)
        printf("Parsing completed successfully.\n");
    else
        printf("Parsing failed.\n");

    return result;
}
