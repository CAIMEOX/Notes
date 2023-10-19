# Complex Number

- $\overline{z+w}=\overline{z}+\overline{w}$
- $\overline{zw} = \overline{z}\cdot\overline{w}$
- $z+\overline{z}=2Re(z)$
- $z-\overline{z}=2Im(z)$
- $z\overline{z}\in\mathbb{R}$
- $|z|=\sqrt{z\overline{z}}$

## Schwarz Inequality
If $a_1,a_2,\dots, a_n$ and $b_1,b_2,\cdots,b_n$ be complex numbers then
$$|\sum(a_i\bar{b_i})|^2\leq \sum|a_i|^2 \sum|b_i|^2$$

**Proof**: 
Let $A=\sum|a_i|^2$, $B=\sum|b_i|^2$ and $C=\sum|a_i\bar{b}_i|^2$
- $B=0$ : Trivially true
- $B>0$ : 
$$\begin{align*}
    \sum|Ba_i-Cb_i|^2&=\sum(Ba_i-Cb_i)(B\bar{a}_i-\overline{Cb_i}) 
    \\ &=B^2\sum|a_i|^2-B\overline{C}\sum a_i\overline{b_i}-BC\sum \bar{a}_ib_i+|C|^2\sum |b_i|^2
    \\ &= B^2A-B|C|^2
    \\ &= B(AB-|C|^2)\geq 0
\end{align*}$$
hence $AB-|C|^2\geq 0$.
