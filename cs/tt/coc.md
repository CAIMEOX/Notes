# The Calculus of Constructions
There is only one difference between $\lambda P$ and $\lambda C$ which is enough to extend $\lambda C=\lambda 2+\lambda \underline{\omega}+\lambda P$. The difference is the formation rule:

$$
\frac
{\Gamma\vdash A:*\quad\Gamma,x:A\vdash B:s}
{\Gamma\vdash\Pi x:A.B:s}
(\text{form}_{\lambda P})
$$

In $\lambda P$ ensures $A$ is type in order to guarantee that the inhabitants of $\Pi x:A.B$ are terms or types dependent on terms only.

Compare with the form-rule in $\lambda\underline{\omega}$ which can be cross-over.
$$
\frac{
    \Gamma\vdash A:s\quad\Gamma\vdash B:s
}{
    \Gamma\vdash A\to B:s
}
(\text{form}_{\lambda\underline{\omega}})
$$

Combine the rules above:

$$
\frac{
    \Gamma\vdash A:s_1\quad\Gamma\vdash x:A\vdash B:s_2
}{
    \Gamma\vdash\Pi x:A.B:s_2
}
$$

## The $\lambda$-Cube
All eight systems can be positioned in a cube, the so called lambda cube or Barendregt Cube.

The set of rules is very simple: Apart from initialisation rules (sort, var, weak), all that we need are a formation rule for $\Pi$-Types and a conversion rule, and 2 fundamental rules for every lambda calculus system.

(The weakening rule is used to demonstrate that adding more assumptions to the context doesn't invalidate the existing typing judgments.)

## Properties of $\lambda C$
Expression of $\lambda C$ is defined by
$$
E=V|\square|*|(EE)|(\lambda V:E.E)|(\Pi V:E.E)
$$

### Free variable lemma
If $\Gamma\vdash A:B$, then $FV(A),FV(B)\subseteq\text{dom}(\Gamma)$

In Coc, well-typedness and type checking is decidable.