# Lambda Calculus
## Untyped Lambda Calculus
### Functions
Construction principles:
- **Abstraction**: From an expression $M$ and a variable $x$ we can construct a new expression $\lambda x.M$. (Abstraction of $x$ over $M$)
- **Application**: For expression $M$ and $N$ we can construct new expression $M \ N$.(Application of $M$ to $N$)

(Note: The construction principle allows expressions which do not have an obvious meaning)

$\beta\text{-reduction}$ (Calculation rule):
$(\lambda x . M) N$ can be rewritten to the expression $M[x := N]$ (i.e. the expression M in which every $x$ has been replaced with $N$)

> [!note]
>  the application of $M$ to $N$ is not the result of applying $M$ to $N$, but the first step, in which the functions has not yet been executed)

> [!info] History
> The idea of currying dates back to the work by M. Schonfinkel

### Lambda terms
> [!info] History
Lambda calculus was invented by A. Church in the 1930s

Expression in the lambda calculus are called $\lambda\text{-terms}$, we assume the existence of an infinite set $V$ of variables: $V=\{x,y,z,\cdots\}$.

The set $\Lambda$ of all $\lambda\text{-terms}$:
- (Variable) If $u \in V$ then $u \in \Lambda$
- (Application) If $M$ and $N$ $\in V$ then $MN \in V$
- (Abstraction) If $M \in \Lambda$ and $u\in V$ then $(\lambda u.M)\in \Lambda$

Or via abstract syntax (The 3 possibilities are separated by the vertical bar |):
$$
\Lambda = \Lambda \Lambda | V | (\lambda V. \Lambda)
$$

Notations:
- $x,y,z$ and variants with subscripts and primes for $u\in V$
- $L,M,N \in \Lambda$
- Syntactical identity of two lambda terms will be denoted with symbol $\equiv$

MultiSet of subterms:
- (Basic) $\text{Sub}(x) = \{x\}$
- (Application) $\text{Sub}(MN)=\text{Sub}(M) \cup \text{Sub}(N) \cap \text{Sub}(MN)$ 
- (Abstraction) $\text{Sub}(\lambda x.M) =\text{Sub}(M) \cup \{(\lambda x .M)\}$
- $L \in \text{Sub}(M)$ : $L$ is a subterm of $M$, if $L \not\equiv$

**Lemma**
- (Reflexivity) $\forall M\in\Lambda, M\in\text{Sub}(M)$
- (Transitivity) $L\in \text{Sub}(M) \land M \in \text{Sub}(N) \implies L \in \text{Sub}(N)$

> [!note]
> - Parentheses in an outermost position may be omitted.
> - Application is left-associative
> - Successive abstractions maybe combined in a right-associative way under $\lambda$. (e.g. $\lambda xy .M \equiv \lambda x .(\lambda y .M)$)

### Free and bound variables

$FV$, the set of Free variables of a $\lambda\text{-term}$
- (Variable) $FV(x) = \{x\}$
- (Application) $FV(MN) = FV(M) \cup FV(N)$
- (Abstraction) $FV(\lambda x.M)=FV(M) -\{x\}$

**Combinator**:
A $\lambda\text{-term}$ is closed if $FV(M) = \varnothing$ , which is also called a combinator.
The set of all combinator is denoted $\Lambda^0$.

### Alpha conversion
$M^{x\to y}$ denotes the result of replacing every free occurrence of $x \in M$ by $y$. The renaming process is denoted by symbol $=_{\alpha}$ with the definition $\lambda x.M =_{\alpha}\lambda y .M^{x\to y}$ , provided that $y \not\in FV(M)$ and $y$ is not a binding variable.

If $M =_\alpha N$ then we say $M$ and $N$ are $\alpha\text{-convertible}$ or $\alpha\text{-equivalent}$ , $M$ is an $\alpha\text{-variant}$ of $N$ (and vice versa).

