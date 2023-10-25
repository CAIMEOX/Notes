## The derivative of a real function
> [!definition] 
> Let $f:[a,b]\to\mathbb{R}$
> $$f'(x)=\lim_{t\to x}\frac{f(t)-f(x)}{t-x} (a<t<b,t\not ={x})$$
> If the limit exists, call $f'(x)$ the derivative of $f$ at $x$. If $f'$ is **defined** at point $x$ say $f$ is **differentiable** at $x$

The continuous but nowhere differentiable function:
> [!example] Weierstrass Function
> $$W(x)=\sum_{n=0}^\infty a^n cos(b^n\pi x)$$
> where $0<a<1$ and $b$ is a positive odd integer st $ab>1+\frac{3}{2}\pi$.

## The algebra of derivatives

> [!theorem]
> Suppose $f$ and $g$ are defined on interval $[a,b]$ and are differentiable at a point $x\in[a,b]$.
> - $(f+g)'(x)=f'(x)+g'(x)$ (Differentiation is linear)
> - $(fg)'(x)=f'(x)g(x)+f(x)g'(x)$ (Product rule)
> - $(\dfrac{f}{g})'(x)=\dfrac{g(x)f'(x)-g'(x)f(x)}{g^2(x)}$ (Quotient rule)

### Chain Rule

> [!theorem] Chain Rule
> Suppose $f$ is continuous on $E$ and $f'(x)$ exists at point $x\in E$. $g$ is defined on an interval $I$ which contains the range of $f$ and $g$ is differentiable at the point $f(x)$.
> If $h(t)=g(f(t)) (t\in E)$ then $h$ is differentiable at point $f(x)$ and
> $$h'(x)=g'(f(x))f'(x)$$ 

### Inverse Function Rule
> [!theorem] Inverse Function Rule
> If $g$ is the inverse function of continuous function $f$, i.e. $f(g(x))=x$ and differentiable. Then we have:
> $$g'(x)={\frac {1}{f'\circ g(x)}}$$

### Generalize Leibniz Rule
> [!theorem] Leibniz Rule
> If $f$ and $g$ are $n$-times differentiable functions, then the product $fg$ is also 
$n$-times differentiable and its nth derivative is given by
> $$(fg)^{(n)}=\sum _{k=0}^{n}{n \choose k}f^{(n-k)}g^{(k)},$$
> > [!tip] Proof
> > The proof proceeds by induction.
> > - Base case ($n=1$): $(fg)'=f'g+fg'$
> > - Induction Step: We assume Leibniz rule holds for $n\geq 1$: $$(fg)^{(n)}=\sum _{k=0}^{n}{\binom {n}{k}}f^{(n-k)}g^{(k)}.$$ 
> > - We prove it holds for $n+1$: $${\begin{aligned}(fg)^{(n+1)}&=\left[\sum _{k=0}^{n}{\binom {n}{k}}f^{(n-k)}g^{(k)}\right]'\\&=\sum _{k=0}^{n}{\binom {n}{k}}f^{(n+1-k)}g^{(k)}+\sum _{k=0}^{n}{\binom {n}{k}}f^{(n-k)}g^{(k+1)}\\&=\sum _{k=0}^{n}{\binom {n}{k}}f^{(n+1-k)}g^{(k)}+\sum _{k=1}^{n+1}{\binom {n}{k-1}}f^{(n+1-k)}g^{(k)}\\&={\binom {n}{0}}f^{(n+1)}g^{(0)}+\sum _{k=1}^{n}{\binom {n}{k}}f^{(n+1-k)}g^{(k)}+\sum _{k=1}^{n}{\binom {n}{k-1}}f^{(n+1-k)}g^{(k)}+{\binom {n}{n}}f^{(0)}g^{(n+1)}\\&={\binom {n+1}{0}}f^{(n+1)}g^{(0)}+\left(\sum _{k=1}^{n}\left[{\binom {n}{k-1}}+{\binom {n}{k}}\right]f^{(n+1-k)}g^{(k)}\right)+{\binom {n+1}{n+1}}f^{(0)}g^{(n+1)}\\&={\binom {n+1}{0}}f^{(n+1)}g^{(0)}+\sum _{k=1}^{n}{\binom {n+1}{k}}f^{(n+1-k)}g^{(k)}+{\binom {n+1}{n+1}}f^{(0)}g^{(n+1)}\\&=\sum _{k=0}^{n+1}{\binom {n+1}{k}}f^{(n+1-k)}g^{(k)}.\end{aligned}}$$

## Mean Value Theorems
> [!definition]
> Let $f$ be a real function defined on a metric space $X$ and $f$ has a maximum at point $p\in X$ if there exists $\delta>0$ st $\forall q\in X,f(q)\leq f(p)$ with $d(p,q)<\delta$

> [!theorem] 
> Let $f:E\to\mathbb{R}$. $f$ has a local maximum at $x\in E$ if $f'(x)$ exists and $f'(x)=0$

### Rolle's Theorem
> [!theorem] Rolle's Theorem
> Let $f:[a,b]\to\mathbb{R}$ be a continuous function which is differentiable in $(a,b)$ and $f(a)=f(b)$. Then $\exists c\in(a,b)$ st $f'(c)=0$

### General Mean Value Theorem
> [!theorem] General Mean Value Theorem 
> If $f,g:[a,b]\to\mathbb{R}$ are continuous on $[a,b]$ are differentiable in $(a,b)$ then $\exists x\in(a,b)$ st
> $$\frac{f(b)-f(a)}{g(b)-g(a)}=\frac{f'(x)}{g'(x)}$$
> > [!tip] Proof Sketch
> > Let $h(t) = ((f(b)-f(a))g(t)-(g(b)-g(a))f(t) (a\leq t\leq b)$

### Mean Value Theorem
> [!theorem] Mean Value Theorem
> Let $f:[a,b]\to\mathbb{R}$ be a continuous function which is differentiable in $(a,b)$, then $\exists c\in(a,b)$ st 
> $$f(b)-f(a)=(b-a)f'(x)$$

By mean value theorem we can easily write down the connection between monotonically function and sign of $f'(x)$. Just notice that:

$$
f(x_2)-f(x_1)=(x_2-x_1)f'(x)
$$
