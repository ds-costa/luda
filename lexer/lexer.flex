%{
    int token_id = 0;
    int current_line = 1;
    int number_of_errors = 0;

    void ll_log_tokendata(int token_id, int current_line, char *type, char *value) {
        printf("ll> TOKEN_ID: %d, LINE: %d, TOKEN TYPE: %s, VALUE: %s\n", token_id, current_line, type, value);
    }

    void ll_log(char *log) {
        printf("ll> %s\n", log);
    }
%}

INTEGER_NUMBER  [-]?[0-9]
FLOAT_NUMBER [-]?([0-9]*[.])?[0-9]+
STRING_CONSTANT ((\"{1})([^\"]+)(\"{1}))

LETTER [a-zA-Z]
WHITE_SPACE " "|"\t"


IDENTIFIER [_a-zA-Z_][a-zA-Z0-9_]*{0,30}
 
ARITHMETIC_OPERATOR  "+"|"-"|"*"|"/"|"**"|"%"
LOGICAL_OPERATOR  "||"|"&&"|"!"|"^"
RELATIONAL_OPERATOR ">"|"<"|"=="|">="|"<="|"!="  
ATRIBUTION_OPERATOR "="
INCREMENT_OPERATOR "++"
DECREMENT_OPERATOR "--"
EOE_OPERATOR ";"

%%

{WHITE_SPACE}

{IDENTIFIER} {
    ll_log_tokendata(token_id, current_line, "IDENTIFIER", yytext);
    token_id++;
}

{INTEGER_NUMBER} {
    ll_log_tokendata(token_id, current_line, "INTEGER_NUMBER", yytext);
    token_id++;
}

{FLOAT_NUMBER} {
    ll_log_tokendata(token_id, current_line, "FLOAT_NUMBER", yytext);
    token_id++;
}

{STRING_CONSTANT} {
    ll_log_tokendata(token_id, current_line, "STRING_CONSTANT", yytext);
    token_id++;
}

{ARITHMETIC_OPERATOR} {
    ll_log_tokendata(token_id, current_line, "ARITHMETIC_OPERATOR", yytext);
    token_id++;
}

{LOGICAL_OPERATOR} {
    ll_log_tokendata(token_id, current_line, "LOGICAL_OPERATOR", yytext);
    token_id++;
}

{RELATIONAL_OPERATOR} {
    ll_log_tokendata(token_id, current_line, "RELATIONAL_OPERATOR", yytext);
    token_id++;
}

{ATRIBUTION_OPERATOR} {
    ll_log_tokendata(token_id, current_line, "ATRIBUTION_OPERATOR", yytext);
    token_id++;
}

{INCREMENT_OPERATOR} {
    ll_log_tokendata(token_id, current_line, "INCREMENT_OPERATOR", yytext);
    token_id++;
}

{EOE_OPERATOR} {
    ll_log_tokendata(token_id, current_line, "END_OF_EXPRESSION", yytext);
    token_id++;
}

\n {
    current_line++;
}

. {
    printf("ll> TOKEN_ID: N/A, LINE: %d, TOKEN TYPE: N/A, VALUE: %s\n", current_line, yytext);
    number_of_errors++;
}

%%

int yywrap() {
    return 1;
}

void main () {
    printf("\nLUDA LEXER v1.0.0\n");
    yylex();
    printf("---\n\n");
    if(number_of_errors == 0) {
        ll_log("Sucesessfully analysed!");
    }    
    printf("ll>: %d error(s)\n\n", number_of_errors);
}