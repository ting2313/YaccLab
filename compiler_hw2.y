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
int max_scope;

/* Symbol table function - you can add new function if needed. */
int lookup_symbol();
void create_symbol();
void insert_symbol();
void dump_symbol();
void test();

struct row{
    char name[10];
    char entry_type[12]; //fuction, parameter and variable
    char data_type[10]; // a type(int,float,bool,string and void)
    int scope;
    char argu_type[32];
    struct row* next;
};
typedef struct row* rowptr;
rowptr head,tail,new_func,new_argu;

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
%left '=' RETURN
%left ADDASGN SUBASGN MULASGN DIVASGN MODASGN
%left PRINT
%left IF ELSE FOR WHILE T F
%left SEMICOLON
%left EQ NE LT LTE ML MLE AND OR NOT
%left '+' '-'
%left '*' '/' '%'
%left LB RB LCB RCB LSB RSB COMMA
%left INC DEC


/* Token with return, which need to sepcify type */
%left <i_val> I_CONST
%left <f_val> F_CONST
%left <i_val> B_CONST
%left <string> STR_CONST ID VOID INT FLOAT STRING BOOL

/* Nonterminal with return, which need to sepcify type */
%type <string> type compound_stat

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
    : type ID LB arguments RB compound_stat{
        sprintf(new_func->data_type, "%s", $1);
        sprintf(new_func->entry_type, "function");
        sprintf(new_func->name, "%s", $2);
        new_func->scope = 0;
        insert_symbol(new_func);
        if(strcmp($6,"def"))    dump_symbol();
    }
;

arguments
    : type ID arguments{
        if(!strcmp(new_func->argu_type,"")){
            printf("------>1:%s\n",new_func->argu_type);
            sprintf(new_func->argu_type, "%s", $1);
        }else{
            printf("------>2:%s\n",new_func->argu_type);
            char temp[32] = {};
            strcpy(temp, new_func->argu_type);
            sprintf(new_func->argu_type, "%s%s", $1, temp);
        }
    }
    | COMMA type ID arguments{
        if(!strcmp(new_func->argu_type,"")){
            printf("------>3:%s\n",new_func->argu_type);
            sprintf(new_func->argu_type, ", %s", $2);
        }else{
            printf("------>4:%s\n",new_func->argu_type);
            char temp[32] = {};
            strcpy(temp, new_func->argu_type);
            sprintf(new_func->argu_type, ", %s%s", $2, temp);
        }
    }
    |   {
        bzero(new_func->argu_type, sizeof(new_func->argu_type));
        printf("------>5:\n");
        break;
    }
;

compound_stat
    : LCB statments end_stat RCB {

    }
    | SEMICOLON {
        $$ = "def";
    }
;

end_stat
    : RETURN value SEMICOLON
    |
;

statments
    : stat statments
    |
;

stat
    : declaration SEMICOLON
    | ID equal_rhs SEMICOLON
    | WHILE LB condition RB compound_stat{

    }
    | IF LB condition RB compound_stat else_scope
    | PRINT LB print_word RB SEMICOLON
    | value postfix SEMICOLON
;

else_scope
    : ELSE compound_stat
    |
;

print_word
    : ID
    | STR_CONST
;

condition
    : value
    |
;

comparison
    : EQ value
    | ML value
    | LT value
    | MLE value
    | LTE value
    | NE value
;

declaration
    : type ID equal_rhs{
        sprintf(new_argu->name,"%s", $2);
        sprintf(new_argu->data_type, "%s", $1);
    }
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
    : I_CONST
    | F_CONST
    | value after_value
    | LB value RB
    | ID function_call
    | T
    | F
;

function_call
    : LB arguments RB
    | //for ID
;

after_value
    : expression
    | comparison
;

postfix
    : INC
    | DEC
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
    create_symbol();
    yyparse();
	printf("\nTotal lines: %d \n",yylineno);
    free(new_func);
    free(new_argu);

    return 0;
}

