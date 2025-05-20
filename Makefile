# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++17 -Iinclude

# Files
LEXER = lex.yy.c
PARSER = parser.tab.c
PARSER_HEADER = parser.tab.h

# Targets
all: compiler

parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: lexer.l
	flex lexer.l

semantic.o: src/semantic.cpp include/symbol_table.hpp
	$(CXX) $(CXXFLAGS) -c src/semantic.cpp -o semantic.o

parser.o: parser.tab.c
	$(CXX) $(CXXFLAGS) -c parser.tab.c -o parser.o

lexer.o: lex.yy.c
	$(CXX) $(CXXFLAGS) -c lex.yy.c -o lexer.o

compiler: parser.o lexer.o semantic.o
	$(CXX) parser.o lexer.o semantic.o -o compiler -lfl

clean:
	rm -f *.o lex.yy.c parser.tab.* compiler
