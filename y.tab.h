/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    RETURN = 258,
    ADDASGN = 259,
    SUBASGN = 260,
    MULASGN = 261,
    DIVASGN = 262,
    MODASGN = 263,
    PRINT = 264,
    IF = 265,
    ELSE = 266,
    FOR = 267,
    WHILE = 268,
    T = 269,
    F = 270,
    SEMICOLON = 271,
    EQ = 272,
    NE = 273,
    LT = 274,
    LTE = 275,
    ML = 276,
    MLE = 277,
    AND = 278,
    OR = 279,
    NOT = 280,
    LB = 281,
    RB = 282,
    LCB = 283,
    RCB = 284,
    LSB = 285,
    RSB = 286,
    COMMA = 287,
    INC = 288,
    DEC = 289,
    I_CONST = 290,
    F_CONST = 291,
    B_CONST = 292,
    STR_CONST = 293,
    ID = 294,
    VOID = 295,
    INT = 296,
    FLOAT = 297,
    STRING = 298,
    BOOL = 299
  };
#endif
/* Tokens.  */
#define RETURN 258
#define ADDASGN 259
#define SUBASGN 260
#define MULASGN 261
#define DIVASGN 262
#define MODASGN 263
#define PRINT 264
#define IF 265
#define ELSE 266
#define FOR 267
#define WHILE 268
#define T 269
#define F 270
#define SEMICOLON 271
#define EQ 272
#define NE 273
#define LT 274
#define LTE 275
#define ML 276
#define MLE 277
#define AND 278
#define OR 279
#define NOT 280
#define LB 281
#define RB 282
#define LCB 283
#define RCB 284
#define LSB 285
#define RSB 286
#define COMMA 287
#define INC 288
#define DEC 289
#define I_CONST 290
#define F_CONST 291
#define B_CONST 292
#define STR_CONST 293
#define ID 294
#define VOID 295
#define INT 296
#define FLOAT 297
#define STRING 298
#define BOOL 299

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 37 "compiler_hw2.y" /* yacc.c:1909  */

    int i_val;
    double f_val;
    char* string;

#line 148 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
