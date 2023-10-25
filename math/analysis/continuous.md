# Continuous functions
## Continuity
For a function $f:X\to Y$ being continuous measures how "small changes" in the image $f(X)\subseteq Y$ arise from corresponding "small changes" in the domain $X$

- Let $f:X\to Y$ be a function between metric spaces $(X,d_X)$ and $(Y,d_Y)$ then $f$ is **continuous at** $x_0\in X$ if for each neighborhood $V$ of $f(x_0)\in Y$,there exists neighborhood $U$ of $x_0\in X$ st $f(U)\subseteq V$.
- (Classic real-valued function) Let $f:\mathbb{R}\to\mathbb{R}$ and we say that $\lim_{x\to c}f(x)=L$ provided that $\forall\epsilon>0$ there exists $\delta>0$ st whenever $0<|x-c|<\delta$ (and $x\in A$) it follows that $|f(x)-L|<\delta$.

To prove the continuity of $f$ at $x_0$, one supposes an arbitrary neighborhood $V$ of $f(x_0)$ is *given* and then shows that there is a neighborhood $U$ of $x_0$ st $f(U)\subseteq V$

- A function $f:X\to Y$ is **continuous** if it's continuous at each point of $X$.
- $f$ is **discontinuous** at $x_0$ if $f$ is not continuous at $x_0$.
- The set of all continuous functions from $X\to Y$ is denoted $C(X,Y)\subset Y^{X}$

- A function $f:X\to Y$ is **continuous** at $x_0\in X$ iff $\forall\epsilon>0,\exists\delta:=\delta(x_0,\epsilon)>0$ st
$$\forall x\in X,d_X(x_0,x)<\delta\implies d_Y(f(x_0),f(x))<\epsilon $$

**Proof**:
- $\implies$:  Let $f$ be continuous at $x_0$ and $\epsilon>0$ then for the neighborhood $V:=\mathbb{B}_Y(f(x_0),\epsilon)\in \mathcal{U}_Y(f(x_0))$, $\exists U\in\mathcal{U}_X(x_0)$ st $f(U)\subseteq V$. Then $\exists \delta:=\delta(x_0,\epsilon)>0$ st $\mathbb{B}_X(x_0,\delta)\subseteq U$ thus
$$f(\mathbb{B}_X(x_0,\delta))\subseteq f(U)\subseteq V= \mathbb{B}_Y(f(x_0),\epsilon)$$
- $\impliedby$: For $V\in\mathcal{U}_Y(f(x_0))$ then $\exists\epsilon>0$ st $\mathbb{B}_Y(f(x_0),\epsilon)\subseteq V$. Thus,$\exists\delta>0$ st the *image* of $U:=\mathbb{B}_X(x_0,\delta)$ is contained in $\mathbb{B}_Y(f(x_0),\epsilon)$ and hence also in $V$. (Trivial)

**Corollary**:

Let $E$ and $F$ be normed vector space and $X\subseteq E$ then $f:X\to F$ is continuous at $x_0\in X$ iff $\forall \epsilon>0,\exists \delta:=\delta(x_0,\epsilon)>0$ st
$$\forall x\in X, ||x-x_0||_E<\delta\implies||f(x)-f(x_0)||<\epsilon$$

Let $A\subseteq X$ and $f:X\to Y$ is continuous at $x_0\in A$ then $f|A:A\to Y$ is continuous at $x_0$.

## Sequential Continuity
A function $f:X\to Y$ between metric spaces $X$ and $Y$ is called **sequential continuous** at $x\in X$ if $\forall (x_k)$ in $X$ st $\lim x_k=x$ we have $\lim f(x_k)=f(x)$

### Sequence Criterion
Let $X,Y$ be metric spaces then a function $f:X\to Y$ is continuous at $x$ iff it's sequential continuous at $x$.