void test(){
    printf("Testing table.\n");

    sprintf(new_func->data_type, "%s", "int");
    sprintf(new_func->entry_type, "function");
    sprintf(new_func->name, "%s", "testing");
    sprintf(new_func->argu_type, "%s", "int, int");
    new_func->scope = 0;
    insert_symbol(new_func);
    sprintf(new_func->data_type, "%s", "int");
    sprintf(new_func->entry_type, "function");
    sprintf(new_func->name, "%s", "testing2");
    sprintf(new_func->argu_type, "%s", "int, int");
    new_func->scope = 0;
    insert_symbol(new_func);

    sprintf(new_func->data_type, "%s", "int");
    sprintf(new_func->entry_type, "function");
    sprintf(new_func->name, "%s", "testing3");
    sprintf(new_func->argu_type, "%s", "int, int");
    max_scope = 1;
    insert_symbol(new_func);


    sprintf(new_func->data_type, "%s", "int");
    sprintf(new_func->entry_type, "function");
    sprintf(new_func->name, "%s", "testing4");
    sprintf(new_func->argu_type, "%s", "int, int");
    max_scope = 1;
    insert_symbol(new_func);

    dump_symbol();
    dump_symbol();
}

void yyerror(char *s)
{
    printf("\n|-----------------------------------------------|\n");
    printf("| Error found in line %d: %s\n", yylineno, buf);
    printf("| %s", s);
    printf("\n|-----------------------------------------------|\n\n");
}

void create_symbol() {
    new_func = malloc(sizeof(struct row));
    new_argu = malloc(sizeof(struct row));
    head = tail = NULL;
    max_scope = 0;
}

void insert_symbol(rowptr new){
    rowptr add = malloc(sizeof(struct row)); //the memory address of new
    sprintf(add->name,"%s",new->name);
    sprintf(add->entry_type,"%s",new->entry_type);
    sprintf(add->data_type,"%s",new->data_type);
    sprintf(add->argu_type,"%s",new->argu_type);
    add->scope = new->scope;
    add->next = NULL;
    if(head==NULL){
        head = tail = add;
    }else{
        tail->next = add;
        tail = add;
    }
    bzero(new, sizeof(new));
}

int lookup_symbol(char* name) {

}

void dump_symbol() {
    if(head==NULL) {
        //printf("Table is empty.\n");
        return;  //no need to dump
    }
    else if(head->scope != max_scope){
        //printf("The scope %d is empty.\n",max_scope);
        max_scope--;
        return;
    }

    printf("\n\n%-10s%-10s%-12s%-10s%-10s%-10s\n\n",
        "Index", "Name", "Kind", "Type", "Scope", "Attribute");
    rowptr print = head;
    int index = 1;
    /*find the row of the biggest scope*/
    while(print->scope==max_scope){
        printf("%-10d%-10s%-12s%-10s%-10d%-10s\n",
            index, print->name, print->entry_type,\
            print->data_type, print->scope, print->argu_type);
        print = print->next;
        free(head);
        head = print;
        index++;
        if(print==NULL) break;
    }

    if(max_scope>0) max_scope--;
}

void dump_symbol_() {
    printf("\n\n%-10s%-10s%-12s%-10s%-10s%-10s\n\n",
        "Index", "Name", "Kind", "Type", "Scope", "Attribute");
    rowptr print = head;
    rowptr preptr = head;
    if(head==NULL) return;

    /*find the row of the biggest scope*/
    while(print->scope!=max_scope){
//    printf("scope:%d,max:%d\n",print->scope, max_scope);
        if(preptr!=print){
            preptr = preptr->next;
        }
        print = print->next;
    }

    /*print and dump*/
    int index = 1;
    tail = preptr;
    if(print==head){
        head = tail = NULL;     //dump all Symbol
    }else{
        tail->next = NULL;
    }
    preptr = print;
    while(print!=NULL){
        printf("%-10d%-10s%-12s%-10s%-10d%-10s\n",
            index, print->name, print->entry_type,\
            print->data_type, print->scope, print->argu_type);
        print = print->next;
        free(preptr);
        preptr = print;
        index++;
    }
    if(max_scope>0) max_scope--;
}
