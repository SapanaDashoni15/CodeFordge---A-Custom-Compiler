%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.tab.h" 

#define INT 1
#define IF 2
#define WHILE 3
#define EQ 4
#define NE 5
#define LE 6
#define GE 7
#define LT 8
#define GT 9
#define ASSIGN 10
#define PLUS 11
#define MINUS 12
#define TIMES 13
#define DIVIDE 14
#define LPAREN 15
#define RPAREN 16
#define LBRACE 17
#define RBRACE 18
#define SEMICOLON 19
#define NUMBER 20
#define IDENTIFIER 21

extern int yylval;
%}

%%
"int"           { printf("INT\n"); return INT; }
"if"            { printf("IF\n"); return IF; }
"while"         { printf("WHILE\n"); return WHILE; }

"=="            { printf("EQ\n"); return EQ; }
"!="            { printf("NE\n"); return NE; }
"<="            { printf("LE\n"); return LE; }
">="            { printf("GE\n"); return GE; }
"<"             { printf("LT\n"); return LT; }
">"             { printf("GT\n"); return GT; }

"="             { printf("ASSIGN\n"); return ASSIGN; }
"+"             { printf("PLUS\n"); return PLUS; }
"-"             { printf("MINUS\n"); return MINUS; }
"*"             { printf("TIMES\n"); return TIMES; }
"/"             { printf("DIVIDE\n"); return DIVIDE; }

"("             { printf("LPAREN\n"); return LPAREN; }
")"             { printf("RPAREN\n"); return RPAREN; }
"{"             { printf("LBRACE\n"); return LBRACE; }
"}"             { printf("RBRACE\n"); return RBRACE; }
";"             { printf("SEMICOLON\n"); return SEMICOLON; }

[0-9]+          { printf("NUMBER(%s)\n", yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { printf("IDENTIFIER(%s)\n", yytext); return IDENTIFIER; }

[ \t\n\r]+      ;  // ignore whitespace

.               { printf("Unknown token: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    // Call yylex() repeatedly until EOF
    while (yylex() != 0) {
        // Tokens are printed inside lexer rules already
    }
    printf("End of input\n");
    return 0;
}
