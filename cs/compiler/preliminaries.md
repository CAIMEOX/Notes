# Preliminaries
- Concrete Syntax: concisely write down and talk about programs.
- Abstract Syntax: Represent programs in compiler.

The way that translates concrete syntax to abstract syntax is called parsing.

## Python stuff
- Use `parse` in module `ast` for parsing.
- Use classes to represent `ASTs` in `ast`.


## Abstract syntax tree
Using a tree to represent a program we can easily follow the links to go from one part of a program to its subparts.

## Grammars
A programming language can be thought of as a set of programs. We can write down a set of rules, a **context-free grammar**, ofr building programs.

The definition of $\mathcal{L}_{\text{var}}$:
$$
\begin{align*}
exp &::= int | \text{input\_int}()|-exp|exp+exp|exp-exp|(exp) 
\\
stmt &::= \text{print}(exp)|exp
\\
\mathcal{L}_{\text{int}} &::=stmt
\end{align*}
$$

## Interpreter
An interpreter that is designated as the definition of a language is called a definitional interpreter.

If running the definitional interpreter produces an error, then the meaning of that program is unspecified unless the exception raised is a `TrappedError`

## Partial Evaluator