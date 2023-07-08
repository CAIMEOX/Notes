## Getting started with Agda

> This note is based on Lecture: Introduction to Univalent Foundations of Mathematics with Agda
 
```agda
{-# OPTIONS --without-K --exact-split --safe --auto-inline #-}
```

- `without-K` disables Streicher's K axiom
- `exact-split` only accept definition with equality sign `=` behaves like judgemental equalities
- `safe` disables inconsistent features


```agda
module HoTT-UF where
```

### Type Universes
- Families of types indexed by a type x as functions x → 𝓤 , which is sometimes seen as a property of elements of x
- We can define types of math structures such as monoids , groups and etc by using universes

We work with a tower of type universe : 𝓤₀, 𝓤₁, 𝓤₂, 𝓤₃, ...

- Levels (Universe name) : 𝟙 : 𝓤₀̇
    - We reference the universes themselves by a **almost-invisible** superscript dot
- For given universe 𝓤 we denote 𝓤⁺ for its successor universe
    - 𝓤 ̇ : 𝓤 ⁺ ̇
- The least upper bound of 𝓤 and 𝓥 is written 𝓤 ⊔ 𝓥 
    - For example, if 𝓤 is 𝓤₀ and 𝓥 is 𝓤₁, then 𝓤 ⊔ 𝓥 is 𝓤₁.

```agda 
open import Universes public

variable 𝓤 𝓥 𝓦 𝓣 : Universe
```

### The one-element type 𝟙 

```agda 
data 𝟙 : 𝓤₀ ̇  where 
    ⋆ : 𝟙
```

### 𝟙-induction 

```agda
𝟙-induction : (A : 𝟙 → 𝓤 ̇ ) → (a : A ⋆) → (x : 𝟙) → A x
𝟙-induction A a ⋆ = a
``` 

- 𝟙 → 𝓤 is a property function for some universe
- A x  doesn't need to be a **truth value** instead it can be any type
- We want prove " For any given property A of elements of the type 𝟙, if A ⋆ holds, then it follows that A x holds for all x : 𝟙 "
- We supply A and a as arbitrary but x : 𝟙 we write ⋆ .Pattern matching happens here.

We can write a particular case of 𝟙-induction occurs when the family A is constant B

- A x = B 

or 

- A = λ (x : 𝟙) → B

or

- A = λ x → B 

or 

- A = λ _ → B 

Given a type B and a point b : B, we can construct function 𝟙 → B maps any given x : 𝟙 to b

```agda
𝟙-recursion : (B : 𝓤 ̇ ) → B → 𝟙 → B
𝟙-recursion B b x = 𝟙-induction (λ _ → B) b x
```

- The function symbol → is right associative.

#### The unique function to 𝟙:

```agda 
!𝟙' : ( X : 𝓤 ̇ ) → X → 𝟙
!𝟙' X x = ⋆
```

implicit arguments 
```agda 
!𝟙 : { X : 𝓤 ̇  } → X → 𝟙
!𝟙 x = ⋆
```

We can recover the type x with x : X from the context. When agda can't figure it out :

- !𝟙 {𝓤} {X} x 

### The empty type 𝟘

```agda 
data 𝟘 : 𝓤₀ ̇  where
```

That's the complete definition. This has a dual interpretation , mathematically the empty set, logically the truth value *false* .

To prove a property of elements of empty type holds for all elements of the empty type , we have to do **nothing**!

```agda 
𝟘-induction : (A : 𝟘 → 𝓤 ̇ ) → (x : 𝟘) → A x 
𝟘-induction A ()
```

The expression () corresponds to the mathematical phrase **vacuously true**

```agda 
𝟘-recursion : (A : 𝓤 ̇ ) → 𝟘 → A
𝟘-recursion A a = 𝟘-induction (λ _ → A) a
```

and we define 
```agda 
!𝟘 : (A : 𝓤 ̇ ) → 𝟘 → A 
!𝟘 = 𝟘-recursion   
```
