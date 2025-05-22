%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string>
#include <string.h>
#include "src/symbolTable.hpp"

SymbolTable symbols;

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int num;
    char* str;  
}

%token <str> IDENTIFIER
%token <num> NUMBER

%token INT IF WHILE
%token EQ NE LE GE LT GT
%token ASSIGN PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON

%left EQ NE LT GT LE GE
%left PLUS MINUS
%left TIMES DIVIDE

%type <num> expression

%%

program:
    program statement
  | /* empty */
  ;

statement:
    declaration
  | assignment
  | if_stmt
  | while_stmt
  ;

declaration:
    INT IDENTIFIER ASSIGN expression SEMICOLON {
        if (!symbols.isDeclared($2)) {
            symbols.declare($2, $4);
            printf("Declared %s = %d\n", $2, $4);
        } else {
            yyerror(("Variable already declared: " + std::string($2)).c_str());
        }
    }
  ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON {
        if (symbols.isDeclared($1)) {
            symbols.declare($1, $3);
            printf("Assigned %s = %d\n", $1, $3);
        } else {
            yyerror(("Undeclared variable: " + std::string($1)).c_str());
        }
    }
  ;

if_stmt:
    IF LPAREN expression RPAREN block {
        printf("Parsed if-statement (condition result = %d)\n", $3);
    }
  ;

while_stmt:
    WHILE LPAREN expression RPAREN block {
        printf("Parsed while-loop (condition result = %d)\n", $3);
    }
  ;

block:
    LBRACE program RBRACE
  ;

expression:
      expression PLUS expression       { $$ = $1 + $3; }
    | expression MINUS expression      { $$ = $1 - $3; }
    | expression TIMES expression      { $$ = $1 * $3; }
    | expression DIVIDE expression     {
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | expression EQ expression         { $$ = ($1 == $3); }
    | expression NE expression         { $$ = ($1 != $3); }
    | expression LT expression         { $$ = ($1 < $3); }
    | expression GT expression         { $$ = ($1 > $3); }
    | expression LE expression         { $$ = ($1 <= $3); }
    | expression GE expression         { $$ = ($1 >= $3); }
    | LPAREN expression RPAREN         { $$ = $2; }
    | NUMBER                           { $$ = $1; }
    | IDENTIFIER {
        if (symbols.isDeclared($1)) {
            $$ = symbols.getValue($1);
        } else {
            yyerror(("Undeclared variable: " + std::string($1)).c_str());
            $$ = 0;
        }
    }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
