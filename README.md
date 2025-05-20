Welcome to ***CodeForge***, a minimal yet powerful compiler designed for a custom programming language. Built using Flex, Bison, and C.

CodeForge compiles a simplified source language and demonstrates key phases of compilation. It currently supports:

Lexical Analysis using Flex
Parsing using Bison
Semantic Analysis (type checking, symbol tables – WIP)
Intermediate & Assembly Code Generation (planned in future weeks)

The goal is to incrementally build a fully functional compiler while learning core concepts of language design and translation.


***How to Build & Run***
Prerequisites
- open your project folder in VS Code and use WSL (Ubuntu) terminal for running commands.
- Install : flex and bison

Build & Run the Lexer (only lexical analysis)
- flex lexer.l
- gcc lex.yy.c src/main_lexer.c -o lexer -lfl
- ./lexer test_input.txt

Build & Run the Parser (full syntax analysis)
- bison -d parser.y
- flex lexer.l
- gcc parser.tab.c lex.yy.c src/main.c -o compiler -lfl
- ./compiler test_input.txt