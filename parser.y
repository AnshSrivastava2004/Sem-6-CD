%{
    #include <stdio.h>
    #include <stdlib.h>

    extern int line;
    void yyerror(const char *s) {
        extern char *yytext;
        fprintf(stderr, "Syntax error on line %d near '%s': %s\n", line, yytext, s);
        exit(0);
    }
    int yylex();
%}

%union {
    int ival;
    float fval;
    char* sval;
}

%token PACKAGE MAIN FUNC VAR INT FLOAT64 STRING_TYPE IF ELSE FOR PRINT
%token INT_LITERAL FLOAT_LITERAL STRING_LITERAL
%token IDENT
%token ASSIGN PLUS MINUS MUL DIV GT LT GE LE NE EQ
%token LPAREN RPAREN LBRACE RBRACE SEMI

%type <sval> IDENT
%type <ival> INT_LITERAL
%type <fval> FLOAT_LITERAL
%type <sval> STRING_LITERAL

%%

program:
    PACKAGE MAIN func_decl
    ;

func_decl:
    FUNC MAIN LPAREN RPAREN block
    ;

block:
    LBRACE stmt_list RBRACE
    ;

stmt_list:
    stmt_list stmt
    | /* empty */
    ;

stmt:
    var_decl SEMI
    | assign SEMI
    | print_stmt SEMI
    | if_stmt
    | for_stmt
    ;

var_decl:
    VAR IDENT type ASSIGN expr
    ;

type:
    INT | FLOAT64 | STRING_TYPE
    ;

assign:
    IDENT ASSIGN expr
    ;

print_stmt:
    PRINT LPAREN expr RPAREN
    ;

if_stmt:
    IF expr block else_part
    ;

else_part:
    ELSE block
    | /* empty */
    ;

for_stmt:
    FOR expr block
    ;

expr:
    expr PLUS term
    | expr MINUS term
    | expr GT term
    | expr LT term
    | expr GE term
    | expr LE term
    | expr EQ term
    | expr NE term
    | term
    ;

term:
    term MUL factor
    | term DIV factor
    | factor
    ;

factor:
    LPAREN expr RPAREN
    | INT_LITERAL
    | FLOAT_LITERAL
    | STRING_LITERAL
    | IDENT
    ;

%%

int main() {
    yyparse();
    printf("Successfully parsed!\n");
    return 0;
}