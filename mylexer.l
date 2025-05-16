%{
#include <stdio.h>    
#include <string.h>
#include "helperFiles/cgen.h"
#include "myanalyzer.tab.h"
int line_num = 1;

 /* The program can have up to 100 macros at a time. Random number, just for memory efficiency*/
#define MAX_MACROS 100

 /* Deffinition: @defmacro key value */
char* macro_keys[MAX_MACROS];  /* stores the keys (the name of the macro) */
char* macro_values[MAX_MACROS]; /* stores the value of the macro */
int macro_count = 0;

 /* add macro(key,value) in each table */
void add_macro(char* key, char* value) {
    if (macro_count >= MAX_MACROS) return;
    macro_keys[macro_count] = strdup(key);   /* Needs free, i do it at the end of the file*/
    macro_values[macro_count] = strdup(value);
    macro_count++;
}

/* return the value of the macro given the key */
char* get_macro(char* key) {
    for (int i = macro_count - 1; i >= 0; i--) {
        if (strcmp(macro_keys[i], key) == 0) {
            return macro_values[i];
        }
    }
    return NULL;
}
%}


/*  Definitions Section */
/*   * : zero or more, */
/*   + : one or more,  */
/*   ? : zero or one   */

ID              [a-zA-Z][0-9a-zA-Z_]*
DIGIT           [0-9]
NO_ZERO_DIGIT   [1-9]
INTEGER         {DIGIT}|({NO_ZERO_DIGIT}{DIGIT}+)
FLOAT           {INTEGER}"."{DIGIT}+([eE][+-]?{INTEGER})?   


/*  The string starts and ends with " */
/*  The string can contain any character except \, ", and newline (actual new line) */
/*  The string can contain \n, \t, \r, \", and \\  (any of \a, \b etc cannot.)*/

