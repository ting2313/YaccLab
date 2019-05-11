/*	Definition section */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern void yyerror(char *s);

extern int yylineno;
extern int yylex();
extern char* yytext;   // Get current token from lex
extern char buf[256];  // Get current code line from lex

/* Symbol table function - you can add new function if needed. */
int lookup_symbol();
void create_symbol();
void insert_symbol();
void dump_symbol();

%}

/* Use variable or self-defined structure to represent
 * nonterminal and token type
 */
%union {
    int i_val;
    double f_val;
    char* string;
}

/* Token without return */
%token PRINT
%token IF ELSE FOR
%token ID SEMICOLON
%token VOID INT FLOAT STRING BOOL
%token '++' '--'
%token '+' '-'
%token '*' '/' '%'
%token '='

/* Token with return, which need to sepcify type */
%token <i_val> I_CONST
%token <f_val> F_CONST
%token <i_val> B_CONST
%token <string> STR_CONST

/* Nonterminal with return, which need to sepcify type */
//%type <f_val> stat value

/* Yacc will start at this nonterminal */
%start program

/* Grammar section */
%%

program
    : stat program
    |
;

stat
    : declaration
/*    | compound_stat
    | expression_stat
    | print_func*/
;

declaration
    : type ID '=' value SEMICOLON {printf("yacc:\n");}
;

value
    : I_CONST {$1=atoi(yytext);}
    | F_CONST {$1=atof(yytext);}

/* actions can be taken when meet the token or rule */
type
    : INT
    | FLOAT
    | BOOL
    | STRING
    | VOID
;

%%

/* C code section */
int main(int argc, char** argv)
{
    yylineno = 0;

    yyparse();
	printf("\nTotal lines: %d \n",yylineno);

    return 0;
}

void yyerror(char *s)
{
    printf("\n|-----------------------------------------------|\n");
    printf("| Error found in line %d: %s\n", yylineno, buf);
    printf("| %s", s);
    printf("\n|-----------------------------------------------|\n\n");
}

void create_symbol() {}
void insert_symbol() {}
int lookup_symbol() {}
void dump_symbol() {
    printf("\n%-10s%-10s%-12s%-10s%-10s%-10s\n\n",
           "Index", "Name", "Kind", "Type", "Scope", "Attribute");
}
