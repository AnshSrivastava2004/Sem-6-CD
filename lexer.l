%{
    #include "parser.tab.h"
    #include <stdio.h>
    #include <string.h>
    int line = 1;
%}

DIGIT      [0-9]
ID         [a-zA-Z_][a-zA-Z0-9_]*
FLOAT      {DIGIT}+"."{DIGIT}*
STRING     \"([^\"\n]*)\"

%%
[\n]            { line++; }

"package"       { printf("PACKAGE\n"); return PACKAGE; }
"main"          { printf("MAIN\n"); return MAIN; }
"func"          { printf("FUNC\n"); return FUNC; }
"var"           { printf("VAR\n"); return VAR; }
"int"           { printf("INT\n"); return INT; }
"float64"       { printf("FLOAT64\n"); return FLOAT64; }
"string"        { printf("STRING_TYPE\n"); return STRING_TYPE; }
"if"            { printf("IF\n"); return IF; }
"else"          { printf("ELSE\n"); return ELSE; }
"for"           { printf("FOR\n"); return FOR; }
"print"         { printf("PRINT\n"); return PRINT; }

{FLOAT}         { printf("FLOAT_LITERAL: %s\n", yytext); yylval.fval = atof(yytext); return FLOAT_LITERAL; }
{DIGIT}+        { printf("INT_LITERAL: %s\n", yytext); yylval.ival = atoi(yytext); return INT_LITERAL; }
{STRING}        { printf("STRING_LITERAL: %s\n", yytext); yylval.sval = strdup(yytext); return STRING_LITERAL; }
{ID}            { printf("IDENT: %s\n", yytext); yylval.sval = strdup(yytext); return IDENT; }

">="            { printf("GE\n"); return GE; }
"<="            { printf("LE\n"); return LE; }
"=="            { printf("EQ\n"); return EQ; }
"!="            { printf("NE\n"); return NE; }
">"             { printf("GT\n"); return GT; }
"<"             { printf("LT\n"); return LT; }

"="             { printf("ASSIGN\n"); return ASSIGN; }
"+"             { printf("PLUS\n"); return PLUS; }
"-"             { printf("MINUS\n"); return MINUS; }
"*"             { printf("MUL\n"); return MUL; }
"/"             { printf("DIV\n"); return DIV; }

"("             { printf("LPAREN\n"); return LPAREN; }
")"             { printf("RPAREN\n"); return RPAREN; }
"{"             { printf("LBRACE\n"); return LBRACE; }
"}"             { printf("RBRACE\n"); return RBRACE; }
";"             { printf("SEMI\n"); return SEMI; }

[ \t\r]+      ; // Ignore whitespace
.               { printf("UNKNOWN: %s\n", yytext); return *yytext; } // Catch others

%%
int yywrap() { return 1; }
