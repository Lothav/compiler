%{
#include <cstdio>
#include <iostream>

using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void yyerror(const char *s);
%}

%union {
	int ival;
	float fval;
	char *sval;
	char *bval;
	char *tval;
    char *typeval;
}

%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING
%token <bval> BOOL
%token <typeval> TYPE
%token IF
%token ELSE
%token WHILE

%%

program:
    %empty
    | program block
    ;

block:
    '{' decls stmts '}'
    ;

decls:
    decls decl
    | %empty
    ;

decl:
    TYPE STRING ';'
    ;

stmts:
    stmts stmt
    | %empty
    ;

stmt:
    STRING '=' expr ';'
    | IF '(' rel ')' stmt
    | IF '(' rel ')' stmt ELSE stmt
    | WHILE '(' rel ')' stmt
    | block
    ;

rel:
    expr '<' expr
    | expr '<' '=' expr
    | expr '>' '=' expr
    | expr '>' expr
    | expr
    ;

expr:
    expr '+' term
    | expr '-' term
    | term
    ;

term:
    term '*' unary
    | term '/' unary
    | unary
    ;

unary:
    '-' unary
    | factor
    ;

factor:
    INT
    | FLOAT
    ;

%%

int main(int, char**) {
	FILE *myfile = fopen("./tests/test1", "r");
	if (!myfile) {
		cout << "I can't open ./tests/test1!" << endl;
		return -1;
	}
	yyin = myfile;

	do {
		yyparse();
	} while (!feof(yyin));

}

void yyerror(const char *s) {
	cout << "EEK, parse error!  Message: " << s << endl;
	exit(-1);
}