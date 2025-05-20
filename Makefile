# Compiler and tools
CC = gcc
FLEX = flex
BISON = bison

# Flags (added -Wno-unused-function)
CFLAGS = -Wall -g -Wno-unused-function
LDFLAGS = -lfl

# Files
LEXER = lexer.l
PARSER = parser.y

LEXER_C = lex.yy.c
PARSER_C = parser.tab.c
PARSER_H = parser.tab.h

MAIN_LEXER = src/main_lexer.c
MAIN_PARSER = src/main.c

all: lexer compiler

lexer: $(LEXER_C) $(MAIN_LEXER)
	$(CC) $(CFLAGS) lex.yy.c $(MAIN_LEXER) -o lexer $(LDFLAGS)

compiler: $(PARSER_C) $(PARSER_H) $(LEXER_C) $(MAIN_PARSER)
	$(CC) $(CFLAGS) parser.tab.c lex.yy.c $(MAIN_PARSER) -o compiler $(LDFLAGS)

$(PARSER_C) $(PARSER_H): $(PARSER)
	$(BISON) -d $(PARSER)

$(LEXER_C): $(LEXER)
	$(FLEX) $(LEXER)

clean:
	rm -f lexer compiler lex.yy.c parser.tab.c parser.tab.h

.PHONY: all clean lexer compiler