STRING          \"([^\\\n"]|\\[ntr"\\])*\" 


/*Start conditions Declarations*/
/* %x: exclusive state. Follow only the state's rules*/
/* %s: inclusive state. Follow the state's rules and the global rules.*/

%x      inline_comment

/*  Rules Section */

%%
"integer"       { printf("Token KEYWORD_INT: %s\n", yytext); return KEYWORD_INT; }
"scalar"        { printf("Token KEYWORD_SCALAR: %s\n", yytext); return KEYWORD_SCALAR; }
"str"           { printf("Token KEYWORD_STR: %s\n", yytext); return KEYWORD_STR; }
"bool"          { printf("Token KEYWORD_BOOL: %s\n", yytext); return KEYWORD_BOOL; }
"True"          { printf("Token KEYWORD_TRUE: %s\n", yytext); return KEYWORD_TRUE; }  
"False"         { printf("Token KEYWORD_FALSE: %s\n", yytext); return KEYWORD_FALSE; }
"const"         { printf("Token KEYWORD_CONST: %s\n", yytext); return KEYWORD_CONST; }
"if"            { printf("Token KEYWORD_IF: %s\n", yytext); return KEYWORD_IF; }      
"else"          { printf("Token KEYWORD_ELSE: %s\n", yytext); return KEYWORD_ELSE; }  
"endif"         { printf("Token KEYWORD_ENDIF: %s\n", yytext); return KEYWORD_ENDIF; }
"for"           { printf("Token KEYWORD_FOR: %s\n", yytext); return KEYWORD_FOR; }
"in"            { printf("Token KEYWORD_IN: %s\n", yytext); return KEYWORD_IN; }
"endfor"        { printf("Token KEYWORD_ENDFOR: %s\n", yytext); return KEYWORD_ENDFOR; }
"while"         { printf("Token KEYWORD_WHILE: %s\n", yytext); return KEYWORD_WHILE; }
"endwhile"      { printf("Token KEYWORD_ENDWHILE: %s\n", yytext); return KEYWORD_ENDWHILE; }
"break"         { printf("Token KEYWORD_BREAK: %s\n", yytext); return KEYWORD_BREAK; }    
"continue"      { printf("Token KEYWORD_CONTINUE: %s\n", yytext); return KEYWORD_CONTINUE; }  
"not"           { printf("Token KEYWORD_NOT: %s\n", yytext); return KEYWORD_NOT; }
"and"           { printf("Token KEYWORD_AND: %s\n", yytext); return KEYWORD_AND; }  
"or"            { printf("Token KEYWORD_OR: %s\n", yytext); return KEYWORD_OR; }
"def"           { printf("Token KEYWORD_DEF: %s\n", yytext); return KEYWORD_DEF; }
"enddef"        { printf("Token KEYWORD_ENDDEF: %s\n", yytext); return KEYWORD_ENDDEF; }
"main"          { printf("Token KEYWORD_MAIN: %s\n", yytext); return KEYWORD_MAIN; }
"return"        { printf("Token KEYWORD_RETURN: %s\n", yytext); return KEYWORD_RETURN; }
"comp"          { printf("Token KEYWORD_COMP: %s\n", yytext); return KEYWORD_COMP; }  
"endcomp"       { printf("Token KEYWORD_ENDCOMP: %s\n", yytext); return KEYWORD_ENDCOMP; } 
"of"            { printf("Token KEYWORD_OF: %s\n", yytext); return KEYWORD_OF; }           


"+"         { printf("Token PLUS_OP: %s\n", yytext); return PLUS_OP; }
"-"         { printf("Token MINUS_OP: %s\n", yytext); return MINUS_OP; }
"*"         { printf("Token MULT_OP: %s\n", yytext); return MULT_OP; }
"/"         { printf("Token DIV_OP: %s\n", yytext); return DIV_OP; }
"%"         { printf("Token MOD_OP: %s\n", yytext); return MOD_OP; }
"**"        { printf("Token POWER_OP: %s\n", yytext); return POWER_OP; }
"=="        { printf("Token EQUAL_OP: %s\n", yytext); return EQUAL_OP; }
"!="        { printf("Token NOT_EQUALS_OP: %s\n", yytext); return NEQ_OP; }
"<"         { printf("Token LESS_OP: %s\n", yytext); return LESS_OP; }
"<="        { printf("Token LESS_EQ_OP: %s\n", yytext); return LEQ_OP; }
">"         { printf("Token GREATER_OP: %s\n", yytext); return GREATER_OP; }
">="        { printf("Token GREATER_EQ_OP: %s\n", yytext); return GEQ_OP; }

"="         { printf("Token ASSIGN_OP: %s\n", yytext); return ASSIGN_OP; }
"+="        { printf("Token PLUS_ASSIGN_OP: %s\n", yytext); return PLUS_ASSIGN_OP; }
"-="        { printf("Token MINUS_ASSIGN_OP: %s\n", yytext); return MINUS_ASSIGN_OP; }
"*="        { printf("Token MULT_ASSIGN_OP: %s\n", yytext); return MULT_ASSIGN_OP; }
"/="        { printf("Token DIV_ASSIGN_OP: %s\n", yytext); return DIV_ASSIGN_OP; }
"%="        { printf("Token MOD_ASSIGN_OP: %s\n", yytext); return MOD_ASSIGN_OP; }
":="        { printf("Token COLON_ASSIGN_OP: %s\n", yytext); return COLON_ASSIGN_OP; }

";"         { printf("Token SEMICOLON: %s\n", yytext); return SEMICOLON; } 
"("         { printf("Token L_PARENTHESIS: %s\n", yytext); return L_PAREN; }
")"         { printf("Token R_PARENTHESIS: %s\n", yytext); return R_PAREN; }
","         { printf("Token COMMA: %s\n", yytext); return COMMA; }
"["         { printf("Token L_BRACKET: %s\n", yytext); return L_BRACKET; }
"]"         { printf("Token R_BRACKET: %s\n", yytext); return R_BRACKET; }
"{"         { printf("Token L_CURLY_BRACKET: %s\n", yytext); return L_CURLY_BRACKET; }
"}"         { printf("Token R_CURLY_BRACKET: %s\n", yytext); return R_CURLY_BRACKET; }
":"         { printf("Token COLON: %s\n", yytext); return COLON; }
"."         { printf("Token DOT: %s\n", yytext); return DOT; }

"#"         { printf("Token HASH: %s\n", yytext); return HASH; }
"->"        { printf("Token ARROW: %s\n", yytext); return ARROW; } 

"readStr"      { printf("Token F_READSTR: %s\n", yytext); return F_READSTR; }
"readInteger"  { printf("Token F_READINT: %s\n", yytext); return F_READINT; }
"readScalar"   { printf("Token F_READSC: %s\n", yytext); return F_READSC; }
"writeStr"     { printf("Token F_WRITESTR: %s\n", yytext); return F_WRITESTR; }
"writeInteger" { printf("Token F_WRITEINT: %s\n", yytext); return F_WRITEINT; }
"writeScalar"  { printf("Token F_WRITESC: %s\n", yytext); return F_WRITESC; }
"write"        { printf("Token F_WRITE: %s\n", yytext); return F_WRITE; }

 /* if you see @defmacro then spaces or tabs, then an identifier and then anything else until the end of the line.*/
@defmacro[ \t]+{ID}[^\n]* {
    char key[128];
    char* value;
    
 /* first scan the name of the macro and store it in key variable*/
    sscanf(yytext, "@defmacro %s", key);
    
 /*yytext: a flex pointer of the current token */
 /*strstr(): finds when key first appears in yytext string and returns the pointer in start */
    char* start = strstr(yytext, key);
    if (start) {
        start += strlen(key); /* increase pointer start as the length of the key (sos as to go to the end of it) */
        while (*start == ' ' || *start == '\t') start++; /* there are any spaces or tabs just ignore and increase pointer */
        value = strdup(start); /* stores the (rest) value of start into a new variable value */
        add_macro(key, value); /* push into macro */
        free(value);           /* free the memory (necessary because strdup cointains a malloc) */
    }
}

 /* if you see an IDENTIFIER, first check if there is a macor with this name */
{ID} {
    char* replacement = get_macro(yytext);
    if (replacement) {
        for (int i = strlen(replacement) - 1; i >= 0; i--) {
            unput(replacement[i]);   /* push the string in the input streat so as lexer to read it. Do it in reverser order  */
        }                            /* because the unput putes the lest char in the first postition                         */
    } else {                         /* e.g unput("i") => i , unput("h") => hi. The lexer reads hi                           */
       { printf("Token IDENTIFIER: %s\n", yytext); yylval.str = strdup(yytext); return IDENTIFIER; } /* if not, just print the IDENTIFIER. */
    }
}

 /* With strdub, saves the valye of the variable, so as parser to be able to take it. */
{STRING}    { printf("Token STRING: %s\n", yytext); yylval.str = strdup(yytext); return STRING; }
{INTEGER}   { printf("Token INTEGER: %s\n", yytext); yylval.str = strdup(yytext); return INTEGER; }
{FLOAT}     { printf("Token FLOAT: %s\n", yytext); yylval.str = strdup(yytext); return FLOAT; }

 /* Skip Space, tabs, or carriage returns */
[ \t\r]+                

 /*Skip line feed, but increase counter*/
\n 			{++line_num;}

 /*Unrecognized chars*/
.           { printf("Unrecognized token %s in line %d\n", yytext, line_num); exit(1); }


 /*  For Inline comments, ignore anything that's not a \n */
"--"						BEGIN(inline_comment);
<inline_comment>[^\n]*      
<inline_comment>\n          {++line_num; BEGIN(INITIAL);}

<<EOF>>      { return EOF; }
%%

 /* free the memory for macro_keys and macro_values (necessary because strdup cointains a malloc) */
void free_macros() {
    for (int i = 0; i < macro_count; i++) {
        free(macro_keys[i]);
        free(macro_values[i]);
    }
    macro_count = 0;
}
 /*
int main() {
    yylex();             
    free_macros();       
    return 0;
}
    */