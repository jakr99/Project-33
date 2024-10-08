%{
#include <iostream>
#include <iomanip>
using namespace std;

int token_count = 0; 
int no_lines = 0;    
%}

%option noyywrap

DIGIT      [0-9]
SIGN       [+-]
ALPHA      [a-zA-Z]
HEX        [A-Fa-f0-9]
BIN        [01]
KEYWORD    DEF|IF|THEN|ELSE|FI|LOOP|POOL|PRINT

%%

[ \t]                     ;  
\n                        { no_lines++; } 

{SIGN}?{DIGIT}+           { cout << token_count++ << ": TOKEN: INTCONST LEXEME: " << yytext << endl; }
{SIGN}?{DIGIT}+"."{DIGIT}+    { cout << token_count++ << ": TOKEN: DECCONST LEXEME: " << yytext << endl; }
{SIGN}?{DIGIT}+"."{DIGIT}+"E"{SIGN}?{DIGIT}+  { cout << token_count++ << ": TOKEN: SCICONST LEXEME: " << yytext << endl; }
{HEX}+H                   { cout << token_count++ << ": TOKEN: HEXCONST LEXEME: " << yytext << endl; }
{BIN}+B                   { cout << token_count++ << ": TOKEN: BINCONST LEXEME: " << yytext << endl; }
{KEYWORD}                 { cout << token_count++ << ": TOKEN: KEYWORD LEXEME: " << yytext << endl; }
\"[^\"\n]*\"              { cout << token_count++ << ": TOKEN: STRCONST LEXEME: " << yytext << endl; }
[0-9A-Fa-f]{2}X           { cout << token_count++ << ": TOKEN: CHCONST LEXEME: " << yytext << endl; }
{ALPHA}({ALPHA}|{DIGIT}|_)*    { cout << token_count++ << ": TOKEN: IDENT LEXEME: " << yytext << endl; }
[+*/<>=&-]                { cout << token_count++ << ": TOKEN: OPERATOR LEXEME: " << yytext << endl; }
%[^\n]*                   ; 

.                         { cout << token_count++ << ": TOKEN: ? LEXEME: " << yytext << endl; } 

%%

int main() {
    yylex();
    cout << no_lines << " lines processed." << endl; 
    return 0;
}
