# Unix commands
RM=rm

# Gcc compiler data
CC=gcc

# Lex data
LEX=flex
LEXER_SRC=.
LEXER_BIN=ludalexer

.PHONY: all clean

all:
	bison -d parser.y
	$(LEX) -o lex.yy.c lexer.l
	$(CC) lex.yy.c parser.tab.c -ll -o luda

clean:
	$(RM) lex.yy.c luda parser.tab.c parser.tab.h