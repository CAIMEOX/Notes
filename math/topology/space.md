# Topology
## Topological Space

> [!definition] Topological Space
> A **topological space** is a set $S$ together with a collection $\tau$ of subsets called open sets st
> -  (T1) $S,\varnothing\in\tau$
> - (T2) $U_1,U_2\in\tau\implies U_1\cap U_2\in\tau$
> - (T3) The union of any collection of open sets is open

The closed sets in such topological space is defined as
$$
T = \{A|A^c\in\tau\}
$$
(The closed sets then obey rules dual to those of open sets)

A subset $S$ of a topological space $X$ is said to be **clopen** if it is both open and close

### Relative topology
> [!definition] Relative topology
> If $A\subset S$, the relative topology on $A$ is defined by
$$
\tau_A=\{U\cap A|U\in\tau\}
$$
### Co-Finite topology
> [!definition] Co-finite topology
Let $X\not=\varnothing$ and a topology $\tau$ in $X$ is called **finite-closed topology (Co-finite topology)** if the closed subsets of $X$ are $X$ and all finite subsets of $X$

### Discrete topology
> [!definition] Discrete topology
> If $S\not ={\varnothing}$ and $\tau$ be the collection of all subsets of $S$. Then $S$ is called discrete topology on the set $S$.
## Neighborhood
- An open neighborhood of a point $u\in S$ is an open set $U$ st $u\in U$
- An open neighborhood of $A\subset S$ if $U$ is open and $A\subset U$

## Basis
> [!definition] Basis
Let $S$ be a topological space with $\tau$, a **basis** is collection $\mathcal{B}$ of open sets st every open set of $S$ is a union of elements of $\mathcal{B}$

There can be many different bases for the same topology. Here are examples of basis.
### Examples
> [!example] 
> - $\mathcal{B}=\{(a,b)|a,b\in\mathbb{R},a<b\}$ is a basis for the euclidean topology on $\mathbb{R}$
> - Let $(X,\tau)$ be a discrete space and $\mathcal{B}$ the collection of all singleton subsets of $X$. The $\mathcal{B}$ is a basis of $\tau$

> [!question] The collection of subsets of $X$ is a basis for a topology on $X$ iff $\mathcal{B}$ has the following properties
> - $X=\bigcup_{B\in\mathcal{B}}B$ 
> - $\forall B_1,B_2\in\mathcal{B}$, the set $B_1\cap B_2\in\mathcal{B}$
> 
> > [!tip] Proof
> > From the definition of topological space, the open sets are just union of members of $\mathcal{B}$
> > 
> > Conversely. We have $X\in\tau$ first. Note that $\varnothing$ is an empty union of members of $\mathcal{B}$ and so $\varnothing\in\tau$.
> > Now let $\{T_i\}$ be a family of members of $\tau$ and hence each $T_i$ is a union of members of $\mathcal{B}$ and so is in $\tau$
> > Let $C$ and $D$ in $\tau$ and for some index set $K$ we have $C=\bigcup_{k\in K}B_k$ and $B_k\in\mathcal{B}$ also for $J$ for $D$.Hence
> > $$
> > C\cap D = \bigcup_{k\in K,j\in J} (B_k\cap B_j)\in\mathcal{B}
> >$$

