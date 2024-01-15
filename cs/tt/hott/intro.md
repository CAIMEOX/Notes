# 15-819 Homotopy Type Theory
- These notes summarize the lectures on HoTT by *Professor Robert Harper*. 
- Also refer to notes by Henry DeYoung and Stephanie Balzer

## Introduction to homotopy type theory
### HoTT in a nutshell
HoTT is based on Per Martin-Lof's **intuitionistic type theory**, which provides a foundation for intuitionistic mathematics and which is an extension of Brouwer’s program (Constructive Viewpoint). 

At Brouwer's view, intuitionistic theories view proofs as the fundamental forms of construction. The notion of **proof relevance** is thus a characteristic feature of a constructive approach.

In the context of HoTT, proof relevance means that proofs become mathematical objects. A formal proof is a proof given in a fixed **formal system**, such as the axiomatic theory of sets, and arises from the
application of the inductively defined rules in that system.

The Godel Incompleteness Theorem: there exists true propositions (with a proof) but for which there cannot be given a formal proof using the rules of the formal system. HoTT accepts proofs that cannot be formalized in HoTT.

HoTT facilitates some axiomatic freedom which means in particular that exists *fewer* assumptions that apply globally.

Though traditional formulations of homotopy theory are **analytic**, HoTT is **synthetic**.

### HoTT in type theory context
HoTT unites homotopy theory with type theory by embodying Brouwer's intuitionism and drawing from Gentzen's proof theory.

#### Intensional type theory
Intensional type theory (ITT) is a intuitionistic type theory that serves as the core theory for other type theories. Other type theories are merely extensions of ITT.

#### Extensional type theory
Extensional type theory (ETT) extends ITT with **equality of reflection (ER)** and **uniqueness of identity proofs (UIP)**

#### Homotopy type theory
HoTT extends ITT with **higher inductive types (HIT)** and the **univalence axiom (UA)**.

Since types are perceived as abstract spaces in HoTT, HoTT gives rise to a intuitionistic theory of weak infinity groupoids.

## Intuitionistic propositional logic
Intuitionistic logic is a proof-relevant logic. (Logic as if people matter!). A modern presentation of IPL distinguishes the notions of **judgment** (sth we may be known) and **proposition** (sth that sensibly may be the subject of a judgment).

The two most basic judgments are A prop and A true:
- A prop: A is a well-formed proposition
  - Inference rules for the prop judgement are called formation rules.
- A true: Proposition A is intuitionistically true, i.e. has a proof.
  - Inference rules for it are divided into classes: **introduction rules** and **elimination rules**

Following Martin-Lof, the **meaning of a proposition A** is given by the introduction rules for the judgement A true. The elimination rule describe what may be deduced from a proof of A true.

The principle of **internal coherence** (Gentzen’s principle of inversion): The elimination rules should be strong enough to deduce all information that was used to introduce A (**local completeness**), but not so strong as to deduce information that might not have been used to introduce A (**local soundness**)

### Negative fragment of IPL
#### Conjunction
$$
\frac{A \text{prop}\quad B \text{prop}}{
    A \land B \text{prop}
}\land F
$$

A verification of $A\land B$ consists of a proof of A true paired with a proof of B true.
$$
\frac{A \text{true}\quad B \text{true}}{
    A \land B \text{true}
}\land I
$$

And we have elimination rule:
$$
\frac{A \text{prop}\land B \text{true}}{
    A \text{true}
}\land E_1
\\ \\
\frac{A \text{prop}\land B \text{true}}{
    B \text{true}
}\land E_2
$$

If we mistakenly omitted the $\land E_2$ elimination rule, then there would be no way to extract the proof of B true, the elimination rules would be took weak.

#### Truth
A simple proposition is **truth** which we write as $\top$.

$$
\frac{}{\top\text{ prop}}\top F
$$

We must say how to introduce the judgment that $\top$ is true.

$$
\frac{}{\top\text{ true}}\top I
$$

And from proof of $\top\text{ true}$ what can we deduce? Since $\top$ is trivially true hence any elimination rule would not increase out knowledge.

> The nullary conjunction: $\top$ behaves as a nullary conjunction, a conjunction over the empty set of conjuncts (Note the inference rules)

#### Entailment 
The last form of proposition in the negative fragment of IPL is implication. A different form of judgment is required (**entailment**, also known as logical consequence or a hypothetical judgment) to define implication.

$$
A_1\text{ true},\dots,A_n\text{ true}\vdash A\text{ true}
$$

expresses the idea that the judgment A true follows from $A_1\text{ true},\dots,A_n\text{ true}$ (assumptions from which conclusion A true may be deduced).

The inference rules have been presented in a **local form** in which the context of assumptions was left implicit.

The judgment form satisfies several structural properties: reflexivity, transitivity, weakening, contraction, and permutation.

- Reflexivity: An assumption is enough to conclude the same judgment.
- Transitivity (proof inlining): If you prove a lemma (A true), then you are justified in using it to prove a theorem that explicitly depends on A true $\vdash$ C true. Taken together they are *viewed* as a direct proof of the theorem (C true).

Reflexivity and transitivity are **undeniable properties** of entailment because they give meaning to assumptions, which are strong enough to prove conclusions, but are **only** as strong as the proofs they stand for.

There are also structural properties that can be denied: weakening, contraction, and permutation. Logics that deny any of these properties are called **substructural logics**.

- Weakening:  we can add assumptions to a proof without invalidating that proof.
  - Denying weakening leads, in part, to **relevance logic** (proof may not contain the unnecessary assumptions)
- Contraction:  we are unconcerned about the number of copies of an assumption A true.
  - Denying contraction (along with weakening) leads to **linear logic** ( a powerful way to express consumable resources)
- Permutation: the order of assumptions does not matter
  - Denying permutation (along with weakening and contraction) leads to **ordered** or **noncommutative logic** (powerful way to express ordered structures, like lists or even formal grammars. )

#### Implication
