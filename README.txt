Compiler Design Project - Hindi Language Compiler

NAME: DHRUHI SHAH
EN.ID: 22000381 
Course_Incharge: Prof. Vaibhavi Patel


Project Title:
"Hindi-Based Simple Programming Language Compiler Using Lex and Yacc"

Description:
This project implements a basic compiler for a simplified programming language written in Hindi using Lex (Flex) for lexical analysis and Yacc (Bison) for syntax analysis. The goal is to allow beginners or native Hindi speakers to write programs in a more intuitive, language-accessible way while learning the structure of compiler design.

This Hindi compiler reads statements such as variable assignments, arithmetic operations, print commands, and loops (like `JAB TAK`) written in Hindi-syntax-style and executes them. The compiler converts them into machine-understandable code and prints the results.

Features & Capabilities:
- Variable declaration and assignment (`x = 10.5`)
- Arithmetic operations (`+, -, *, /`)
- Hindi-based `PRINT` statements (e.g., `PRINT x`)
- Looping with `JAB TAK` (while-loop equivalent)
- Error detection and syntax validation
- Supports float and integer operations
- Prints execution results line-by-line
- Helpful error messages for incorrect syntax

Code Overview:

1. Lex File (`hindi_compiler.l`):
   - Tokenizes Hindi-style keywords (e.g., `PRINT`, `JAB TAK`)
   - Recognizes numbers, identifiers, and operators
   - Removes whitespace and comments
   - Passes tokens to the parser

2. Yacc File (`hindi_compiler.y`):
   - Defines grammar rules for Hindi-style statements
   - Supports expressions, loops, conditions, and print statements
   - Evaluates expressions and stores variable values in a symbol table
   - Handles syntax errors with user-friendly messages

3. Input Program (`program.txt`):
   - A script written in your custom Hindi-style programming language
   - Contains assignment, loops, and `PRINT` statements
   - Example input:

आंक x;
छूटक y;
x = 5;
y = 10.5;
x = x + y;
दिखाओ x;

Output:
x = 5.00
y = 10.50
t1 = 5.00 + 10.50
Warning: Assigning float to int x, truncating
x = 15.00
PRINT x = 15.00

To Run the Project:
1. Compile using the following commands:

1. bison -d hindi_parser.y
2. flex hindi_lex.l
3. gcc hindi_parser.tab.c lex.yy.c -o hindi_compiler
4. hindi_compiler.exe < program.txt

Ensure 'program.txt' contains valid Hindi syntax as per the grammar.

Thank you! 