%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int yylex(void);

void yyerror(const char *s);

%}

%union {
    int num;
}

%token <num> NUMBER
%token IDENTIFIER
%token INT IF WHILE
%token EQ NE LE GE LT GT
%token ASSIGN PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON

%left EQ NE LT GT LE GE
%left PLUS MINUS
%left TIMES DIVIDE

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
        printf("Parsed declaration\n");
    }
  ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON {
        printf("Parsed assignment\n");
    }
  ;

if_stmt:
    IF LPAREN expression RPAREN block {
        printf("Parsed if-statement\n");
    }
  ;

while_stmt:
    WHILE LPAREN expression RPAREN block {
        printf("Parsed while-loop\n");
    }
  ;

block:
    LBRACE program RBRACE
  ;

expression:
      expression PLUS expression
    | expression MINUS expression
    | expression TIMES expression
    | expression DIVIDE expression
    | expression EQ expression
    | expression NE expression
    | expression LT expression
    | expression GT expression
    | expression LE expression
    | expression GE expression
    | LPAREN expression RPAREN
    | NUMBER
    | IDENTIFIER
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}