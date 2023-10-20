# Euclidean Topology

> [!defintion] Euclidean Topology
>  A subset $S$ of $\mathbb{R}$ is said to be open in the **euclidean topology** on $\mathbb{R}$ if $\forall x\in S$ there exists $a,b\in\mathbb{R}$ with $a<b$ st $x\in(a,b)\in S$.

The dual definition of **euclidean topology** can be based on closed sets
> [!defintion] 
>  For each $a$ and $b$ in $\mathbb{R}$ with $a<b$ the closed intervcal $[a,b]$ is a closed set in the euclidean topology in $\mathbb{R}$.

## Examples
> [!example]
> - The singleton set $\{a\}$ is closed in $\mathbb{R}$
> - The set $\mathbb{Z}$ is a closed subset of $\mathbb{R}$
> - The only clopen subsets of $\mathbb{R}$ are the trivial sets: $\mathbb{R},\varnothing$

> [!proposition]
>  A subset $S$ of $\mathbb{R}$ is open iff it's a union of open intervals
> 
> > [!tip] Proof
> > Assume $S$ is a union of open intervals i.e there exist open intervals $(a_i,b_i)$ st $S=\bigcup (a_i,b_i)$. Hence $S$ is a union of open sets and so $S$ is an open set.
> > 
> > Conversely assume that $S$ is open in $\mathbb{R}$ then $\forall x\in S,\exists I_x=(a,b)$ st $x\in I_x\subseteq S$. Let $y\in S$ then $y\in I_y$ so $y\in \bigcup_{x\in S}I_x$. Secondly let $z\in\bigcup_{x\in S}I_x$ then $z\in I_t$ for some $t\in S$. As each $I_x\subseteq S$ we see $I_t\subseteq S$ and so $z\in S$. Hence $S=\bigcup_{x\in S}I_x$. $S$ is a union of open intervals as required.

