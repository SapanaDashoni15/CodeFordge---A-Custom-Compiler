#include <cstdio>

extern int yyparse();      // Bison function
extern FILE* yyin;         // Flex file input

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("Usage: ./compiler_semantic <input_file>\n");
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening file");
        return 1;
    }

    printf("Starting parser...\n");
    yyparse();
    printf("Parsing completed successfully.\n");

    fclose(yyin);
    return 0;
}
