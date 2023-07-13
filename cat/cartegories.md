# Category Theory
## Functions are sets
- A function can be thought as a black box performing input-output process.
- The inputs are called arguments and the outputs are values.

If $R$ is a relation (set of ordered pairs) and $(x,y) \in R$ then we think of $x$ being assigned to $y$ by the association that $R$ represents.

For example we can define the $<$ relation:$$\{(x,y):x \ \text{is less than} \ y\} $$

Functions have feature that a given input produces one uniquely corresponding output (denote the Relation set of function $f$ as $\hat{f}$ ): $$ (x,y)\in \hat{f} \land (x,z)\in \hat{f} \implies y=z$$

- Domain:$$\text{dom} (f)=\{x: \exists y, (x,y)\in \hat{f}\}$$
- Image:$$\text{Im}(f)=\{y:\exists x,(x,y)\in \hat{f}\}$$
- Image is a subset of Codomain
- If $A\subset B$ then $f(x)=x$ is a function called **inclusion** function from $A$ to $B$, symbolized $A\xhookrightarrow{} B$. Thought it is conceptually different from **identity** function, they have the same set of ordered pairs!
- The product set (Cartesian product) of $A$ and $B$ is defined :$$A\times B=\{(x,y):x\in A \land y\in B\}$$
- To avoid the problem happens in the inclusion function, we can now define it as a triple $f=(A,B,R)$ where $R\in A\times B$ is a (function) relation.

## Composition of functions
Given two functions $f:A\to B$ and $g:B\to C$ we can obtain a new function by the rule "apply $f$ and then $g$": $$g\circ f (x) = g(f(x))$$

- Associative Law:$$h\circ (g\circ f)=(h\circ g)\circ f$$
- Commutativity:The two paths amount to the same thing.
- Identity Law : For any $f:A\to B,g:B\to C$, $\text{id}_B\circ f =f$ and $g\circ \text{id}_B=g$.

## Categories
Axiomatic definition of a **Category** $\mathscr{C}$:
- A collection of things called $\mathscr{C}\text{-objects}$
- A collection of things called $\mathscr{C}\text{-arrows}$
- Operations assigning to each $\mathscr{C}\text{-arrow} \ f$ a $\mathscr{C}\text{-object} \ a=\text{dom}(f)$ and $\mathscr{C}\text{-object} \ b=\text{cod}(f)$ :$$f:a\to b \ \text{or} \ a\xrightarrow{f}b$$
- Associative Law: Given that $$a\xrightarrow{f}b\xrightarrow{g}c\xrightarrow{h}d$$ then $h\circ (g\circ f)=(h\circ g)\circ f$
- For each $\mathscr{C}\text{-object}$ $b$ there's a $\mathscr{C}\text{-arrow} \ 1_b:b\to b$ called the identity arrow on $b$, which satisfy the **Identity Law** above

## Examples
### Pre-order
Pre-order: Between any two objects $p$ and $q$ there is **at most one** arrow $p\to q$. Denote the objects of a pre-order category as $P$ then we may define a binary relation $R$ on $P$ by:$$(p,q)\in R $$ iff there is an arrow $p\to q$ in the pre-order category.

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

