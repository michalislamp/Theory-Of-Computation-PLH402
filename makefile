
# Makefile for building and running the mycompiler

# File names
LEX_FILE = mylexer.l
YACC_FILE = myanalyzer.y
CGEN_FILE = helperFiles/cgen.c
EXEC = mycompiler
INPUT = example.la

# Generated files
YACC_C = myanalyzer.tab.c
YACC_H = myanalyzer.tab.h
LEX_C = lex.yy.c

# Default target: build everything
all: $(EXEC)

# Generate parser files with Bison
$(YACC_C) $(YACC_H): $(YACC_FILE)
	bison -d -v -r all $(YACC_FILE)

# Generate lexer file with Flex (depends on yacc header)
$(LEX_C): $(LEX_FILE) $(YACC_H)
	flex $(LEX_FILE)

# Compile everything
$(EXEC): $(LEX_C) $(YACC_C) $(CGEN_FILE)
	gcc -o $(EXEC) $(LEX_C) $(YACC_C) $(CGEN_FILE) -lfl

# Run compiler with input
run: $(EXEC)
	./$(EXEC) < $(INPUT)

# Clean generated files
clean:
	rm -f $(EXEC) $(LEX_C) $(YACC_C) $(YACC_H) myanalyzer.output

.PHONY: all run clean
