# Topology
## Topological Space
A **topological space** is a set $S$ together with a collection $\tau$ of subsets called open sets st
- (T1) $S,\varnothing\in\tau$
- (T2) $U_1,U_2\in\tau\implies U_1\cap U_2\in\tau$
- (T3) The union of any collection of open sets is open

The closed sets in such topological space is defined as
$$
\Tau = \{A|A^c\in\tau\}
$$
(The closed sets then obey rules dual to those of open sets)

A subset $S$ of a topological space $X$ is said to be **clopen** if it is both open and close

### Relative topology
If $A\subset S$, the relative topology on $A$ is defined by
$$
\tau_A=\{U\cap A|U\in\tau\}
$$

### Discrete topology
If $S\not ={\varnothing}$ and $\tau$ be the collection of all subsets of $S$. Then $S$ is called discrete topology on the set $S$.


## Neighborhood
- An open neighborhood of a point $u\in S$ is an open set $U$ st $u\in U$
- An open neighborhood of $A\subset S$ if $U$ is open and $A\subset U$

## Basis
Let $S$ be a topological space with $\tau$, a **basis** is collection $\mathscr{B}$ of open sets st every open set of $S$ is a union of elements of $\mathscr{B}$

## Finite
Let $X\not=\varnothing$ and a topology $\tau$ in $X$ is called **finite-closed topology (Co-finite topology)** if the closed subsets of $X$ are $X$ and all finite subsets of $X$