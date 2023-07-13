# Set Theory

## Basic Relations
$x\in A$ means that $A$ is a collection of objects, $x$ is an element of that collection. We say that $x$ belongs to $A$.


## Construct
### Tabular form
List the elements enclosed in brackets.$$\{0,1,2,3\}$$

### Set Builder form 
Specify a set by stating a property that is possessed by all the elements of the set.   

#### Principle of Comprehension
If $\phi (x)$ is a property or condition pertaining to objects $x$ then there  exists a set whose elements are precisely the objects that have the property (Or satisfy the condition) $\phi (x)$: $$\{x:\phi(x) \}$$

**Examples**:
- $\phi(x)=x\in A \land x \in B$ then we obtain the set $A\cap B$
- $\phi(x)=x\in A \lor x \in B$ then we obtain the set $A \cup B$
- $\phi(x)=x\notin A$ then we obtain the Complement Set of $A$, that is $-A$
- The empty set $\emptyset=\{x:x\neq x\}$

## Principle of Extensionality
The sets are equal iff they have the same elements.


## Subsets
A set $A$ is a subset of set $B$, written $A\subset B$

## Russell's Paradox
- Universal Set $V=\{x:x=x\}$
- Russell Set $R=\{x:x\in x\}$

### NBG
The Comprehension Principle is modified by requiring the objects $x$ referred to there to be sets:$$\{x:\phi(x)\land x \ \text{is a set} \}$$

And we have the concept of class which can be thought of bigger sets.A class which is not a set is called proper class.

### ZF
All the sets are built up from certain simple ones (We can start with $\emptyset$). The ZF axiom system prevent the construction of $R$.

In this case the Comprehension Principle can only be used relative to a given set.

#### Separation Principle 
Given a set $A$ and a condition $\phi(x)$ there exists a set whose elements are precisely those members of $A$ that satisfy $\phi(x)$. $$\{x:x\in A \land \phi(x)\}$$

## Consistency
This systems avoid Russell's Paradox but do not guarantee the consistency (Entirely free of **contradictions**).

Around 1930, Godel showed in effect that any proof of consistency would have to depend on principles whose own consistency was no more certain than that of ZF and NBG themselves.
