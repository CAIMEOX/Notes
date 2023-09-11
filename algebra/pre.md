# Preliminaries of algebra

## Logic 
- $x$ has property $E$ means $E(x)$ is true.
- $x$ belongs to a class : $x\in X$ otherwise $x\not \in X$
- $\{x\in X;E(x)\}$ is the class of all elements $x$ of the collection $X$ which have property $E$.
- $\exist$ for the quantifier 'there exists'
- $\forall$ for the quantifier 'for all'
- Symbol $a:=b$ means 'is defined by'
- Implication: $(A\implies B) := (\lnot A)\lor B$ (To prove $B$ is **suffices** to prove $A$ / $B$ is **necessary** for $A$ to be true)
- Equivalence: $A\iff B := (A\implies B)\land (B\implies A)$ 
- $(A\implies B)\iff (\lnot B\implies \lnot A)$ ($(\lnot B\implies \lnot A)$ is called the contrapositive of the $A\implies B$)
- $A:\iff B$ : $A$ is true, by definition, if $B$ is true

## Theorem / Lemma / Corollary
- All these are propositions
- Theorem is a particularly important proposition
- Lemma is a proposition which precedes a theorem and is needed for its proof
- Corollary is a proposition which follows directly from a theorem

## Notations

- $\mathbb{Z} = \{0, \pm1,\pm2,\dots \}$
- $\mathbb{Q} = \{a/b|a,b\in\mathbb{Z},b\not ={0}\}$
- $\mathbb{R}$ : Real numbers
- $\mathbb{C} = \{a+bi|a,b\in\mathbb{R}, i^2=-1\}$
- $\mathbb{F}^+$ denotes the positive elements in $\mathbb{F}$

## Properties of $\mathbb{Z}$
- (Well-ordering) If $A$ is any nonempty subset of $\mathbb{Z}^+$ then there is some element $m\in A$ st $m\leq a$ forall $a\in A$ ($m$ is the minimal element of $A$)


## Integer modulo $n$
- Define a relation on $\mathbb{Z}$ by $a\sim b$ iff $n|(b-a)$, trivially it is an equivalence relation. Denoted $a\equiv b \mod{n}$ ($a$ is **congruent** to $b$ mod $n$)
- For any $a\in\mathbb{Z}$, denote the equivalence class of $a$ by $\bar{a} = \{a+kn|k\in\mathbb{Z}\}$ (Congruence class / residue class of $a$ mod $n$) 
- The set of equivalence classes under equivalence relation is denoted by $\mathbb{Z}/n\mathbb{Z}$ (named the integers modulo $n$)
- Modular arithmetic : $\forall \bar{a},\bar{b}\in\mathbb{Z}/n\mathbb{Z}$ :
$$\bar{a}+\bar{b}=\overline{a+b}, \bar{a}\times \bar{b}=\overline{a\times b}$$
