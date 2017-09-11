# Flex / Bison - Lexical / Parser analyser

#### Supports the following grammar: 
```
program     →   block

block       →   { decls stmts }

decls       →   decls decl | λ

decl        →   type id ;

type        →   int | char | bool | float

stmts       →   stmts stmt | λ

stmt        →   id = expr ;
                | if ( rel ) stmt
                | if ( rel ) stmt else stmt
                | while ( rel ) stmt
                | block
                
rel         →   expr < expr | expr <= expr | expr >= expr 
                | expr > expr | expr
                
expr        →   expr + term | expr - term | term

term        →   term * unary | term / unary | unary

unary       →   - unary | factor

factor      →   num | real
```
#### How to use:

1. make sure have GNU Bison and Flex installed.
2. \# chmod +x ./run
3. ./run