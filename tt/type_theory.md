# Type Theory 
## Type Theory VS Set Theory 
- Homotopy type theory is a alternative foundation of Mathematics to Zermelo-Fraenkel set theory.
- Intuitionistic type theory (Or Martin-Löf type theory) based on the propositions-as-types principle and clarifies the Brouwer-Heyting-Kolmogorov interpretation of intuitionistic logic.
-  The law of excluded middle and the law of double negation are not allowed in intuitionistic type theory.

### Deductive System 
- A collection of rules for deriving things called **judgments**.
- In first-order logic deductive system there is only one kind of judgment : A given proposition has a proof. 
- From A and B infer A $\land$ B is a rule of proof construction.
- A has a proof can be written a : A in type theory.
- In type theory , propositions are types, this means that equality is a type. For $a , b : A$ we have a type $a = _A b$. When $a = _A b$ is inhabited we say that a and b are ( **propositional** ) equal.
- Another judgmental equality existing at the same level as the judgment "$x : A$". We write $a \equiv b :A$. It makes no sense to negate or assume judgment equal.
- Definition of a function can be written as $f(x):\equiv x^2$

## Curry-Howard Correspondence
> a proposition is the type of its proofs.


## Context 
To construct an element a of a type A is to derive $a:A$. Judgments are explicitly formulated in an ambient **context** , or list of assumptions , of the form :
$$x_1:A_1 , x_2:A_2,\cdots , x_n:A_n$$
An element $x_i:A_i$ expresses the assumption that the variable $x_i$ has type $A_i$ .The types in a context can depend on variables of **earlier** types. For instance , $A_n$ can depend on $x_1:A_1, x_2:A_2, \cdots , x_{n-1}:A_{n-1}$.

The judgment $a:A$ in context $\Gamma$ is written:
$$\Gamma \vdash a:A$$ 

Use $\cdot$ to denote the empty context.

### Notations
- $\cdot \vdash A \ \text{type}$ meaning that $A$ is a well-formed type
- $\Gamma \ \text{context}$ meaning that $\Gamma$ is a well-formed context.
- $\Gamma \vdash A \ \text{type}$ can be abbreviated as  $\Gamma \vdash A$
- $\Gamma \ \text{context}$ can be abbreviated as $\Gamma \vdash$


## Function Types
- We can construct type $f: A \to B$ of functions with domain A and codomain B. Given a function $f$ and an element $a :A$, we can apply the function to obtain an element of the codomain $B$, denoted $f(a)$.
- How to construct ? $\lambda$-abstraction
    $$f(x):\equiv \Phi $$
    $\Phi$ may contains x as a variable, we have to check $\Phi:B$ assuming $x:A$.
    If we don't want to give a name, we can write down (the type can be omitted ) $\lambda$-abstraction: 
    $$(\lambda(x:A). \Phi):A\to B$$ or
    $$(x\mapsto\Phi):A\to B$$
    
- Example:
    $$(\lambda(x:\mathbb{N}).\mathbb{x+x}):\mathbb{N} \to \mathbb{N} $$

- $\beta$-reduction (computation rule): Apply it to $a:A$
    $$(\lambda x . \Phi) (a) \equiv \Phi ' $$
- $\lambda$-abstraction function (Roles the uniqueness principle for function types):
    $$f\equiv (\lambda x.f(x))$$ (Use of the equality is often referred to as $\eta$-conversion).

- Define function with explicit parameters : 
    $$f(x) :\equiv \Phi$$ or $$f:\equiv \lambda x.\Phi$$
    
- For several variables we using currying function ($f:A\to B \to C$):
    $$f(x,y) :\equiv \Phi$$ or
    $$f:\equiv \lambda x.\lambda y. \Phi$$ or even 
    $$f:\equiv x\mapsto y \mapsto \Phi$$

- Implicitly abstract over multiple variables by writting multiple blanks $g(-,-)$ means $\lambda x . \lambda y . g(x,y)$

## Universes and families
- A universe is a type whose elements are types.
- To avoid Russell's paradox we use a hierarchy of universes:
  $$ \mathscr{U}_0: \mathscr{U}_1 : \mathscr{U}_2 : \cdots $$
- We assume that our universes are cumulative that is that all the elements of the $i$-th universe are also elements of the $(i+1)$-th universe
- Typical ambiguity : Left the universes indices implicit 
- To model a collection of types varying over a given type $A$ , we use functions (called families of types of sometimes dependent types) $B:A\to \mathscr{U}$ whose codomain is a universe. 


## Dependent function types ( $\Pi$-Types )

- Given a type $A:\mathscr{U}$ and a family $B:A\to \mathscr{U}$ we can construct the type of dependent functions $\Pi _{(x:A)}B(x):\mathscr{U}$ or $\Pi (x:A) ,B(x) $. Ordinary function type is a special case when $B$ is a constant family
$$
\Pi_{(x:A)}B \equiv (A\to B)
$$
- Define $f: \Pi _{(x:A)}B(x)$ by explicit definitions : 
$$f(x):\equiv \Phi  \text{ for } x:A$$
or using $\lambda$-abstraction
$$\lambda x.\Phi :\Pi _{(x:A)}B(x) $$

- Computation rule: for $a:A$ we have $f(a) \equiv \Phi '$ and $(\lambda x.\Phi)(a)\equiv \Phi '$ where $\Phi ' $ is obtained by replacing all occurrences of $x$ in $\Phi$ by $a$.

- Functions which are **polymorphic** over a given universe. It takes a **type** as one of its arguments and then acts on elements of that type (or other type constructed from it ) An example is $\text{id} \Pi_{(A:\mathscr{U}) } :(A\to A)$

