# Lambda Calculus
## Untyped Lambda Calculus
### Functions
Construction principles:
- Abstraction: From an expression $M$ and a variable $x$ we can construct a new expression $\lambda x.M$. (Abstraction of $x$ over $M$)
- Application: For expression $M$ and $N$ we can construct new expression $M \ N$.(Application of $M$ to $N$)

(Note: The construction principle allows expressions which do not have an obvious meaning)

$\beta\text{-reduction}$ (Calculation rule):
$(\lambda x . M) N$ can be rewritten to the expression $M[x := N]$ (i.e. the expression M in which every $x$ has been replaced with $N$)

(Note: the application of $M$ to $N$ is not the result of applying $M$ to $N$, but the first step, in which the functions has not yet been executed)

(History: The idea of currying dates back to the work by M. Schonfinkel)

### Lambda terms
(History: Lambda calculus was invented by A. Church in the 1930s)

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

Notes:
- Parentheses in an outermost position may be omitted.
- Application is left-associative
- Successive abstractions maybe combined in a right-associative way under $\lambda$. (e.g. $\lambda xy .M \equiv \lambda x .(\lambda y .M)$)

### Free and bound variables

$FV$, the set of Free variables of a $\lambda\text{-term}$
- (Variable) $FV(x) = \{x\}$
- (Application) $FV(MN) = FV(M) \cup FV(N)$
- (Abstraction) $FV(\lambda x.M)=FV(M) -\{x\}$

**Combinator**:
A $\lambda\text{-term}$ is closed if $FV(M) = \emptyset$ , which is also called a combinator.
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

(Note: The terms of the form $P[x:=N]$ are not $\lambda\text{-terms}$)

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

Suppose that for a given $\lambda\text{-term} M$ we have $M \twoheadrightarrow_\beta N_1$ and $M \twoheadrightarrow_\beta N_2$ then there is a $\lambda\text{-term}$ $N_3$ such that $N_1 \twoheadrightarrow_\beta N_3$ and $N_2 \twoheadrightarrow_\beta N_3$

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
$\forall L \in \Lambda$ there is $M\in \Lambda $ such that $LM =_\beta M$

Proof: For given $L$ define $M:=(\lambda x.L(xx))(\lambda x.L(xx))$. $M$ is a redex hence:
$$M \to_\beta L((\lambda x.L(xx))(\lambda x.L(xx))) \equiv LM$$

Fixed Point combinator:
$$Y \equiv \lambda y . (\lambda x . y (xx)) (\lambda x . y (xx))$$

$YL$ is fixed point of $L$ since:
$$YL \to_\beta M \to_\beta LM =_\beta L(YL)$$

Notes: 
- A number of recursive equations can be solved by means of fixed points
- Untyped Lambda Calculus is Turning-complete
- Combinatory logic can be seen as the lambda calculus restricted to the terms $\text{K}:= \lambda xy.x$ and $\text{S}:=\lambda xyz . x \ z ( y z ) $. This system is simpler than lambda calculus but slightly more difficult to work with
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
- The empty context is denoted as $\emptyset$

**Logic** (Natural deduction):
- $\dfrac{A\implies B \quad A} {B} (\implies\text{-elim})$

- $\dfrac{\text{Assume A} \quad\cdots\quad B}{A\implies B}$
