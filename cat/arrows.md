# Arrows
## Monic Arrows
A set function $f:A\to B$ is said to be **injective** iff $\forall x, y \in A$:$$f(x)=f(y) \implies x=y$$

The injective function is left **cancellable**:$$\text{whenever} \ f\circ g=f \circ h \ \text{then} \ g=h$$ and vice verse.

An arrow $f:A\to B$ in category $\mathscr{C}$ is **monic** if for any parallel pair $g,h:C\rightrightarrows A$ of $\mathscr{C}\text{-arrows}$, the equality $f\circ g = f\circ h$ implies that $g=h$. (denoted $f:A\rightarrowtail B$)

## Epic Arrows
A set function $f:A\to B$ is said to be **surjective** iff the codomain $B$ is $\text{Im}(f)$

An arrow $f:A\to B$ is **epic** (Right cancellable) in category $\mathscr{C}$ if for any parallel pair $g,h:C\rightrightarrows A$ of $\mathscr{C}\text{-arrows}$, the equality $g\circ f = h\circ f$ implies that $g=h$. (denoted $f:A\twoheadrightarrow B$)

## Iso Arrows
A function that is both surjective and injective is called **bijective**. If $f:A\cong B$ and $g:B\cong A$:$$g\circ f = \text{id}_A \land f\circ g=\text{id}_B$$
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