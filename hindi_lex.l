%{
#define _POSIX_C_SOURCE 200809L
#include "hindi_parser.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

"आंक"              { return TK_AANK; }
"छूटक"             { return TK_CHUTAK; }
"दिखाओ"            { return TK_SHOW; }
"जब तक"           { return TK_JYAAN; }
"करो हां"           { return TK_KARO_HAAN; }

[0-9]+\.[0-9]+      { yylval.num = atof(yytext); return NUMBER; }
[0-9]+              { yylval.num = atoi(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.str = strdup(yytext);
    return IDENTIFIER;
}

";"                 { return SEMICOLON; }
"="                 { return ASSIGN; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return MUL; }
"/"                 { return DIV; }

[ \t\r\n]+          ; // Ignore whitespace
.                   { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}