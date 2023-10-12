# Arrows
## Monic Arrows
A set function $f:A\to B$ is said to be **injective** iff $\forall x, y \in A$:
$$f(x)=f(y) \implies x=y$$

The injective function is left **cancellable**:
$$\text{whenever} \ f\circ g=f \circ h \ \text{then} \ g=h$$
and vice verse.

An arrow $f:A\to B$ in category $\mathscr{C}$ is **monic** if for any parallel pair $g,h:C\rightrightarrows A$ of $\mathscr{C}\text{-arrows}$, the equality $f\circ g = f\circ h$ implies that $g=h$. (denoted $f:A\rightarrowtail B$)

## Epic Arrows
A set function $f:A\to B$ is said to be **surjective** iff the codomain $B$ is $\text{Im}(f)$

An arrow $f:A\to B$ is **epic** (Right cancellable) in category $\mathscr{C}$ if for any parallel pair $g,h:C\rightrightarrows A$ of $\mathscr{C}\text{-arrows}$, the equality $g\circ f = h\circ f$ implies that $g=h$. (denoted $f:A\twoheadrightarrow B$)

## Iso Arrows
A function that is both surjective and injective is called **bijective**. If $f:A\cong B$ and $g:B\cong A$:
$$g\circ f = \text{id}_A \land f\circ g=\text{id}_B$$
- $g$ is said to be an **inverse** of $f$
- $g$ is unique
- denote $g=f^{-1}$

## Isomorphic Objects
Objects $A$ and $B$ are isomorphic in $\mathscr{C}$ , denoted $A\cong B$ if there is a $\mathscr{C}\text{-arrow}$ $f:A\to B$ that is iso in $\mathscr{C}$.

**Examples**
- $\text{Grp}$: Group homomorphism
- $\text{Top}$: Topological Space Homemorphism

**Intuitively** the isomorphic objects look the same. In many math theory, isomorphic objects are distinguishable in terms of that theory. We want to identify and study constructions and properties that are **invariant** under the isomorphisms of the theory.

An object "unique up to isomorphism" in possession of a particular **attribute** if the only other objects possessing that attribute are isomorphic 

### Skeletal Category
- In a skeletal category , $a\cong b \implies a=b$.
- A poset is precisely a skeletal pre-order category.
- $\text{Finord}$ is a skeletal category

## Initial Objects
- Given a set $A$ we can find function $\emptyset \to A$ where we can define $f = (\emptyset,A,\emptyset)$.
- The image of $f$ is empty and $f$ is known as the **empty function**.
- $\emptyset \times A$ is empty and the only subset of it is $\emptyset$. Hence $f$ is the only function from $\emptyset$ to $A$.

**Initial Objects**
- A object $0$ is initial in category in $\mathscr{C}$ if for every $\mathscr{C}\text{-object} \ A$ , $\exists ! \mathscr{C}\text{-arrow}$ $!:0\to A$
- Any two initial objects must be isomorphic in $\mathscr{C}$
- In a pre-order $(P, \prec)$ an initial object is an element $0\in P$ where $\forall p \in P$, $0\prec p$. (i.e. A minimal element)

## Terminal Objects
- An object $1$ is terminal in a category $\mathscr{C}$ if for every $\mathscr{C}\text{-object} \ A$ , $\exists ! \mathscr{C}\text{-arrow}$ $!:A\to 1$
- In $\text{Set}$ , the terminal objects are the singletons $\{*\}$

## Duality
- Dual statement $\Sigma^{op}$
- Dual Category $\mathscr{C}^{op}$
- If $\Sigma$ is true of $\mathscr{C}$, $\Sigma^{op}$ is true of $\mathscr{C}^{op}$

## Products
- Without any reference to ordered pairs we can construction products
- The projections : $p_A:A\times B\to A$ and $p_B:A\times B\to B$ is given by the rules $p_A((x,y))=x$ and $p_B((x,y))=y$
- If we have some other set $C$ with maps $f:C\to A$ and $g:C\to B$. Then we define $p:C\to A\times B$ by the rules $p(x)=(f(x),g(x))$
- $p_A\circ p = f$ , $p_B\circ p = g$
- $p$ is defined as the only arrow satisfies

**Product**
- **A product** in a category $\mathscr{C}$ of two objects $A$ and $B$ is a $\mathscr{C}\text{-object} \ A\times B$ with pair $(pr_A:A\times B \to A, pr_B:A\times B\to B)$ of $\mathscr{C}\text{-arrows}$ such that for any pair of $\mathscr{C}\text{-arrows}$ of the form ($f:C\to A, g:C\to B$) there is exactly one arrow $(f,g):C\to A\times B$
- $pr_A \circ (f,g) = f$ 
- $pr_B \circ (f,g) = g$
- $A\times B$ is defined up to isomorphism

## Co-products
The dual of product is the co-product or sum

- A **co-product** of $\mathscr{C}\text{-objects}$ $A$ and $B$ is a $\mathscr{C}\text{-object}$ $A+B$ together with a pair $i_A:A\to A+B$ and $i_B:B\to A+B$ of $\mathscr{C}\text{-arrows}$ st $\forall$ pair of $\mathscr{C}\text{-arrows}$ of the form $(f:A\to C$ and $g:B\to C)$ there's exactly one arrow $[f,g]:A+B\to C$ st
- $[f,g]\circ i_A=f$
- $[f,g]\circ i_B=g$
- $[f,g]$ is called the co-product arrow of $f$ and $g$ with respect to the injections $i_A$ and $i_B$

## Equalizer
- Given a pair $f,g:A\rightrightarrows B$ of parallel functions in category **Set**, let $E$ be the subset of $A$ on which $f$ and $g$ agree, i.e.
$$E=\{x:x\in A\land f(x)=g(x)\}$$
- The **inclusion** function $i:E\xhookrightarrow{} A$ is called the **equalizer** of $f$ and $g$. 
- Under composition with $i$ we can see $f\circ i=g\circ i$. The two functions are equalized by $i$.
- $i$ is **canonical equalizer** of $f$ and $g$ if $h:C\to A$ is any other such equalizer of $f$ and $g$ (i.e. $f\circ h=g\circ h$). Then $h$ *factors* uniquely through $i:E\xhookrightarrow{} A$ (There is exactly one function $k:C\to E$ st $i\circ k=h$)

--- 

- An arrow $i:E\to A$ in $\mathscr{C}$ is an equalizer of a pair $f,g:A\to B$ of $\mathscr{C}\text{-arrows}$ if
- $f\circ i=g\circ i$
- Whenever $h:C\to A$ has $f\circ h=g\circ h$ in $\mathscr{C}$ there is exactly one $\mathscr{C}\text{-arrow}$ $k:C\to E$ st $i\circ k=h$
- Every equalizer is monic
- In any category, an epic equalizer is iso
