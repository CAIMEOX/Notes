# Preliminaries of algebra

## Notations

- $\mathbb{Z} = \{0, \pm1,\pm2,\dots \}$
- $\mathbb{Q} = \{a/b|a,b\in\mathbb{Z},b\not ={0}\}$
- $\mathbb{R}$ : Real numbers
- $\mathbb{C} = \{a+bi|a,b\in\mathbb{R}, i^2=-1\}$
- $\mathbb{F}^+$ denotes the positive elements in $\mathbb{F}$

## Relation
- A **binary relation** on a set $A$ is a subset $R$ of $A\times A$, denoted $a \sim b$ if $(a,b)\in R$
- An **equivalence relation** is a relation st
  - reflexive $\forall a\in A ,a\sim a$
  - symmetric $\forall a,b\in Aa\sim b \land b \sim a$
  - transitive $\forall a,b,c\in A, a\sim b \land b\sim c \implies a \sim c$
- **Equivalent class** of $a\in A$ : $\{x\in A|x\sim a\}$
- **Partition** of $A$ : A collection $\{A_i|i\in I\}$ ($I$ is an indexing set) st
  - $A=\bigcup_{i\in I}A_i$
  - $\forall i,j \in I, i\not = j,A_i\cap A_j=\emptyset$

## Properties of $\mathbb{Z}$
- (Well-ordering) If $A$ is any nonempty subset of $\mathbb{Z}^+$ then there is some element $m\in A$ st $m\leq a$ forall $a\in A$ ($m$ is the minimal element of $A$)


## Integer modulo $n$
- Define a relation on $\mathbb{Z}$ by $a\sim b$ iff $n|(b-a)$, trivially it is an equivalence relation. Denoted $a\equiv b \mod{n}$ ($a$ is **congruent** to $b$ mod $n$)
- For any $a\in\mathbb{Z}$, denote the equivalence class of $a$ by $\bar{a} = \{a+kn|k\in\mathbb{Z}\}$ (Congruence class / residue class of $a$ mod $n$) 
- The set of equivalence classes under equivalence relation is denoted by $\mathbb{Z}/n\mathbb{Z}$ (named the integers modulo $n$)
- Modular arithmetic : $\forall \bar{a},\bar{b}\in\mathbb{Z}/n\mathbb{Z}$ :
$$\bar{a}+\bar{b}=\overline{a+b}, \bar{a}\times \bar{b}=\overline{a\times b}$$
