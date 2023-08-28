module Equality where


-- For any type A and x:A , refl cons proof of x≡x
data _≡_ {A : Set} (x : A) : A → Set where
  refl : x ≡ x

infixl 4 _≡_

{-# BUILTIN EQUALITY _≡_  #-}

-- Symmetry
sym : ∀ {A : Set} {x y : A} → x ≡ y → y ≡ x
sym refl = refl

-- Transitive
trans : ∀ {A : Set} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
trans refl refl = refl

-- Congruence
cong : ∀ {A B : Set} (f : A → B) {x y : A} → x ≡ y → f x ≡ f y
cong f refl = refl

cong₂ : ∀ {A B C : Set} (f : A → B → C) {m x : A} {n y : B} → m ≡ x → n ≡ y → f m n ≡ f x y 
cong₂ f refl refl = refl 

cong-fn : ∀ {A B : Set} {f g : A → B} → f ≡ g → ∀ (x : A) → f x ≡ g x
cong-fn refl _ = refl

-- Substitution
subst : ∀ {A : Set} {x y : A} (P : A → Set) → x ≡ y → P x → P y
subst P refl px = px

-- Reasoning
module ≡-Reasoning {A : Set} where
    infix 1 begin_
    infixr 2 _≡⟨⟩_ _≡⟨_⟩_
    infix 3 _∎

    -- Behaves like Identity function
    begin_ : ∀ {x y : A} → x ≡ y → x ≡ y
    begin a = a

    _≡⟨⟩_ : ∀ (x : A) {y : A} → x ≡ y → x ≡ y
    x ≡⟨⟩ x≡y = x≡y

    _≡⟨_⟩_ : ∀ (x : A) {y z : A} → x ≡ y → y ≡ z → x ≡ z
    x ≡⟨ x≡y ⟩ y≡z = trans x≡y y≡z

    -- _≡⟨⟩_ ≡ _≡⟨ refl ⟩_

    _∎ : ∀ (x : A) → x ≡ x
    x ∎ = refl

open ≡-Reasoning

trans' : ∀ {A : Set} {x y z : A} → x ≡ y → y ≡ z → x ≡ z
trans' {A} {x} {y} {z} p q =
  begin
    x
  ≡⟨ p ⟩
    y
  ≡⟨ q ⟩
    z
  ∎
-- Expand --
-- trans' (x ≡ ⟨ p ⟩ (y ≡ ⟨ q ⟩ ≡ (z ∎)))
-- trans' (x ≡ ⟨ p ⟩ (y ≡ ⟨ q ⟩ ≡ ( z ≡ z )))
-- trans' (x ≡ ⟨ p ⟩ (y ≡ z))
-- trans' (x ≡ z)
-- Equivalent to --
-- trans' p (trans q refl)

module Nat where
data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ

_+_ : ℕ → ℕ → ℕ
zero    + n  =  n
(suc m) + n  =  suc (m + n)

infixl 6 _+_

{-# BUILTIN NATURAL ℕ #-}

postulate
  +-identity : ∀ (m : ℕ) → m + zero ≡ m
  +-suc : ∀ (m n : ℕ) → m + suc n ≡ suc (m + n)
  +-comm : ∀ (m n : ℕ) → m + n ≡ n + m

data even : ℕ → Set
data odd  : ℕ → Set


data even where
  even-zero : even zero
  even-suc : ∀ {n : ℕ}
    → odd n
    → even (suc n)

data odd where
  odd-suc : ∀ {n : ℕ}
    → even n
    → odd (suc n)

open Nat

even-comm : ∀ ( m n : ℕ ) → even (m + n) → even (n + m)
even-comm m n e rewrite +-comm n m = e

-- Rewriting expanded
even-comm' : ∀ ( m n : ℕ ) → even (m + n) → even (n + m)
even-comm' m n e with   m + n  | +-comm m n 
...      | .(n + m) | refl = e

even-comm'' : ∀ (m n : ℕ) → even (m + n) → even (n + m)
even-comm'' m n = subst even (+-comm m n)

-- Leibniz Equality --
-- Identity of Indiscernibles : two objects are equal iff they have same properties
_≐_ : ∀ {A : Set} (x y : A) → Set₁
_≐_ {A} x y = ∀ (P : A → Set₀) → P x → P y

-- Note : Avoid Russell's Paradox

refl-≐ : ∀ {A : Set} {x : A} → x ≐ x
refl-≐ P Px = Px

trans-≐ : ∀ {A : Set} {x y z : A} → x ≐ y → y ≐ z → x ≐ z
trans-≐ p q P px = q P (p P px)

-- Non-trivial Proof
-- x≐y has type P x → P y
sym-≐ : ∀ {A : Set} {x y : A} → x ≐ y → y ≐ x
sym-≐ {A} {x} {y} x≐y P = Qy Qx
-- Key is to construct function Q
  where Q : A → Set
        Q z = P z → P x
        Qx : P x → P x
        Qx = refl-≐ P
        Qy : (P x → P x) → P y → P x
        Qy = x≐y Q

-- Martin-Lof equality implies Leibniz equality
≡-implies-≐ : ∀ {A : Set} {x y : A} → x ≡ y → x ≐ y
≡-implies-≐ x≡y P = subst P x≡y

≐-implies-≡ : ∀ {A : Set} {x y : A} → x ≐ y → x ≡ y
≐-implies-≡ {A} {x} {y} x≐y = Qy
  where Q : A → Set
        Q z = x ≡ z
        Qx : Q x
        Qx = refl
        Qy : Q y
        Qy = x≐y Q Qx

-- Universe Polymorphism

open import Level using (Level; _⊔_) renaming (zero to lzero; suc to lsuc)
-- Any level equality
data _≡'_ {ℓ : Level} {A : Set ℓ} (x : A) : A → Set ℓ where
  refl' : x ≡' x

sym' : ∀ {ℓ : Level} {A : Set ℓ} {x y : A} → x ≡' y → y ≡' x
sym' refl' = refl'

_≐'_ : ∀ {ℓ : Level} {A : Set ℓ} (x y : A) → Set (lsuc ℓ)
_≐'_ {ℓ} {A} x y = ∀ (P : A → Set ℓ) → P x → P y

_∘_ : ∀ {ℓ₁ ℓ₂ ℓ₃ : Level} {A : Set ℓ₁} {B : Set ℓ₂} {C : Set ℓ₃} → (B → C) → (A → B) → A → C
(g ∘ f) x  =  g (f x)
