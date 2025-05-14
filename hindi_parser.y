%{
#define _POSIX_C_SOURCE 200809L
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

int temp_count = 1;

typedef struct {
    char name[100];
    double value;
    int is_float; // 1 = float, 0 = int
} Variable;

Variable vars[100];
int var_count = 0;

int find_var(const char *name) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(vars[i].name, name) == 0)
            return i;
    }
    return -1;
}

void add_var(const char *name, int is_float) {
    strcpy(vars[var_count].name, name);
    vars[var_count].value = is_float ? 0.0 : 0;
    vars[var_count].is_float = is_float;
    var_count++;
}

void assign(const char *name, double value, int is_float) {
    int idx = find_var(name);
    if (idx == -1) {
        fprintf(stderr, "Error: Variable %s not declared\n", name);
        return;
    }

    if (is_float && !vars[idx].is_float) {
        fprintf(stderr, "Warning: Assigning float to int %s, truncating\n", name);
        vars[idx].value = (int)value;
    } else {
        vars[idx].value = value;
    }

    printf("%s = %.2f\n", name, vars[idx].value);
}

void print_var(const char *name) {
    int idx = find_var(name);
    if (idx == -1) {
        fprintf(stderr, "Error: Variable %s not declared\n", name);
        return;
    }
    printf("PRINT %s = %.2f\n", name, vars[idx].value);
}
%}

%union {
    char *str;
    double num;
    struct {
        double val;
        int is_float;
    } expr;
}

%token <str> IDENTIFIER
%token <num> NUMBER
%token TK_SHOW TK_AANK TK_CHUTAK
%token ASSIGN SEMICOLON
%token PLUS MINUS MUL DIV
%token TK_JYAAN TK_KARO_HAAN

%type <expr> expression

%left PLUS MINUS
%left MUL DIV

%%

program:
    program statement
    | statement
    ;

statement:
    TK_AANK IDENTIFIER SEMICOLON {
        add_var($2, 0);
        free($2);
    }
    | TK_CHUTAK IDENTIFIER SEMICOLON {
        add_var($2, 1);
        free($2);
    }
    | IDENTIFIER ASSIGN expression SEMICOLON {
        assign($1, $3.val, $3.is_float);
        free($1);
    }
    | TK_JYAAN expression TK_KARO_HAAN statement {
        while ($2.val != 0) {
            yyparse(); // Loop body
        }
    }
    | TK_SHOW IDENTIFIER SEMICOLON {
        print_var($2);
        free($2);
    }
    ;

expression:
    NUMBER {
        $$.val = $1;
        $$.is_float = 0;
    }
    | IDENTIFIER {
        int idx = find_var($1);
        if (idx == -1) {
            yyerror("Variable not declared");
            $$.val = 0;
            $$.is_float = 0;
        } else {
            $$.val = vars[idx].value;
            $$.is_float = vars[idx].is_float;
        }
        free($1);
    }
    | expression PLUS expression {
        $$.val = $1.val + $3.val;
        $$.is_float = $1.is_float || $3.is_float;
        printf("t%d = %.2f + %.2f\n", temp_count++, $1.val, $3.val);
    }
    | expression MINUS expression {
        $$.val = $1.val - $3.val;
        $$.is_float = $1.is_float || $3.is_float;
        printf("t%d = %.2f - %.2f\n", temp_count++, $1.val, $3.val);
    }
    | expression MUL expression {
        $$.val = $1.val * $3.val;
        $$.is_float = $1.is_float || $3.is_float;
        printf("t%d = %.2f * %.2f\n", temp_count++, $1.val, $3.val);
    }
    | expression DIV expression {
        $$.val = $1.val / $3.val;
        $$.is_float = 1;
        printf("t%d = %.2f / %.2f\n", temp_count++, $1.val, $3.val);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    printf("Hindi Compiler (type code and press Ctrl+D to run)\n");
    return yyparse();
}
