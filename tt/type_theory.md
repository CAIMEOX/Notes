# Type Theory 
## Type Theory VS Set Theory 
Homotopy type theory is a alternative foundation of Mathematics to Zermelo-Fraenkel set theory.
### Deductive System 
- A collection of rules for deriving things called **judgments**.
- In first-order logic deductive system there is only one kind of judgment : A given proposition has a proof. 
- From A and B infer A $\land$ B is a rule of proof construction.
- A has a proof can be written a : A in type theory.
- In type theory , propositions are types, this means that equality is a type. For $a , b : A$ we have a type $a = _A b$. When $a = _A b$ is inhabited we say that a and b are ( **propositional** ) equal.
- Another judgmental equality existing at the same level as the judgment "$x : A$". We write $a \equiv b :A$. It makes no sense to negate or assume judgment equal.
- Definition of a function can be written as $f(x):\equiv x^2$

## Function Types
- We can construct type $f: A \to B$ of functions with domain A and codomain B. Given a function $f$ and an element $a :A$, we can apply the function to obtain an element of the codomain $B$, denoted $f(a)$.
- How to construct ? $\lambda$-abstraction
$$
f(x):\equiv \Phi 
$$
    $\Phi$ may contains x as a variable, we have to check $\Phi:B$ assuming $x:A$.
    If we don't want to give a name, we can write down (the type can be omitted ) $\lambda$-abstraction: 
    $$(\lambda(x:A). \Phi):A\to B$$ or
    $$(x\mapsto\Phi):A\to B$$
    
- Example:
    $$
        (\lambda(x:\mathbb{N}).\mathbb{x+x}):\mathbb{N} \to \mathbb{N}
    $$

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
$$
\text{swap} :\prod _{(A:\mathscr{U})}\prod _{(B:\mathscr{U})}\prod _{(C:\mathscr{U})} (A\to B\to C)\to (B\to A\to C)
$$
or use condense notation:
$$
\text{swap} :\prod _{A,B,C:\mathscr{U}} (A\to B\to C)\to (B\to A\to C)
$$
    we can define this by:
$$
\text{swap}(A,B,C,g) :\equiv \lambda b .\lambda a. g(a)(b) 
\\ \text{or use subscript: } \\ 
\text{swap} _{A,B,C}(g)(b,a):\equiv g(a,b)
$$
- Note that as we did for ordinary functions. In the dependent case we can construct $\Pi _{(x:A)}\Pi_ {(y:B(x))} C(x,y)$

## Product types
- In type theory, product type is a primitive concept as function.

To specify a type, we specify the following rules:
- Formation rule (How to form)
- Introduction rule (How to construct elements) : For example a function type has one **constructor** $\lambda$-abstraction.
- Computation rule (How to use elements) : For example the function type has one **eliminator** function application.
- Computation rule (How eliminator acts on constructor ) 
- (Optional) uniqueness principle: express uniqueness of maps into or out of the type 