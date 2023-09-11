
# Relation
- A **binary relation** on a set $A$ is a subset $R$ of $A\times A$, denoted $a \sim b$ if $(a,b)\in R$
- An **equivalence relation** is a relation st
  - reflexive $\forall a\in A ,a\sim a$
  - symmetric $\forall a,b\in Aa\sim b \land b \sim a$
  - transitive $\forall a,b,c\in A, a\sim b \land b\sim c \implies a \sim c$
- **Equivalent class** of $a\in A$ : $\{x\in A|x\sim a\}$
- **Partition** of $A$ : A collection $\{A_i|i\in I\}$ ($I$ is an indexing set) st
  - $A=\bigcup_{i\in I}A_i$
  - $\forall i,j \in I, i\not = j,A_i\cap A_j=\emptyset$
- $X/\sim := \{[x];x\in X\}$ ($X$ modulo $\sim$) is the set of all equivalence classes of $X$, which is also a partition of $X$
- The (canonical) **quotient function** from $X$ to $X/\sim$: 
$$p:=p_X:X\to X/\sim, x\mapsto [x]$$


## Order
- A relation $leq$ is a **partial order** on $X$ if it's reflexive, transitive and antisymmetric:
$$x\leq y \land y\leq x \implies x=y$$
- Pair $(X,\leq)$ is called a **partially ordered set**
- In addition with $\forall x,y\in X:x\leq y \lor y\leq x \implies x=y$ then $\leq$ is called a **total order** on $X$

### Examples
