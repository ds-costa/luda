%{
    #include <stdio.h>
    #include "parser.tab.h"
    extern int token_id;
    extern int current_line;
    extern int number_of_errors;



    #define ANSI_COLOR_RED     "\x1b[31m"
    #define ANSI_COLOR_BLUE    "\x1b[34m"
    #define ANSI_COLOR_GREEN   "\x1b[32m"
    #define ANSI_COLOR_YELLOW  "\x1b[33m"
    #define ANSI_COLOR_RESET   "\x1b[0m"

    void ll_log_tokendata(int token_id, int current_line, char *type, char *value) {
        printf(ANSI_COLOR_GREEN "ll> " ANSI_COLOR_RESET);
        printf("TOKEN_ID: %d, LINE: %d, TOKEN TYPE: %s, VALUE: %s\n", token_id, current_line, type, value);
    }

    void ll_log_error(int token_id, int current_line, char *type, char *value) {
        printf(ANSI_COLOR_RED "ll> " ANSI_COLOR_RESET);
        printf("TOKEN_ID: %d, LINE: %d, TOKEN TYPE: %s, VALUE: %s\n", token_id, current_line, type, value);

    }


%}

%option yylineno


_BEGIN "@procedure_begin"
_END "@procedure_end"

INTEGER_CONSTANT  [-]?[0-9]
FLOAT_CONSTANT [-]?([0-9]*[.])?[0-9]+
STRING_CONSTANT ((\"{1})([^\"]+)(\"{1}))
BOOL_CONSTANT "true"|"false"
CHAR [a-zA-Z]
WHITE_SPACE " "|"\t"


IDENTIFIER [_a-zA-Z_][a-zA-Z0-9_]*{0,30}
 
ARITHMETIC_OPERATOR  "+"|"-"|"*"|"/"|"**"|"%"
LOGICAL_OPERATOR  "||"|"&&"|"!"|"^"
RELATIONAL_OPERATOR ">"|"<"|"=="|">="|"<="|"!="  
ATRIBUTION_OPERATOR "="
INCREMENT_OPERATOR "++"
DECREMENT_OPERATOR "--"
COMMA ","
EOE_OPERATOR ";"

IF "if"
ELIF "elif"
ELSE "else"
WHILE "while"
DO "do"
FOR "for"
RETURN "return"
DATA_TYPE "int"|"float"|"char"|"string"|"bool"
FUNC "func"
MAIN "main"


OPEN_PARENTHESIS "("
CLOSE_PARENTHESIS ")"
OPEN_BRACKETS "["
CLOSE_BRACKETS "]"
OPEN_BRACES "{"
CLOSE_BRACES "}"

%%

{WHITE_SPACE}

{_BEGIN} {return (_BEGIN);}
{_END} {return (_END);}


{IF} { return (IF); } 
{ELIF} { return (ELIF); } 
{ELSE} { return (ELSE); } 
{WHILE} { return (WHILE); } 
{DO} { return  (DO); }
{FOR} { return (FOR); } 

{FUNC} { return (FUNC); }
{RETURN} { return (RETURN); } 

{DATA_TYPE} { return (DATA_TYPE); } 
{INTEGER_CONSTANT} { return (INTEGER_CONSTANT); }
{FLOAT_CONSTANT} { return (FLOAT_CONSTANT); }
{STRING_CONSTANT} { return (STRING_CONSTANT); }
{BOOL_CONSTANT} { return (BOOL_CONSTANT); }


{IDENTIFIER} { return (IDENTIFIER); }
{ATRIBUTION_OPERATOR} { return (ATRIBUTION_OPERATOR); }

{LOGICAL_OPERATOR} { return (LOGICAL_OPERATOR); }
{RELATIONAL_OPERATOR} { return (RELATIONAL_OPERATOR); }

{ARITHMETIC_OPERATOR} { return (ARITHMETIC_OPERATOR); }

{COMMA} { return (COMMA); }
{EOE_OPERATOR} { return (EOE_OPERATOR); }

{OPEN_PARENTHESIS} { return (OPEN_PARENTHESIS); } 
{CLOSE_PARENTHESIS} { return (CLOSE_PARENTHESIS); } 
{OPEN_BRACKETS} { return (OPEN_BRACKETS); } 
{CLOSE_BRACKETS} { return (CLOSE_BRACKETS); } 
{OPEN_BRACES} { return (OPEN_BRACES); } 
{CLOSE_BRACES} { return (CLOSE_BRACES); } 


"//".*$ {}
\n { }
. { }

%%

int yywrap() {
    return 1;
}