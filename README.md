Welcome to ***CodeForge***, a minimal yet powerful compiler designed for a custom programming language. Built using Flex, Bison, and C.

CodeForge compiles a simplified source language and demonstrates key phases of compilation. It currently supports:

Lexical Analysis using Flex
Parsing using Bison
Semantic Analysis (type checking, symbol tables – WIP)
Intermediate & Assembly Code Generation (planned in future weeks)

The goal is to incrementally build a fully functional compiler while learning core concepts of language design and translation.


***How to Build & Run***
<h3> Prerequisites </h3>
<br>
- open your project folder in VS Code and use WSL (Ubuntu) terminal for running commands.
- Install : flex and bison

<h3?>Build & Run the Lexer (only lexical analysis) </h3>
<br> 
- flex lexer.l
- gcc lex.yy.c src/main_lexer.c -o lexer -lfl
- ./lexer test_input.txt

<h3?> Build & Run the Parser (full syntax analysis) </h3>
<br>
- bison -d parser.y
- flex lexer.l
- gcc parser.tab.c lex.yy.c src/main.c -o compiler -lfl
- ./compiler test_input.txt


<h3> Contributing <h3> 
<br>
contributions are welcome! To contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature-branch-name).
3. Make your changes.
4. Commit your changes (git commit -m 'Add some feature').
5. Push to the branch (git push origin feature-branch-name).
7. Open a Pull Request.

For major changes, please open an issue first to discuss what you would like to change.