**Proof**:
- $\implies$: Let $(x_k)$ be a sequence in $X$ st $x_k\to x$. Let $V$ be a neighborhood of $f(x)$ in $Y$. By supposition $\exists N\in\mathbb{N}$ st $\forall k\geq N,x_k\in U$ thus $\forall k\geq N,f(x_k)\in V$ that is $f(x_k)$ converges to $f(x)$
- $\impliedby$: To the contrary we suppose $f$ is sequentially continuous but *discontinuous* at $x$ then there is a neighborhood $V$ of $f(x )$ st no neighborhood $U$ of $x$ st $f(U)\subseteq V$
$$f(\mathbb{B}(x,\frac{1}{k}))\cap V^c\not ={\varnothing},k\in\mathbb{N}^\times$$

Hence $\forall k\in\mathbb{N}^\times$ we can choose some $x_k\in X$ st $d(x,x_k)<\dfrac{1}{k}$ and $f(x_k)\not\in V$. By construction $(x_k)$ converges to $x$ but $(f(x_k))$ doe not converges to $f(x)$, which contradicts the sequential continuity of $f$.

Let $f:X\to Y$ be a continuous function between metric spaces. Then for any convergent sequence $(x_k)$ in $X$ :
$$\lim f(x_k)=f(\lim x_k)$$

## Arithmetic of Continuous functions
Let $M$ be an arbitrary set and $F$ a $\mathbb{K}$-vector space (We need product and sum). Let $f$ and $g$ be functions with $\text{dom}(f),\text{dom}(g)\subseteq M$ and values in $F$. The **sum** $f+g$ is defined by
$$
f+g:\text{dom(f+g)}\to F:=\text{dom}(f)\cap\text{dom}(g)\to F\\ 
x\mapsto f(x)+g(x)
$$

Similarly, for $\lambda\in K$, we define $\lambda f$:
$$\lambda f:\text{dom}(f)\to F, x\mapsto \lambda f(x)$$

For the case $F=\mathbb{K}$ we set
$$
\text{dom}(f\cdot g):=\text{dom}(f)\cap \text{dom}(g)
\\ 
\text{dom}(\frac{f}{g}):=\text{dom}(f)\cap\{x\in\text{dom}(g),g(x)\not ={0}\}
$$

The **product** and **quotient**  of $f$ and $g$ is defined by 
$$
f\cdot g:\text{dom}(f\cdot g)\to\mathbb{K},x\mapsto f(x)\cdot g(x)
\\ 
\frac{f}{g}:\text{dom}(\frac{f}{g})\to\mathbb{K},
x\mapsto \frac{f(x)}{g(x)}
$$

--- 
**Continuity of compositions**

Let $X,Y$ and $Z$ be metric spaces. Suppose that $f:X\to Y$ is continuous at $x\in X$ and $g:Y\to Z$ is continuous at $f(x)\in Y$. Then the composition $g\circ f:X\to Z$ is continuous at $x$

**Proof**:

Let $W$ be a neighborhood of $g(f(x))$ in $Z$. Because $g$ is continuous at $f(x)$, there is a neighborhood $V$ of $f(x)$ in $Y$ st $g(V)\subseteq W$. Since $f$ is continuous at $x$, there is a neighborhood $U$ of $x$ in $X$ st $f(U)\subseteq V$, thus we have
$$g\circ f(U)=g(f(U))\subseteq g(V)\subseteq W$$

## One-Sided Continuity
Let $X$ be a subset of $\mathbb{R}$ and $x_0\in X$. The **order structure** of $\mathbb{R}$ allows us to consider one-sided neighborhood of $x_0$.

Specifically, $\forall\delta>0$, the set $X\cap (x_0-\delta,x_0]$ or $[x_0,x_0+\delta)$ is called **left / right** $\delta\text{-neighborhood}$ of $x_0$.

Let $Y$ be a metric space then $f:X\to Y$ is left (right) continuous at $x_0$ if $\forall V=\mathcal{U}_Y(f(x_0))\in Y, \exists\delta>0$ st $f(X\cap (x_0-\delta,x_0])\subseteq V$ ($f(X\cap [x_0,x_0+\delta))\subseteq V$).

---

Let $Y$ be a metric space $X\subseteq\mathbb{R}$ and $f:X\to Y$ then the following are equivalent:
- $f$ is left continuous at $x\in X$
- $\forall (x_n)$ in $X$ st $x_n\to x\land x_n\leq x$ the sequence $(f(x_n))$ converges to $f(x)$