- (Renaming) $\lambda x.M = _{\alpha} \lambda y.M ^{x\to y}$ 
- (Compatibility) If $M =_{\alpha} N$ then $ML =_{\alpha} NL$ , $LM =_{\alpha} LN$ and $\forall z, \lambda z. M =_\alpha \lambda z . N$
- (Reflexivity) $M =_\alpha M$
- (Symmetry) $M =_\alpha N \implies N =_\alpha M$
- (Transitivity) $L =_\alpha M \land M =_\alpha N \implies L =_\alpha N$

### Substitution
Substitution rules:
- $x[x:=N]\equiv N$
- $y[x:=N]\equiv y$ if $x \not\equiv y$
- $(PQ)[x:=N] \equiv (P[x:= N])(Q[x:=N])$
- $(\lambda y.P [x:=N] \equiv \lambda z. (P^{y\to z}[x:=N])$ if $\lambda z.P ^{y\to z}$ is an $\alpha\text{-variant}$ of $\lambda y.P $ such that $z \not\in FV(N)$ (This prevents some terms from being bound)

> [!note]
> The terms of the form $P[x:=N]$ are not $\lambda\text{-terms}$

The substitutions is not communicative:
$$
x [x:=y][y:=x] \equiv x \\
x [y:=x][x:=y] \equiv y
$$

**Lemma**

Let $x \not\equiv y$ and assume $x\not\in FV(L)$. Then: $M[x:=N][y:=L] \equiv M[y:=L][x:=N[y:=L]]$ .

### Lambda-terms modulo $\alpha\text{-equivalent}$
**Lemma**

Let $M_1=_\alpha N_1$ and $M_2 =_\alpha N_2$;
- $M_1N_2 =_\alpha N_1N_2$
- $\lambda x. M_1 =_\alpha \lambda x. N_1$ 
- $M_1 [x:=M_2] = N_1[x:=N_2]$

(Abuse of notation: Use $\equiv$ for syntactical identity modulo $\alpha\text{-equivalent}$)

**Barendregt convention**

We choose names for binding variables in a $\lambda\text{-terms}$ in such a manner that they're all different.

### Beta reduction
The One-step $\beta\text{-reduction}$:
- (Basic) $(\lambda x.M ) N \to _\beta M[x:=N]$
- (Compatibility) If $M \to_\beta N$ then $ML \to_\beta NL$, $LM \to _\beta LN$ and $\lambda x .M \to_\beta \lambda x .N$
- Name $(\lambda x.M ) N$ the redex (Reducible expression) and $M[x:=N]$ the contractum (of the redex)

(A remarkable expression: $(\lambda x . x \ x)(\lambda x . x \ x ) \to_\beta (\lambda x . x \ x )(\lambda x . x \ x )$)

$\beta\text{-reduction}$ (zero or more steps):
- $M \twoheadrightarrow_\beta N$ if there is an $n > 0$ and there are terms $M_0$ to $M_n$ such that $M_0 \equiv M$, $M_n=N$ and $\forall i, 0 \leq i<n$ : $M_i \to_\beta M_{i+1}$

**Lemma**
- $\twoheadrightarrow_\beta$ extends $\to_\beta$ ($M\to_\beta N \implies M \twoheadrightarrow_\beta N$)
- $\twoheadrightarrow_\beta$ is reflexive and transitive
    - (refl) : $\forall M : M \twoheadrightarrow_\beta M$
    - (trans) : $\forall L, M, N$ if $L \twoheadrightarrow_\beta M \land M \twoheadrightarrow_\beta N$ then $L \twoheadrightarrow_\beta N$

$\beta\text{-equal}$ or $\beta\text{-convertible}$: 

$M =_\beta N$ if there's an $n\geq 0$ and there are terms $M_0$ to $M_n$ such that $M_0 \equiv M, M_n \equiv N$ and $\forall i , 0\leq i < n$: $M_i \to_\beta M_{i+1} \lor M_{i+1} \to_\beta M_i$

**Lemma**
- $=_\beta$ extends $\twoheadrightarrow_\beta$ in both directions
- $=_\beta$ is an equivalence relation

### Normal forms and confluence
$\beta\text{-normal form}$ or $\beta\text{-nf}$:
- $M$ is in $\beta\text{-nf}$ if $M$ contains no redex
- $M$ has $\beta\text{-nf}$ or is $\beta\text{-normalising}$ if there is an $N$ in $\beta\text{-nf}$ such that $M=_\beta N$
- When $M$ is in $\beta\text{-nf}$ then $M \twoheadrightarrow_\beta N \implies M \equiv N$

Examples
- $\Delta := \lambda x.\ x \ x \ x$. $\Delta\Delta \to_\beta \Delta\Delta\Delta \to_\beta \Delta\Delta\Delta\Delta \to_\beta \cdots$
- $\Omega := (\lambda x . x \ x)(\lambda x . x \ x )$ never gets rid of the redex

Reduction path:
- A finite reduction path from $M$ is a finite sequence of terms $N_0, N_1, N_2, \dots, N_n$ such that $N_0 \equiv M$ and $N_i \to_\beta N_{i+1}$ for each $i$ with $0 \leq i < n$ .
- An infinite reduction path form $M$ is an infinite sequence $N_0, N_1, N_2, \dots$ with $N_0 \equiv M$ and $N_i \to_\beta N_{i+1}$

Weak and strong normalization:
- $M$ is weakly normalizing if there is an $N$ in $\beta\text{-normal form}$ such that $M \to_\beta N$
- $M$ is strongly normalizing if there are no infinite reduction paths starting from $M$ (Hence the path can be extended to one ending in a $\beta\text{-nf}$)

**Church-Rosser Theorem** (Hard to prove)

Suppose that for a given $\lambda\text{-term } M$ we have $M \twoheadrightarrow_\beta N_1$ and $M \twoheadrightarrow_\beta N_2$ then there is a $\lambda\text{-term}$ $N_3$ such that $N_1 \twoheadrightarrow_\beta N_3$ and $N_2 \twoheadrightarrow_\beta N_3$

**Corollary**

Suppose that $M =_\beta N$ then there is $L$ such that $M \twoheadrightarrow_\beta L$ and $N \twoheadrightarrow_\beta L$.

Proof sketch: 
- Noticed that we can find a $n \in \mathbb{N}$: 
$$M\equiv M_0 \rightleftarrows_\beta M_1 \cdots M_{n-1} \rightleftarrows_\beta M_n \equiv N$$
- Proceed by induction on $n$
    + $n=0$ then $M\equiv N$, trivially exists $L$
    + $n=k>0$ then $M_{k - 1}$ exists, denoted $M_0 \twoheadrightarrow_\beta L'$ and $M_{k-1} \twoheadrightarrow_\beta L'$
    + In case 1: Apply CR to the arrow $M_{k-1} \twoheadrightarrow_\beta L'$ and $M_{k-1} \twoheadrightarrow_\beta M_k$ 
    + In case 2: Just take $L'$ as $L$
- Done

**Lemma**
- If $M$ has $N$ as $\beta\text{-nf}$ then $M \twoheadrightarrow _\beta N$
- A $\lambda\text{-term}$ has at most one $\beta\text{-nf}$

### Fixed Point Theorem
Every $\lambda\text{-term}$ has a fixed point: 
$\forall L \in \Lambda$ there is $M\in \Lambda$ such that $LM =_\beta M$

Proof: For given $L$ define $M:=(\lambda x.L(xx))(\lambda x.L(xx))$. $M$ is a redex hence:
$$M \to_\beta L((\lambda x.L(xx))(\lambda x.L(xx))) \equiv LM$$

Fixed Point combinator:
$$Y \equiv \lambda y . (\lambda x . y (xx)) (\lambda x . y (xx))$$

$YL$ is fixed point of $L$ since:
$$YL \to_\beta M \to_\beta LM =_\beta L(YL)$$

Notes: 
- A number of recursive equations can be solved by means of fixed points
- Untyped Lambda Calculus is Turning-complete
- Combinatory logic can be seen as the lambda calculus restricted to the terms $\text{K}:= \lambda xy.x$ and $\text{S}:=\lambda xyz . x \ z ( y z )$. This system is simpler than lambda calculus but slightly more difficult to work with
- De Bruijn invented a way of representing $\lambda\text{-terms}$ without using named variables (**de bruijn indices**)

## Simply typed lambda calculus
### Types
The set $\mathbb{T}$ of all types (here we denote $\mathbb{V} =\{\alpha,\beta,\gamma,\cdots\}$ to be the infinite set of type variables )
- (Type variable) $\alpha \in \mathbb{V} \implies \alpha \in \mathbb{T}$
- (Arrow Type) $\sigma , \tau \in \mathbb{T} \implies (\sigma \to \tau) \in \mathbb{T}$
- (Abstract syntax) $\mathbb{T = V} | \mathbb{T \to T}$
- Arrow type has right-associativity

To express things like term $M$ has type $\sigma$, we use statements (typing statements) of the form $M: \sigma$

- Each variable has a unique type $x : \sigma \land x : \tau \implies \sigma \equiv \tau$

The natural requirements for the typing of applications and abstractions:
- Application : if $M : \sigma \to \tau $ and $N : \sigma$ then $MN : \tau$
- Abstraction : if $x : \tau$ and $N:\sigma$ then $\lambda x  . M : \sigma \to \tau$

Examples:
- $x:\tau$ then $\lambda x .x : \tau \to \tau$
- $x \ x$ can have a type because $\sigma \to \tau \not\equiv \tau$

**Typable term**: A term is called **typable** if there's a type $\sigma$ such that $M:\sigma$ .

### Church-typing and Curry-typing
- (Typing a la Church ; Explicit typing) : Prescribe a (unique) type for each variable upon its introduction
- (Typing a la Curry ; Implicit typing) : Leave variables open to some extent
- The types of the free variables are given is a **context** (Basis)
- The judgement: $x:\alpha\to\alpha , y:(\alpha\to\alpha)\to\beta\vdash (\lambda z:\beta .\lambda u:\gamma .z)(y\ x) : \gamma\to\beta$ (The left is context and the right side is typable term)

### Derivation rules for Church's $\lambda\to$
Pre-typed lambda terms $\Lambda_\mathbb{T}$ : 
$$\Lambda_\mathbb{T}=V|(\Lambda_\mathbb{T}\Lambda_\mathbb{T})|\lambda V:\mathbb{T} .\Lambda_\mathbb{T}$$

**Definitions**
- **Statement**: the form $M:\sigma$ where $M\in\Lambda_\mathbb{T} \land \sigma\in\mathbb{T}$, $M$ is called the subject and $\sigma$ the type
- **Declaration**: Statement with a variable as subject
- **Context**: A list of declarations with different subjects
- **Judgement**: $\Gamma\vdash M:\sigma$ with $\Gamma$a context and $M:\sigma$ a statement

Derivation System (How certain judgement can be formally established)

Premiss-conclusion format : A number of premisses appear above a horizontal line and the conclusion below.
$$\frac{\text{premiss}_1 \quad \text{premiss}_2\quad \cdots \quad\text{premiss}_n}{\text{conclusion}} (\text{Name})$$

Derivation rules for $\lambda\to$ :
- $x:\sigma\in\Gamma\implies\Gamma\vdash x:\sigma(\text{Variable})$ (This rule has no premisses but only contains conclusion)  

- $\dfrac{\Gamma\vdash M:\sigma\to\tau \quad \Gamma\vdash N:\sigma}{\Gamma\vdash MN:\tau} (\text{Application})$

- $\dfrac{\Gamma,x:\sigma\vdash M:\tau}{\Gamma\vdash\lambda x:\sigma.M:\sigma\to\tau} (\text{Abstraction})$

- The rules is universal which hold for arbitrary $\Gamma, \sigma, \tau, M, N$ 
- The empty context is denoted as $\varnothing$

**Logic** (Natural deduction):
- $\dfrac{A\implies B \quad A} {B} (\implies\text{-elim})$
  - Known as Modus Ponens. (Rule to eliminate an $\implies$)

- $\dfrac{\text{Assume A} \quad\cdots\quad B}{A\implies B}(\implies\text{-intro})$
  - To obtain an implication. Starts with assumption $A$ and try to show that $B$ holds

### Legal $\lambda\to\text{-terms}$
A pre-typed term $M$ in $\lambda\to$ is called **legal** if there exist context $\Gamma$ and type $\rho$ st $\Gamma\vDash M:\rho$

### Different formats for a derivation in $\lambda\to$
- The **tree format** gives a good picture of the buildup of a derivation but in more complex cases a tree tends to spread out over the page
- The linear order presents the judgement one by one as lines (But there are duplication of the declarations in the context)
- The flag format enables a writer to develop a derivation step by step more perspicuous.

### Problems to be solved in Type Theory 

> [!question] Well-Typedness (Typability)
> Find out whether a term is legal: $?\vdash \text{term}: ?$

> [!question] Type-Checking
> How to check $\text{context}\vdash^{?}\text{term}:\text{type}$ where context, term and type are given

> [!question] Term-Finding (Term Construction or Inhabitation)
> Given a context and a type find out whether a term exists with that type corresponding to that specific context. $\text{context}\vdash ?:\text{type}$

All these problems are **decidable** in $\lambda\to$ i.e. for each of these questions there's an algorithm that **produces the answer**, for given input in the form of 'context', 'term' or/and 'type'.

In more complicated systems, it's undecidable in many cases.

### Well-typedness in $\lambda\to$
To show $\lambda\text{-term } M$ is legal: $M\equiv \lambda y:\alpha\to\beta.\lambda z:\alpha .y\space z$ we need to find a context $\Gamma$ and a type $\rho$ st $\Gamma\vdash M:\rho$.

It looks like reverse the flag format: first use the abstraction-rule twice. And then simply use the var-rule. Finally we find $y\space z$ by application-rule.

If we had started with the term $N\equiv \lambda y:\alpha\to\beta.\lambda z:\beta .y\space z$ then at this point we would have come to the conclusion that a derivation of a type is **impossible**: The term has no type.

### Type-checking in $\lambda\to$

### Term-finding in $\lambda\to$
A term which belongs to a certain type is called an **inhabitant** of that type. The problem here is to find an inhabitant of a given type.

Start with a logical expression $A\to B\to A$ where $\to$ should be read as implication. Let's formalize this proof in $\lambda\to$.

That is simply the lambda abstraction:
$$\lambda x:A.\lambda y:B.x:A\to B\to A$$

Considering propositions as types and inhabitants of propositions as proofs.
- Assume that $x$ is a proof of proposition $A$
- Assume that $y$ is a proof of proposition $B$
- So the function mapping $y$ to $x$ sends a proof of $B$ to a proof of $A$, i.e. $\lambda y:B.x$ proves the implication $B\to A$
- Consequently, $\lambda x:A.\lambda y:B.x$ proves $A\to B\to A$

It is called the **PAT-interpretation** where PAT means '**Propositions as types**' and '**proofs as terms**'.

> [!note] 
> The term **implicitly** includes the proposition it proves

> [!tip]
> In well-typing and type-checking the development of the complete derivation roughly follows a pattern: starting with a term, one successfully replaces it by simpler terms until it can be typed, then other types are calculated until finally the type of the original term has been derived

### General properties of $\lambda\to$
If $\Gamma\equiv x_1:\sigma_1,\dots,x_n:\sigma_n$ then the domain of $\Gamma$ or $\text{dom}(\Gamma)$ is the list $(x_1,\dots,x_n$.

Context $\Gamma'$ is a **sub-context** of context $\Gamma$, or $\Gamma'\subseteq\Gamma$ if all declarations occurring in $\Gamma'$ also occur in $\Gamma$ in the **same order**.

Context $\Gamma'$ is a **permutation** of context $\Gamma$ if all declarations in $\Gamma'$ also occur in $\Gamma$ 

If $\Gamma$ is a context and $\Phi$ a set of variables then the projection of $\Gamma$ on $\Phi$ or $\Gamma\upharpoonright\Phi$ is the sub-context $\Gamma'$ of $\Gamma$ with $\text{dom}(\Gamma')=\text{dom}(\Gamma)\cap\Phi$

> [!tip] Structural Induction
>  To prove a general property $\mathcal{P}$ for an arbitrary expression $\mathcal{E}$ we can proceed by
>  - (Induction Hypothesis) Assume that $\mathcal{P}$ holds for all expressions $\mathcal{E}'$ used to construct $\mathcal{E}$ 
>  - Then proving that $\mathcal{P}$ also holds for $\mathcal{E}$ itself.

> [!note] Free Variable Lemma
> If $\Gamma\vdash L:\alpha$ then $FV(L)\subseteq\text{dom}(\Gamma)$ 
> > [!tip] Proof
> > Suppose $\mathcal{J}\equiv\Gamma\vdash L:\alpha$ is the final conclusion of a derivation and we assume that the content of the lemma already holds for the **premisses** that have been used to derive the **conclusion**.
> > - Var-Rule Case:
> > Then $\mathcal{J}$ has the form $\Gamma\vdash x:\alpha$ and this follows from $x:\alpha\in\Gamma$. This is an immediate consequence of $x:\alpha\in\Gamma$.
> > - Application-Rule Case:
> > $\mathcal{J}$ has the form $\Gamma\vdash MN:\tau$ and we have to prove $FV(MN)\in\text{dom}(\Gamma)$. The lemma already holds for the premisses of the Application-rule $\Gamma\vdash M:\sigma\to\tau$ and $\Gamma\vdash N:\sigma$ hence we may assume $FV(M)\subseteq\text{dom}(\Gamma)$ and $FV(N)\subseteq\text{dom}(\Gamma)$. And $FV(MN)=FV(M)\cup FV(N)$ follows that $FV(MN)\subseteq\text{dom}(\Gamma)$
> > - Abstraction-Rule Case:
> > $\mathcal{J}$ has the form $\Gamma\vdash\lambda x:\sigma.M:\sigma\to\tau$ and we should prove $FV(\lambda x:\sigma.M)\in\text{dom}(\Gamma)$. By induction the lemma already holds for premiss $\Gamma,x:\sigma\vdash M:\tau$ so $FV(M)\subseteq\text{dom}(\Gamma)\cup\{x\}$ Now $FV(\lambda x:\sigma.M)=FV(M)-\{x\}$ follows $FV(M)-\{x\}\subseteq\text{dom}(\Gamma)$ 

Each free variable $x$ that occurs in $L$ has a type which is recorded in a declaration $x:\alpha$ occurring in the context $\Gamma$.

> [!lemma] Thinning, Condensing and Permutation
>  - (Thinning) Let $\Gamma'$ and $\Gamma$ be contexts st $\Gamma'\subseteq\Gamma$. If $\Gamma'\vdash M:\sigma$ then also $\Gamma\vdash M:\sigma$
>   - (Condensing) If $\Gamma\vdash M:\sigma$ then also $\Gamma\upharpoonright FV(M)\vdash M:\sigma$ 
>   - (Permutation) If $\Gamma\vdash M:\sigma$ and $\Gamma'$ is a permutation of $\Gamma$ then $\Gamma'$ is also a context and moreover $\Gamma'\vdash M:\sigma$ 

One can also define a context as a set not a list.  (In later discussion we have dependent declarations so there the order is important)

> [!lemma] Generation lemma
> - $\Gamma\vdash x:\sigma\implies x:\sigma\in\Gamma$
> - $\Gamma\vdash MN:\tau\implies\exists\sigma$ st $\Gamma\vdash M:\sigma\to\tau$ and $\Gamma\vdash N:\sigma$
> - $\Gamma\vdash\lambda x:\sigma.M:\rho\implies\exists\tau$ st $\Gamma,x:\sigma\vdash M:\tau$ and $\rho\equiv\alpha\to\tau$

Here the subterm  is defined in the untyped lambda calculus
> [!lemma] Subterm Lemma
> If $M$ is legal then every subterm of $M$ is legal

A term may have at most one type. Therefore type is unique if exists.

> [!theorem] Decidability in $\lambda\to$
> The following problems are decidable:
> - Well typedness: $?\vdash\text{term}:?$
> 	- Type assignment: $\text{context}\vdash\text{term}:?$
> - Type Checking: $\text{context}\vdash^?\text{term}:\text{type}$
> - Term Finding: $\text{context}\vdash?:\text{type}$

### Reduction and $\lambda\to$
> [!lemma] Substitution Lemma
> Assume $\Gamma',x:\alpha,\Gamma''\vdash M:\tau$ and $\Gamma'\vdash N:\sigma$ then $\Gamma',\Gamma''\vdash M[x:=N]$ 
> > [!tip] Proof
> > Let $\mathcal{J}\equiv\Gamma',x:\alpha,\Gamma''\vdash M$ be a judgement and we will do induction on it.
> > Look at the most complicated case when $M$ is an abstraction $M\equiv\lambda u:\rho.L$. Consequently $\tau$ must be $\rho\to\zeta$ for some type $\zeta$ so $$\mathcal{J}\equiv\Gamma',x:\alpha,\Gamma''\vdash\lambda u:\rho.L:\rho\to\zeta$$
> > By the abstraction rule we must have an instance
> > $$\mathcal{J}' \equiv\Gamma',x:\alpha,\Gamma'',u:\rho\vdash L:\zeta$$
> > The well-formedness of the context $\mathcal{J}'$ implies that $u$ cant be a subject variable in $\Gamma'$. Hence $\Gamma'\vdash N:\sigma$ and by the Free Variable Lemma we have that $u\not\in FV(N)$
> > By the induction the lemma already holds for $\mathcal{J}'$:
> > $$\Gamma',\Gamma'',u:\rho\vdash L[x:=N]:\zeta$$
> > Now apply the abstraction rule for the judgement
> > $$\Gamma',\Gamma''\vdash\lambda u:\rho. (L[x:=N]):\rho\to\zeta$$
> > which is the same as
> > $$\Gamma',\Gamma''\vdash(\lambda u:\rho. L[x:=N]):\rho\to\zeta$$
> > hence 
> > $$\Gamma',\Gamma''\vdash M[x:=N]:\tau$$

If we do substitute in a legal term $M$, all occurrences of context variable $x$ by a term $N$ of the same type as $x$, then the result keeps the same type as $M$ had.

The validity of the premiss $\Gamma'\vdash N:\sigma$ without the declaration $x:\sigma$ in the context implies that $x$ does not occur free in $N$. That's why the declaration $x:\sigma$ has been omitted in the final judgement since $x$ consequently also does not occur free in $M[x:=N]$

> [!definition] One-step $\beta\text{-reduction}$
> - Basic: $(\lambda x:\sigma.M)N\to_\beta M[x:=N]$
> - Compatibility: If $M \to_\beta N$ then $ML \to_\beta NL$, $LM \to _\beta LN$ and $\lambda x:\tau .M \to_\beta \lambda x:\tau .N$

The definition of zero-or-more-step reduction, $\twoheadrightarrow_\beta$ and $=_\beta$ is the same as untyped lambda calculus.

The Church-Rosser Theorem also holds for $\lambda\to$

> [!lemma] Subject Reduction
> $\Gamma\vdash L:\rho\land L\twoheadrightarrow_\beta L'\implies\Gamma\vdash L':\rho$ 

There are no infinite reduction sequences in $\lambda\to$ 

> [!theorem] Strong Normalization Theorem (Termination Theorem)
> Every legal $M$ is strongly normalizing

Then termination theorem guarantees an outcome whatever reduction path we choose/

> [!info] History
> Algol 60 was one of the first well-structured, high level programming languages in the history of computer science but unfortunately termination was not guaranteed.
> This is **unavoidable** because every programming languages of sufficient power has non-terminating programs

Though termination theorem guarantees termination within a finite amount of time but this may nevertheless waiting a long time. 
There is no upper bound on finiteness. 

### Consequences
- There is no self-application in $\lambda\to$
- Existence of $\beta\text{-normal forms}$ is guaranteed
- Not every legal $\lambda\text{-term}$ has a fixed point

### Conclusion
- The only way to construct other types is by repeatedly writing the binary $\to\text{-symbol}$ 
- We no longer have fixed points for every function
- $\lambda\to$ is much too weak to encapsulate all computable functions and is hence not usable for the formalization of mathematics

## Second order typed lambda calculus
### Type abstraction and type application
