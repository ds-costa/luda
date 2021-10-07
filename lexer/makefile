# Unix commands
RM=rm

# Gcc compiler data
CC=gcc

# Lex data
LEX=flex
LEXER_SRC=lexer
LEXER_BIN=ludalexer

# User data
INPUT_FILE=$(input)

.PHONY: all clean

all:
	$(LEX) -o $(LEXER_SRC)/lex.yy.c $(LEXER_SRC)/lexer.flex
	$(CC) $(LEXER_SRC)/lex.yy.c -o $(LEXER_SRC)/$(LEXER_BIN)
	$(LEXER_SRC)/$(LEXER_BIN) < $(INPUT_FILE)

clean:
	$(RM) $(LEXER_SRC)/lex.yy.c $(LEXER_SRC)/$(LEXER_BIN)