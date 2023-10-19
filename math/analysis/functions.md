# Functions

## Functions are sets
- A function can be thought as a black box performing input-output process.
- The inputs are called arguments and the outputs are values.

If $R$ is a relation (set of ordered pairs) and $(x,y) \in R$ then we think of $x$ being assigned to $y$ by the association that $R$ represents.

For example we can define the $<$ relation:
$$\{(x,y):x \ \text{is less than} \ y\} $$

Functions have feature that a given input produces one uniquely corresponding output (denote the Relation set of function $f$ as $\hat{f}$ ): 
$$ (x,y)\in \hat{f} \land (x,z)\in \hat{f} \implies y=z$$

- Domain:
$$\text{dom} (f)=\{x: \exists y, (x,y)\in \hat{f}\}$$
- Image:
$$\text{Im}(f)=\{y:\exists x,(x,y)\in \hat{f}\}$$
- Graph:
$$\text{graph}(f) := \{(x,y)\in X\times Y; y=f(x)\}$$
- Image is a subset of Codomain

### Examples
- If $A\subseteq B$ then $f(x)=x$ is a function called **inclusion** function from $A$ to $B$, symbolized $A\xhookrightarrow{} B$. Thought it is conceptually different from **identity** function, they have the same set of ordered pairs!
- if $f:X\to Y$ and $A\subseteq X$ then $f|A:A\to Y$, $x\mapsto f(x)$ is the **restriction** of $f$ to $A$ .
- Let $X\not ={\emptyset}$ and $A\subseteq X$ then the **characteristic function** of $A$ is 
$$\mathcal{X}_A:X\to \{0,1\}, x\mapsto\begin{cases}1,x\in A\\0,x\in A^c\end{cases}$$
- The product set (Cartesian product) of $A$ and $B$ is defined :
$$A\times B=\{(x,y):x\in A \land y\in B\}$$
- To avoid the problem happens in the inclusion function, we can now define it as a triple $f=(A,B,R)$ where $R\in A\times B$ is a (function) relation.

## Composition of functions
Given two functions $f:A\to B$ and $g:B\to C$ we can obtain a new function by the rule "apply $f$ and then $g$": 
$$g\circ f (x) = g(f(x))$$

- Associative Law:
$$h\circ (g\circ f)=(h\circ g)\circ f$$
- Commutativity:The two paths amount to the same thing.
- Identity Law : For any $f:A\to B,g:B\to C$, $\text{id}_B\circ f =f$ and $g\circ \text{id}_B=g$.


## Injection / Surjection
Let $X\to Y$ be a function. 
- $f$ is **surjective** if $\text{Im}(f)=Y$
- $f$ is **injective** if $\forall x,y\in X,f(x)=f(y) \implies x=y$
- $f$ is **bijective** if it is both surjective and injective.

### Proposition
- Let $f:X\to Y$ be a function. $f$ is bijective iff $\exists g:X\to Y$ st $g\circ f=\text{id}_X$ and $f\circ g=\text{id}_Y$. $g$ is uniquely determined by $f$ in this case.

**Proof** : 
- $\implies$ : Suppose $f$ is bijective then $f$ is surjective $\forall y\in Y$ there's some $x\in X$ st $f(x)=y$. Because $f$ is injective, $x$ is uniquely determined by $y$. Hence $g$ is well-defined.
- $\impliedby$ : From $f\circ g=\text{id}_Y$ we know $f$ is surjective. Let $x,y\in X$ and $f(x)=f(y)$ then we have $x=g(f(x))=g(f(y))=y$. Hence $f$ is injective.
- Uniqueness: If $h:Y\to X$ with $h\circ f=\text{id}_X$ and $f\circ h=\text{id}_Y$ then $g=g\circ \text{id}_Y=g\circ(f\circ h)=(g\circ f)\circ h=\text{id}_X\circ h=h$ Thus $g$ is uniquely determined.

## Inverse Functions
Let $f:X\to Y$ is bijective then the inverse function $f^{-1}$ is the unique function $f^{-1}:Y\to X$ st $f\circ f^{-1}=\text{id}_X$
- $(g\circ f)^{-1}=f^{-1}\circ g^{-1}$
- **Image** of $A$ under $f$ : $f(A) := \{f(a)\in Y;a\in A\}$
- **PreImage** of $C$ under $f$ : $f^{-1}(C):=\{x\in X; f(x)\in C\}$