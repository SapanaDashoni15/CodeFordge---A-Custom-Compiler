%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.tab.h" 



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
