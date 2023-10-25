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
- $E$ holds for **almost all** terms iff $\exists m\in\mathbb{N}$ st $E(x_n)$ is true $\forall n\geq m$
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
- A subset $U$ of a metric space $X$ is called a neighborhood of $a\in X$ if $\exists r>0$ st $\mathbb{B}(a,r)\subseteq U$
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
- $\forall U\in \mathcal{U}(a)$ and $m\in \mathbb{N}$, there $\exists n\geq m$ st $x_n\in U$
- $\forall \epsilon>0,m\in\mathbb{N},\exists n\geq m$ st $x_n\in \mathbb{B}(a,\epsilon)$

## Convergence
A sequence $(x_n)$ **converges** with **limit** $a$ if $\forall U\in\mathcal{U}(a)$ contains **almost all** terms (Geometric intuition : The distance from $x_n$ to $a$ becomes **arbitrarily small**) of the sequence.
$$\lim_{n\to\infty}x_n=a$$
$(x_n)$ converges to $a$ as $n$ goes to $\infty$. A sequence which is not convergent is called **divergent**.

**Propositions** :
The following are equivalent:
- $\lim x_n=a$
- $\forall U\in \mathcal{U}(a),\exists N:=N(U)$ st $\forall n\geq N,x_n\in U$
- $\forall \epsilon>0,\exists N:=N(\epsilon)$ st $\forall n\geq N,x_n\in\mathbb{B}(a,\epsilon)$

## Bounded Sets
A subset $Y\subseteq X$ is called $d\text{-bounded}$ or **bounded** in $X$ (with respect to the metric $d$) if $\exists M>0$ st $\forall x,y\in Y,d(x,y)\leq M$
$$\text{diam}(Y):=\text{sup}_{x,y\in Y} d(x,y)$$

- A sequence $(x_n)$ is bounded if its image $\{x_n;n\in\mathbb{N}\}$ is bounded.
- Any convergent sequence is bounded.
- The limit of a convergent is unique.

## Subsequence
Let $\phi=(x_n)$ be a sequence in $X$ and $\sigma:\mathbb{N}\to\mathbb{N}$ a **strictly increasing** function. Then $\phi\circ\sigma\in X^\mathbb{N}$ is called a subsequence of $\phi$

- A point $a$ us a cluster point of a sequence $(x_n)$ iff $\exists (x_{n_k})_{k\in\mathbb{N}}$ of $(x_n)$ which converges to $a$

## Null Sequence
A sequence $(x_n)$ in $\mathbb{K}$ is called a **null sequence** if it converges to zero. That is, $\forall \epsilon >0,\exists N\in\mathbb{N}$ st $\forall n\geq N,|x_n|<\epsilon$.

The set of all null sequences in $\mathbb{K}$ is denoted:
$$c_0:=c_0(\mathbb{K}):=\{(x_n)\in s;\lim x_n=0\}$$

**Propositions** :
Let $(x_n)$ and $(y_n)$ be sequences in $\mathbb{K}$
- If $\lim x_n=a$ and $\lim y_n=b$
  - $\lim (x_n+y_n)=a+b$
  - $\alpha\in\mathbb{K},\lim \alpha x_n = \alpha a$
  - $\lim (x_n y_n)=ab$
- If $(x_n)$ is a null sequence and $(y_n)$ is a bounded sequence, then $(x_n y_n)$ is a null sequence

## Comparison Test
- Let $(x_n)$ and $(y_n)$ be convergent sequences in $\mathbb{R}$ st $x_n<y_n$ for infinitely many $n\in\mathbb{N}$. Then:
$$\lim x_n\leq \lim y_n$$

- Let $(x_n)$, $(y_n)$ and $(z_n)$ be convergent sequences in $\mathbb{R}$ st $x_n\leq y_n\leq z_n$ for almost all $n\in\mathbb{N}$. If $\lim x_n=\lim z_n=a$ then $(y_n)$ also converges to $a$

## Some important limits
Let $a\in\mathbb{C}$ then
- $a^n\to 0$ if $|a|<1$
- $a^n\to 1$ if $a=1$
- $a^n$ diverges if $|a|\geq 1,a\not=1$

---

Let $k\in\mathbb{N}$ and $c\in\mathbb{C}$ st $|a|>1$ then
$$\lim_{n\to\infty}\frac{n^k}{a^n}=0$$

---

For all $a\in\mathbb{C}$
$$\lim_{n\to\infty}\frac{a^n}{n!}=0$$

---


For $n\in \mathbb{R}$:
$$\lim_{n\to\infty} n^{\frac{1}{n}}=1$$
**Proof**:


Let $\epsilon>0$ and the sequence $x_n=\dfrac{n}{(1+\epsilon)^n}$ is a null sequence. Thus $\exists N$ st
$$\forall n\geq N ,x_n<1$$
That is
$$1\leq n\leq (1+\epsilon)^n$$
The $n^{\text{th}}$ root function is increasing and so
$$1\leq n^{\frac{1}{n}}\leq 1+\epsilon$$

--- 

For all $a>0, \lim_{n\to\infty}a^{\frac{1}{n}}=1$

**Proof**:
By **Archimedean Property** of $\mathbb{R}$, $\exists N\in\mathbb{N}$ st $\forall n\geq N, \frac{1}{n}<a<n$
$$\frac{1}{n^{\frac{1}{n}}} = \left(\frac{1}{n}\right)^{\frac{1}{n}}\leq a^{\frac{1}{n}}\leq n^{\frac{1}{n}}$$
Hence the claim is true.

## Limit Superior and Inferior
Let $(x_n)$ be a sequence in $\mathbb{R}$ we can define $(y_n)$ and $(z_n)$ by
$$y_n:=\text{sup}_{k\geq n}x_k:=\text{sup}\{x_k;k\geq n\}$$
$$z_n:=\text{inf}_{k\geq n}x_k:=\text{inf}\{x_k;k\geq n\}$$