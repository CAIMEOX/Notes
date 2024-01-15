# Parsing
The process of parsing is traditionally subdivided into two phases: **lexical analysis (scanning)** and **syntax analysis (parsing)**. 
- The lexical analysis phase translate the sequence of characters into a sequence of **tokens**
- The parsing phase organizes the tokens into a phase tree that captures how the tokens were matched by rules in the grammar of the language.

## Lexical Analysis and Regular Expressions
- Regular languages can be recognized by a finite state machine.
- Regular expression is a pattern formed of the following core elements:
  - A single character $c$ is a regular expression.
  - Two regular expressions separated by a vertical bar $R_1|R_2$ form a regular expression that matches any string that matches $R_1$ or $R_2$.
  - Two regular expressions in a sequence $R_1R_2$ form a regular expression that matches any string that can be formed by concatenating two strings where first one is $R_1$ and the second one is $R_2$.
  - A regular expression followed by an **asterisks** $R*$ (**Kleene closure**) is a regular expression formed by concatenating zero or more strings with pattern $R$.
  - $[c_1c_2\dots c_n] \equiv c_1|c_2|\dots|c_n$
  - $[c_1-c_2]$ matches any character between $c_1$ and $c_2$
  - $R+ \equiv R(R*)$
  - $R? \equiv \varnothing|R$

### Lark grammar file
Each kind of token is specified by a **terminal** (A rule that consists a name followed by a colon followed by a sequence of **literals**)

The literals include strings such as `abc`, regular expressions surrounded by `/` characters, terminal names and literals composed using the regular expression operators ($+,*$,etc)

```lark
DIGIT: /[0-9]/
INT: "-"? DIGIT+
NEWLINE: (/\r/? /\n/)+
```

## Grammars and Parse Trees
A name such as `exp` that is defined by the grammar rules is a **nonterminal**.

Fox concrete syntax, each right-hand side expresses a pattern for a string (A sequence of symbols) instead of a pattern for an abstract syntax tree.

The Lark syntax for grammar rules differs slightly from the variant of BNF.


```lark
exp: INT
  | "input_int" "(" ")"
  | "-" exp
  | exp "+" exp
  | exp "-" exp
  | "(" exp ")"

stmt_list:
  | stmt NEWLINE stmt_list

lang_int: stmt_list
```

- `exp: INT`: if the lexer matches a string to `INT` then the parser also categories the string as an `exp`.
- `exp: exp "+" exp`: any string that matches `exp` followed by the `+` character and another string matches `exp`, is itself an `exp`.
- write `->` followed by a string that you want to appear in the `data` field.

```lark
exp: INT                -> int
  | "input_int" "(" ")" -> input_int
  | "-" exp             -> usub
  | exp "+" exp         -> add
  | exp "-" exp         -> sub
  | "(" exp ")"         -> paren

stmt: "print" "(" exp ")" -> print
  | exp                   -> expr

stmt_list:                  -> empty_stmt
  | stmt NEWLINE stmt_list  -> add_stmt

lang_int: stmt_list         -> module
```

## Ambiguous Grammar
A grammar is **ambiguous** when a string can be parsed in more than one way. To deal with this problem we can change the grammar by categorizing the syntax in a more fine-grained fashion.


```lark
exp: exp "-" exp_no_add -> sub
  | exp "+" exp         -> add
  | exp_no_add

exp_no_add: INT         -> int
  | "input_int" "(" ")" -> input_int
  | "-" exp             -> usub
  | exp "-" exp_no_add  -> sub
  | "(" exp ")"         -> paren
```

For languages with more operators and more **precedence levels**, one must refine the `exp` nonterminal into several nonterminals, one for each precedence level.

## Earley's Algorithm
Earley's algorithm is a parsing algorithms of Earley (1970), the default algorithm used by Lark. It can handle any **context-free grammar** but not very efficient ($O(n^3)$ for ambiguous grammars and $O(n^2)$ for unambiguous grammars, $n$ is the number of tokens in the input string)

**LALR algorithm** is more efficient but cant handle all context-free grammars.

Earley's algorithm uses a data structure called a **chart** to keep track of its progress and to store its results. The chart is an **array** with one slot for each position in input string. (position $0$ before first character and position $n$ is immediately after the last character, the array length is $n+1$). Each slot contains a set of **dotted rules**.

A dotted rule is simply a **grammar rule** with a **period** indicating how much of its right hand side has already been *parsed*.