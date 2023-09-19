# Convergence
The ability to consider infinite operations is the essential difference between analysis and algebra.

## Sequence
Let $X$ be a set. A sequence (in $X$) is simply a function $\phi:\mathbb{N}\to X$ :
$$(x_n), (x_n)_{n\in\mathbb{N}},(x_0,x_1,x_2,\cdots)$$
where $x_n:=\phi(n)$ is the $n^{\text{th}}$ term of the sequence.

(Abuse of notation $\mathbb{K}$ for number fields)

Sequences in $\mathbb{K}$ are called **number sequence**. The $\mathbb{K}\text{-vector space}$ $\mathbb{K}^\mathbb{N}$ of all number sequences is denoted by $s$ or $s(\mathbb{K})$.
- Real sequence : $\mathbb{K=R}$
- Complex sequence : $\mathbb{K=C}$

### Properties
Let $x_n$ be a sequence in $X$ and $E$ a property. 
- $E$ holds for **almost all** terms iff $\exist m\in\mathbb{N}$ st $E(x_n)$ is true $\forall n\geq m$
- $E$ is true for **infinity many** terms iff $N\subseteq \mathbb{N}\land |N|=\infty$ and $E(x_n)$ holds $\forall n\in N$

## Metric Space
Let $X$ be a set. A function $d:X\times X\to \mathbb{R}^+$ is called a **metric** on $X$ if the following hold:
- $d(x,y)=0\iff x=y$
- (Symmetry) $\forall x,y\in X, d(x,y)=d(y,x)$
- (Triangle inequality) $\forall x,y,z\in X, d(x,y)\leq d(x,z)+d(y,z)$

Then $(X,d)$ is called a metric space.

In the metric space $(X,d)$ for $a\in X,r>0$, the set:
$$\mathbb{B}(a,r):=\mathbb{B}_X(a,r):=\{x\in X;d(a,x)<r\}$$
is called the **open ball** with center $a$ and radius $r$, while

$$\mathbb{\bar{B}}(a,r):=\mathbb{\bar{B}}_X(a,r):=\{x\in X;d(a,x)\leq r\}$$ 
is the **closed ball**.

## Neighborhood
- A subset $U$ of a metric space $X$ is called a neighborhood of $a\in X$ if $\exist r>0$ st $\mathbb{B}(a,r)\subseteq U$
- The set of all neighborhoods of the point $a$ is denoted $\mathcal{U}(a)$
$$\mathcal{U}(a):=\mathcal{U}_X(a)\subseteq\mathcal{P}(X)$$

**Examples** :
- $\forall \epsilon>0$, $\mathbb{B}(a,\epsilon)$ are neighborhoods of $a$ called the open $\epsilon\text{-neighborhood}$ of $a$
- There is a topology space structure 
  - $X\in \mathcal{U}(a)$
  - $U_1,U_2\in \mathcal{U}(a)\implies U_1\cap U_2\in\mathcal{U}(a)$ and $U_1\cup U_2\in\mathcal{U}(a)$

## Cluster Points
$a\in X$ is a **cluster point** of $(x_n)$ if every neighborhood of $a$ contains infinitely many terms of the sequence.

**Propositions** :
The following are equivalent:
- $a$ is a cluster point of $(x_n)$
- $\forall U\in \mathcal{U}(a)$ and $m\in \mathbb{N}$, there $\exist n\geq m$ st $x_n\in U$
- $\forall \epsilon>0,m\in\mathbb{N},\exist n\geq m$ st $x_n\in \mathbb{B}(a,\epsilon)$

## Convergence
A sequence $(x_n)$ **converges** with **limit** $a$ if $\forall U\in\mathcal{U}(a)$ contains **almost all** terms (Geometric intuition : The distance from $x_n$ to $a$ becomes **arbitrarily small**) of the sequence.
$$\lim_{n\to\infty}x_n=a$$
$(x_n)$ converges to $a$ as $n$ goes to $\infty$. A sequence which is not convergent is called **divergent**.

**Propositions** :
The following are equivalent:
- $\lim x_n=a$
- $\forall U\in \mathcal{U}(a),\exist N:=N(U)$ st $\forall n\geq N,x_n\in U$
- $\forall \epsilon>0,\exist N:=N(\epsilon)$ st $\forall n\geq N,x_n\in\mathbb{B}(a,\epsilon)$

## Bounded Sets
A subset $Y\subseteq X$ is called $d\text{-bounded}$ or **bounded** in $X$ (with respect to the metric $d$) if $\exist M>0$ st $\forall x,y\in Y,d(x,y)\leq M$
$$\text{diam}(Y):=\text{sup}_{x,y\in Y} d(x,y)$$

- A sequence $(x_n)$ is bounded if its image $\{x_n;n\in\mathbb{N}\}$ is bounded.
- Any convergent sequence is bounded.
- The limit of a convergent is unique.

## Subsequence

