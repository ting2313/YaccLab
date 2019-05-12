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
%left '='
%left ADDASGN SUBASGN MULASGN DIVASGN MODASGN
%left PRINT
%left IF ELSE FOR
%left ID SEMICOLON
%left VOID INT FLOAT STRING BOOL
%left EQ NE LT LTE ML MLE AND OR NOT
%left '+' '-'
%left '*' '/' '%'
%left LB RB LCB RCB LSB RSB COMMA
%left INC DEC


/* Token with return, which need to sepcify type */
%left <i_val> I_CONST
%left <f_val> F_CONST
%left <i_val> B_CONST
%left <string> STR_CONST

/* Nonterminal with return, which need to sepcify type */
//%type <f_val> stat value

/* Yacc will start at this nonterminal */
%start program

/* Grammar section */
%%

program
    : external_stat program
    |
;

external_stat
    : declaration SEMICOLON
    | func_def
;

func_def
    : type ID LB arguments RB compound_stat
;

arguments
    : argu COMMA arguments
    |
;

argu
    : type ID
;

compound_stat
    : LCB statments RCB
;

statments
    : stat statments
    |
;

stat
    : declaration SEMICOLON
/*    | compound_stat
    | expression_stat
    | print_func*/
;

declaration
    : type ID equal_rhs
;

equal_rhs
    :'=' value
    | ADDASGN value
    | SUBASGN value
    | MULASGN value
    | DIVASGN value
    | MODASGN value
    |
;

value
    : I_CONST postfix
    | F_CONST postfix
    | value expression
    | LB value RB
    | ID
;

postfix
    : INC
    | DEC
    |
;

expression
    : '+' value
    | '-' value
    | '*' value
    | '/' value
    | '%' value
;

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
