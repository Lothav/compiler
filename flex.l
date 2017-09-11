%{
#include <iostream>

using namespace std;
#define YY_DECL extern "C" int yylex()

#include "bison.tab.h"

%}

%%

\{|\}|\(|\)|\;          {
                            return yytext[0];
                        }
\*|\-|\+|\=|\/|\<|\>    {
                            return yytext[0];
                        }
if                      {
                            return IF;
                        }
else                    {
                            return ELSE;
                        }
while                   {
                            return WHILE;
                        }
int|char|bool|float     {
                            printf("type l: %s\n", strdup(yytext));
                            return TYPE;
                        }
[0-9]+\.[0-9]+          {
                            yylval.fval = atof(yytext);
                            printf("float l: %f\n", atof(yytext));
                            return FLOAT;

                        }
[0-9]+                  {
                            yylval.ival = atoi(yytext);
                            printf("int l: %d\n", atoi(yytext));
                            return INT;
                        }
true|false		        {
				        	yylval.sval = strdup(yytext);
                            printf("bool l: %s\n", strdup(yytext));
				        	return BOOL;
				        }
[a-zA-Z0-9]+            {
                            yylval.sval = strdup(yytext);
                            printf("string l: %s\n", strdup(yytext));
                            return STRING;
                        }
.                       ;

%%