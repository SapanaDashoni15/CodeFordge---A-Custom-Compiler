#include <stdio.h>

extern FILE *yyin;
int yylex();

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Could not open input file");
            return 1;
        }
        yyin = file;
    }

    printf("Starting lexer...\n");
    while (yylex() != 0) {
        // Tokens printed by lexer rules
    }
    printf("Lexing completed.\n");

    return 0;
}
