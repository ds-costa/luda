%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>

    #define ANSI_COLOR_RED     "\x1b[31m"
    #define ANSI_COLOR_GREEN   "\x1b[32m"
    #define ANSI_COLOR_BLUE    "\x1b[34m"
    #define ANSI_COLOR_YELLOW  "\x1b[33m"
    #define ANSI_COLOR_RESET   "\x1b[0m"

    int yylex();
    int yyparse();

    extern FILE *yyin;
    extern int yylineno;
    int erros = 0;
    int token_id = 0;
    int number_of_errors = 0;
    int current_line = 1;

    void yyerror (const char *ctx) {
        printf(ANSI_COLOR_RED"luda1.0> ERROR: "ANSI_COLOR_RESET);
        printf("on line %d: %s\n", yylineno, ctx);
        number_of_errors++;
        return;
    }

    void ll_log(char *log) {
        printf(ANSI_COLOR_GREEN"luda1.0> "ANSI_COLOR_RESET);
        printf("%s\n", log);
        return;
    }

    void ll_log_err(char *err) {
        printf(ANSI_COLOR_RED"luda1.0> ERROR: "ANSI_COLOR_RESET);
        printf("%s\n", err);
        return;
    }

    void ll_log_warn(char *warn) {
        printf(ANSI_COLOR_YELLOW"luda1.0> WARNING: "ANSI_COLOR_RESET);
        printf("%s\n", warn);
        return;
    }


    int main(int argc, char **argv) {

        FILE *source_file = fopen(argv[1], "r");
        
        if(!source_file) {
            ll_log_err("Could not open specified source file!");
            printf(ANSI_COLOR_YELLOW"Make sure the specified path is correct!\n"ANSI_COLOR_RESET);
            return -1;
        }
        
        yyin = source_file;
        
        do {
            yyparse();
        } while(!feof(yyin));

        if(number_of_errors == 0) {
            ll_log("Successfully analyzed!!!");
            return 0;
        }
        return -1;
    }
%}



%token INTEGER_CONSTANT
%token FLOAT_CONSTANT
%token STRING_CONSTANT
%token BOOL_CONSTANT

%token IDENTIFIER

%token ARITHMETIC_OPERATOR
%token LOGICAL_OPERATOR
%token RELATIONAL_OPERATOR
%token ATRIBUTION_OPERATOR
%token EOE_OPERATOR

%token IF
%token ELSE
%token ELIF
%token FOR
%token WHILE
%token DO
%token FUNC
%token RETURN
%token DATA_TYPE

%token OPEN_PARENTHESIS
%token CLOSE_PARENTHESIS
%token OPEN_BRACKETS
%token CLOSE_BRACKETS
%token OPEN_BRACES
%token CLOSE_BRACES
%token COMMA

%token _BEGIN
%token _END 

%define parse.error verbose

%start main

%%

main: _BEGIN instructions _END;

instructions: variable_declaration instructions 
	| IDENTIFIER variable_atribution EOE_OPERATOR instructions 
	| condicional instructions 
    | function_declaration instructions
    | function_call instructions
	| loop instructions 
	| %empty;

/* Variáveis: Tipos, declarações, atribuições  */
variable_value: IDENTIFIER 
    | FLOAT_CONSTANT 
    | STRING_CONSTANT
    | INTEGER_CONSTANT
    | BOOL_CONSTANT;
    
/* Definição do bloco de instructions delimitados pelas chaves */
instruction_block: OPEN_BRACES instructions CLOSE_BRACES;

/* Funções: declaração, conteúdo, parametros e chamada */
function_declaration: FUNC IDENTIFIER OPEN_PARENTHESIS function_parameter_list CLOSE_PARENTHESIS  DATA_TYPE function_instruction_block
    | FUNC IDENTIFIER OPEN_PARENTHESIS function_parameter_list CLOSE_PARENTHESIS function_instruction_block

function_instruction_block: OPEN_BRACES instructions CLOSE_BRACES
    | OPEN_BRACES instructions RETURN variable_value EOE_OPERATOR CLOSE_BRACES
    | OPEN_BRACES instructions RETURN arithmetic_expression EOE_OPERATOR CLOSE_BRACES
    | OPEN_BRACES instructions RETURN logical_expression EOE_OPERATOR CLOSE_BRACES;



function_call: IDENTIFIER OPEN_PARENTHESIS parameter_continuation CLOSE_PARENTHESIS EOE_OPERATOR

function_parameter_list: DATA_TYPE IDENTIFIER parameter_continuation
    | %empty;

parameter_continuation: 
    COMMA DATA_TYPE IDENTIFIER parameter_continuation
    | COMMA variable_value parameter_continuation
    | variable_value parameter_continuation
    | %empty;

variable_declaration: 
    DATA_TYPE IDENTIFIER EOE_OPERATOR
	| DATA_TYPE IDENTIFIER variable_atribution EOE_OPERATOR;

variable_atribution: 
    ATRIBUTION_OPERATOR arithmetic_expression 
    | ATRIBUTION_OPERATOR logical_expression 
    | ATRIBUTION_OPERATOR IDENTIFIER OPEN_PARENTHESIS parameter_continuation CLOSE_PARENTHESIS
	| ATRIBUTION_OPERATOR variable_value;   

/* Expressões aritiméticas */
arithmetic_expression: expr_1 expr_2;
expr_1: 
    OPEN_PARENTHESIS arithmetic_expression CLOSE_PARENTHESIS expr_2 
    | variable_value expr_2;
expr_2: 
    ARITHMETIC_OPERATOR expr_1 
    | %empty;


/* Expressões lógicas */
logical_expression: 
    arithmetic_expression lexpr_1
    | arithmetic_expression lexpr_2;
    
lexpr_1: 
    RELATIONAL_OPERATOR arithmetic_expression lexpr_2 
    | %empty;
lexpr_2: 
    LOGICAL_OPERATOR logical_expression 
    | %empty;


/* Condicionais */
condicional: 
    IF OPEN_PARENTHESIS logical_expression CLOSE_PARENTHESIS instruction_block cond1;
cond1: 
    ELIF OPEN_PARENTHESIS logical_expression CLOSE_PARENTHESIS instruction_block cond2
    | cond2
    | %empty;
cond2: ELSE instruction_block 
    | %empty;

/* Lações de repetição */
loop: 
    FOR OPEN_PARENTHESIS variable_declaration logical_expression EOE_OPERATOR IDENTIFIER variable_atribution CLOSE_PARENTHESIS instruction_block
    | WHILE OPEN_PARENTHESIS logical_expression CLOSE_PARENTHESIS instruction_block
    | DO instruction_block WHILE OPEN_PARENTHESIS logical_expression CLOSE_PARENTHESIS; 

%%