- Another non-trivial example is swap operations that switches the order of the arguments of a (curried ) two-argument function:
$$\text{swap} :\prod _{(A:\mathscr{U})}\prod _{(B:\mathscr{U})}\prod _{(C:\mathscr{U})} (A\to B\to C)\to (B\to A\to C)$$
or use condense notation:
$$\text{swap} :\prod _{A,B,C:\mathscr{U}} (A\to B\to C)\to (B\to A\to C)$$
we can define this by:
$$\text{swap}(A,B,C,g) :\equiv \lambda b .\lambda a. g(a)(b) 
\\ \text{or use subscript: } \\ 
\text{swap} _{A,B,C}(g)(b,a):\equiv g(a,b)$$
- Note that as we did for ordinary functions. In the dependent case we can construct $\Pi _{(x:A)}\Pi_ {(y:B(x))} C(x,y)$

## Product types
- In type theory, product type is a primitive concept as function.

To specify a type, we specify the following rules:
- Formation rule (How to form)
- Introduction rule (How to construct elements) : For example a function type has one **constructor** $\lambda$-abstraction.
- Computation rule (How to use elements) : For example the function type has one **eliminator** function application.
- Computation rule (How eliminator acts on constructor ) 
- (Optional) uniqueness principle: express uniqueness of maps into or out of the type.

Let's construct the product type:
- Form and Introduction: Given $a:A$ and $b:B$ we can form $(a,b):A \times B$. 
- Uniqueness principle (Not a rule , prove later): We expect that every element of $A\times B$ is a pair.
- Computation :
  - Construct non-dependent function $f:A\times B\to C$.
  - Introduce a new rule (Elimination Rule) : For any $g:A\to B\to C$ we can define a function $f:A\times B\to C$ by $f((a,b)) :\equiv g(a)(b)$. Reversely to set theory, we assume that a function on $A\times B$ is well-defined as soon as we specify its values on pairs, and form this we will able to prove that every element of $A\times B$ is a pair.
- Projection functions: $$\text{pr}_1:A\times B \to A \\ \text{pr}_2:A\times B \to B$$ with the defining equations: $$\text{pr}_1((a,b)) :\equiv a \\ \text{pr}_2((a,b)) :\equiv b$$
- Alternative approach by recursor(Product types are a degenerate example of a general framework for **inductive types**): $$\text{rec}_{A\times B}:\prod_{C:\mathscr{U} } (A\to B \to C) \to A\times B \to C$$ with the defining equation: $$\text{rec}_{A\times B}(C, g, (a,b)) :\equiv g(a)(b) $$
- Hence we can define pr by: $$\text{pr}_1 :\equiv rec_{A\times B} (A, \lambda a. \lambda b. a) \\\text{pr}_2:\equiv rec_{A\times B} (A, \lambda a. \lambda b. b)$$

### Generalize the recursor (Non-dependent recursor)
Given $C:A\times B \to \mathscr{U}$ we can define a function $f:\prod_{(x:A\times B)} C(x)$ by $g:\prod_{(x:A)}\prod_{(y:B)}C((x,y))$ with defining equation $$f((x,y)):\equiv g(x)(y)$$

Prove the propositional uniqueness principle: Every element of $A\times B$ is equal to a pair. $$\text{uniq}_{A\times B}:\prod_{x:A\times B} ((\text{pr}_1(x),\text{pr}_2(x)) =_{A\times B} x)$$ (Used the identity type. There is a reflexivity element $\text{refl}_x:x=_A x $ for any $x:A$) 

So we can define: $$\text{uniq}_{A\times B}((a,b)):\equiv \text{refl}_{(a,b)}$$ 

### Induction for product type (Dependent Eliminator)
Given $A,B:\mathscr{U}$ we have $$\text{ind}_{A\times B} \prod_{C:A\times B \to \mathscr{U}}\left(\prod_{x:A} \prod_{y:B} C((x,y))\right)\to \prod_{x:A\times B} C(x)$$ with the defining equation $$\text{ind}_{A\times B} (C,g,(ab)):\equiv g(a)(b)$$

The recursor is just the special case of induction when the family $C$ is constant.

## Dependent pair types ($\Sigma \text{-types}$)
The second component of a pair varies depending on the choice of the first component. (In set theory it corresponds to an indexed sum over a given type. In the sense of coproduct or disjoint union)

Given a type $A:\mathscr{U}$ and a family $B:A\to \mathscr{U}$ the dependent pair type is written: $\Sigma_{(x:A)}B(x):\mathscr{U}$ or $$\sum_{(x:A)}B(x) \text{ or } \Sigma (x:A),B(x)$$

> Like $\lambda-\text{abstractions}$ and $\prod$s, $\sum$s automatically scope over the rest of the expression.

If $B$ is constant then the dependent pair type is the ordinary product type:$$\sum_{x:A}B\equiv A\times B$$

The projection functions $\text{pr}_1$ is similar to product type but the $\text{pr}_2$ is a dependent function :$$\text{pr}_2 : \prod_{p:\sum_{(x:A)}B(x)}B(\text{pr}_1(p))$$

Thus the induction principle (dependent eliminator), we need $$g:\prod_{a:A} \prod_{b:B(a)}C((a,b))$$ We can derive $$f: \prod_{p:\sum_{(x:A)}B(x)}C(p)$$ with $$f((a,b)):\equiv g(a)(b)$$ where $C(p)=B(\text{pr}_1(p))$. Then $\text{pr}_2$ can be defined with $$\text{pr}_2((a,b)):\equiv b$$