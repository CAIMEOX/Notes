# Basic Topology of $\mathbb{R}$
Given $a\in R$ and $\epsilon>0$, the $\epsilon\text{-neighborhood}$ of $a$ is the set
$$
V_\epsilon(a)=\{x\in\mathbb{R}:|x-a|<\epsilon\}
$$

## Open Sets
> [!definition]
> A set $O\subseteq\mathbb{R}$ is **open** if for all points $a\in O$ there exists an $\epsilon\text{-neighborhood } V_\epsilon(a)\subseteq O$

- The open intervals is open

> [!theorem]
> - The union of an arbitrary collection of open sets is open
> - The intersection of a finite collection of open sets is open

## Closed Sets
> [!definition] Limit Point
> A point $x$ is a **limit point** of a set $A$ if every $\epsilon\text{-neighborhood } V_\epsilon(x)$ of $x$ intersects the set $A$ at some point other than $x$. 
> If a point is not a limit point then it is an **isolated point**.

Limit point are also named "cluster points".

> [!theorem]
> A point $x$ is a limit point of $A$ iff $x=\lim a_n$ for some sequence $(a_n)$ contained in $A$ satisfying $a_n\not ={x}$ for all $n\in\mathbb{N}$

> [!definition] Closed Set
> A set is closed if it contains all its limit points

> [!theorem]
> The union of a finite collection of closed sets is closed
> The intersection of an arbitrary collection of closed sets is closed

> [!theorem] Density of $\mathbb{Q}$ in $\mathbb{R}$
> $\forall y\in\mathbb{R}$ there exists a sequence of rational numbers that converges to $y$

> [!definition] Closure
> Given a set $A\subseteq\mathbb{R}$ and let $L$ be the set of all limit points of $A$. The closure of $A$ is defined to be $\bar{A}=A\cup L$

> [!theorem] $\forall A\subseteq\mathbb{R}$ the closure $\bar{A}$ is a closed set and is the smallest closed set containing $A$

> [!theorem] Complements
> A set $O$ is open iff $O^c$ is closed

## Compact Sets
The central challenge in analysis is to exploit the power of infinite, via limits, series, derivatives, integrals and etc. A major tool is the compact sets.

> [!definition] Compactness
> A set $K\subseteq\mathbb{R}$ is **compact** if every sequence in $K$ has a subsequence that converges to a limit that is also in $K$.

> [!example] Closed Interval
> The most basic example is a closed interval. **Bolzano-Weierstrass Theorem** guarantees that we can find a convergent subsequence.

> [!definition] Bounded Set
> A set $A\subseteq\mathbb{R}$ is bounded if there exists $M>0$ st $\forall a\in A,|a|\leq M$.

> [!theorem] Characterization of Compactness in $\mathbb{R}$
> A set $K\subseteq\mathbb{R}$ is compact iff it is closed and bounded.

> [!theorem] Nested Compact Set Property
> If 
> $$...\subseteq K_4\subseteq K_3\subseteq K_2\subseteq K_1$$
> is a nested sequence of nonempty compact sets then the intersection $\bigcap_{n=1}^\infty K_n$ is not empty
