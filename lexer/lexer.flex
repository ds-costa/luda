%{
    int token_id = 0;
    int current_line = 0;
    int number_of_errors = 0;
%}

%%

%%

int yywrap() {
    return 1;
}

void main () {
    printf("\nLUDA LEXER v1.0.0>\n---\n");
    yylex();
    printf("---\n\n");
    if(number_of_errors == 0) {
        printf("LUDA LEXER v1.0.0> Sucesessfully analysed!\n");
    }    
    printf("LUDA LEXER v1.0.0>: %d errors\n\n", number_of_errors);
}