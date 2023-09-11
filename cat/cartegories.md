# Category Theory

## Categories
Axiomatic definition of a **Category** $\mathscr{C}$:
- A collection of things called $\mathscr{C}\text{-objects}$
- A collection of things called $\mathscr{C}\text{-arrows}$
- Operations assigning to each $\mathscr{C}\text{-arrow} \ f$ a $\mathscr{C}\text{-object} \ a=\text{dom}(f)$ and $\mathscr{C}\text{-object} \ b=\text{cod}(f)$ :$$f:a\to b \ \text{or} \ a\xrightarrow{f}b$$
- Associative Law: Given that $$a\xrightarrow{f}b\xrightarrow{g}c\xrightarrow{h}d$$ then $h\circ (g\circ f)=(h\circ g)\circ f$
- For each $\mathscr{C}\text{-object}$ $b$ there's a $\mathscr{C}\text{-arrow} \ 1_b:b\to b$ called the identity arrow on $b$, which satisfy the **Identity Law** above

## Examples
### Pre-order
Pre-order: Between any two objects $p$ and $q$ there is **at most one** arrow $p\to q$. Denote the objects of a pre-order category as $P$ then we may define a binary relation $R$ on $P$ by:
$$(p,q)\in R $$
 iff there is an arrow $p\to q$ in the pre-order category.

$R$ has the properties ($pRq$ means $(p,q)\in R$):
- Reflexive: $\forall p , pRp$ (Identity Law)
- Transitive: $pRq\land qRs\implies pRs$ (Composition)
The relation $R$ here is called **pre-ordering**, we can also start with pre-ordering and obtain a pre-order category.

Along with **antisymmetric** , i.e. $pRq\land qRp\implies p=q$, the pre-ordering is called **partial ordering** (Symbol $\preceq$)
> The categorical expression of antisymmetry condition will be given later.


A **poset** is a pair $\text{P}=(P,\preceq)$ where $P$ is a set and $\preceq$ is partial ordering on $P$. **These structures plays a central role in Topoi**

**Examples**
- $\mathbb{N}$ with partial ordering $\leq$
- $S_n=\{0,1,2,..,n\}$ with partial ordering $\leq$



### Discrete Category
$\mathscr{C}$ is discrete if every arrow is the identity arrow (really nothing but a set of objects)
### Monoid
A monoid is triple $\text{M}=(M,*,e)$ where 
- $M$ is a set
- $*$ is a binary operation on $M$ i.e. a function $M\times M \to M$. The operation $*$ is associative.
- $e$ is the monoid identity $\forall x\in M,e*x=x*e=x $

### Arrow Category
The category $\text{Set}^{\to}$ is a function-objected category.

### Comma Category
Comma category can be thought as arrow category where we restrict attention to arrows with fixed domain and codomain.
> However, $\text{Set} \downarrow\mathbb{R}$ is not as it stands a subcategory of $\text{Set}^{\to}$ as the two have different sorts of arrows

The category $\text{Set} \downarrow\mathbb{R}$ is the category of real valued functions. 
- The objects are all functions $f:A\to \mathbb{R}$ (Sometimes denote $(A,f)$)
- The arrow from $f:A\to \mathbb{R}$ and $g:B\to \mathbb{R}$ is a function $k:A\to B$ that satisfies $g \circ k = f$
- The composition: $$(A,f)\xrightarrow{k}(B,g)\xrightarrow{l}(C,h)$$ is defined as $l \circ k:(A,f)\to (C,h)$
- Identity: $\text{id}_A:(A,f)\to (A,f)$

Similarly , the category $\mathscr{C}\uparrow X$ is a category where objects are arrows with $\text{dom}=X$

