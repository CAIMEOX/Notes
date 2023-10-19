module Naturals where

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; cong; sym)
open Eq.≡-Reasoning using (begin_; _≡⟨⟩_; _∎; step-≡)

data ℕ : Set  where 
    zero : ℕ
    suc  : ℕ → ℕ

{-# BUILTIN NATURAL ℕ #-}

-- Addition
_+_ : ℕ → ℕ → ℕ
zero + n = n
(suc m) + n = suc (m + n)

-- Multiplication
_*_ : ℕ → ℕ → ℕ
zero * n = zero
(suc m) * n = n + (m * n)

-- Power
_^_ : ℕ → ℕ → ℕ
m ^ 0 = 1
m ^ (suc n) = m * (m ^ n)

-- Monus
_∸_ : ℕ → ℕ → ℕ
0 ∸ n = 0
n ∸ 0 = n
suc m ∸ suc n = m ∸ n

infixl 6 _+_ _∸_
infixl 7 _*_
infixl 8 _^_

-- Associativity
+-assoc : ∀ (m n p : ℕ) → (m + n) + p ≡ m + (n + p)
+-assoc zero n p = 
    begin
        (zero + n) + p
    ≡⟨⟩
        n + p
    ≡⟨⟩
        zero + (n + p)
    ∎
+-assoc (suc m) n p =
    begin
        (suc m + n) + p
    ≡⟨⟩
        suc (m + n) + p
    ≡⟨⟩
        suc ((m + n) + p)
    -- Congruence
    ≡⟨ cong suc (+-assoc m n p) ⟩
        suc m + (n + p)
    ∎

-- Use rewrite
+-assoc' : ∀ (m n p : ℕ) → (m + n) + p ≡ m + (n + p)
+-assoc' zero n p = refl
+-assoc' (suc m) n p rewrite +-assoc' m n p = refl

-- (Right) Identity Law
+-Identity : ∀ (m : ℕ) → m + zero ≡ m
+-Identity zero =
    begin
        zero + zero
    ≡⟨⟩
        zero
    ∎
+-Identity (suc n) = 
    begin
        suc n + zero
    ≡⟨⟩
        suc (n + zero)
    ≡⟨ cong suc (+-Identity n) ⟩
        suc n
    ∎

+-Identity' : ∀ (m : ℕ) → m + zero ≡ m
+-Identity' 0 = refl
+-Identity' (suc n)  rewrite +-Identity' n = refl

*-Identity : ∀ (m : ℕ) →  m * 0 ≡ 0
*-Identity 0 = refl
*-Identity (suc m) rewrite *-Identity m = refl

-- (Right) successor
+-suc : ∀ (m n : ℕ) → m + suc  n ≡ suc (m + n)
+-suc zero n = 
    begin
        zero + suc n
    ≡⟨⟩
        suc n
    ≡⟨⟩
        suc (zero + n)
    ∎ 
+-suc (suc m) n =
    begin
        suc m + suc n
    ≡⟨⟩
        suc (m + suc n)
    ≡⟨ cong suc (+-suc m n)⟩
        suc ( suc (m + n))
    ≡⟨⟩
        suc (suc m + n)
    ∎

+-suc' : ∀ (m n : ℕ) → m + suc  n ≡ suc (m + n)
+-suc' 0 n = refl
+-suc' (suc m) n  rewrite +-suc' m n = refl



-- Commutativity
+-comm : ∀ (m n : ℕ) → m + n ≡ n + m
+-comm m 0 =
    begin
        m + 0
    ≡⟨ +-Identity m ⟩
        m
    ≡⟨⟩
        0 + m
    ∎
+-comm m (suc n) =
    begin
        m + (suc n)
    ≡⟨ +-suc m n ⟩
        suc (m + n)
    ≡⟨ cong suc (+-comm m n)⟩ 
        suc (n + m)  
    ≡⟨⟩
        suc n + m
    ∎

+-comm' : ∀ (m n : ℕ) → m + n ≡ n + m
+-comm' m 0 rewrite +-Identity m = refl
+-comm' m (suc n) rewrite +-suc m n | +-comm m n = refl

*-suc : ∀ (m n : ℕ) → m * suc  n ≡ m + (m * n)
*-suc 0 n = refl
*-suc (suc m) n  
    rewrite *-suc m n 
    |  *-suc m n 
    | sym (+-assoc n m (m * n))
    | sym (+-comm m n)
    | +-assoc m n (m * n)  = refl

-- Rearrange
+-rearrange : ∀ (m n p q : ℕ) → (m + n) + (p + q) ≡ m + (n + p) + q
+-rearrange m n p q =
    begin
        (m + n) + (p + q)
    ≡⟨ sym (+-assoc (m + n) p q) ⟩
        ((m + n) + p) + q
    -- Add + q at the right side
    ≡⟨ cong (_+ q) (+-assoc m n p) ⟩
        (m + (n + p)) + q
    ∎

+-swap : ∀ (m n p : ℕ) → m + (n + p) ≡ n + (m + p)
+-swap m n p 
    rewrite sym (+-assoc m n p ) 
    | +-comm m n 
    | +-assoc n m p = refl

*-distribute-+ : ∀ (m n p : ℕ) → (m + n) * p ≡ m * p + n * p
*-distribute-+ zero n p = refl
*-distribute-+ (suc m) n p 
    rewrite *-distribute-+ m n p 
    | sym ( +-assoc p (m * p) (n * p))= refl
  

*-assoc : ∀ (m n p : ℕ) → (m * n) * p ≡ m * (n * p)
*-assoc zero n p = refl
*-assoc (suc m) n p 
    rewrite *-assoc m m p
    | *-distribute-+ n (m * n) p
    |  cong (_+_ (n * p)) (*-assoc m n p)= refl 

*-comm : ∀ (m n : ℕ) → m * n ≡ n * m 
*-comm zero n rewrite *-Identity n = refl
*-comm (suc m) n 
    rewrite (*-comm m n)
    | sym (*-suc n m) = refl

-- Relations
data _≤_ : ℕ → ℕ → Set where
    -- Bracket {} means implicit arguments
    z≤n : ∀ {n : ℕ} → zero ≤ n
    s≤s : ∀ {m n : ℕ} → m ≤ n → suc m ≤ suc n

infixl 4 _≤_

-- Invert the rule
inv-z≤n : ∀ {m : ℕ} → m ≤ 0 → m ≡ 0
inv-z≤n {m} z≤n = refl

inv-s≤s : ∀ {m n : ℕ} → suc m ≤ suc n → m ≤ n
inv-s≤s (s≤s m≤n) = m≤n

-- Reflexivity
≤-refl : ∀ {n : ℕ} → n ≤ n
≤-refl {0} = z≤n
≤-refl {suc n} = s≤s ≤-refl 

-- Transitivity
≤-trans : ∀ {m n p : ℕ} → m ≤ n → n ≤ p → m ≤ p
≤-trans z≤n _ = z≤n
≤-trans (s≤s m≤n) (s≤s n≤p) = s≤s (≤-trans m≤n n≤p)

-- Antisymmetry
≤-antisym : ∀ {m n : ℕ} → m ≤ n → n ≤ m → n ≡ m
≤-antisym z≤n z≤n = refl
≤-antisym (s≤s m≤n) (s≤s n≤m) = cong suc (≤-antisym m≤n n≤m)

data Total : ℕ → ℕ → Set where
    forward : ∀ {m n : ℕ} → m ≤ n → Total m n
    flipped : ∀ {m n : ℕ} → n ≤ m → Total m n

data Total' (m n : ℕ) : Set where
    forward : m ≤ n → Total' m n
    flipped : n ≤ m → Total' m n

-- May use disjunction here

≤-total : ∀ (m  n : ℕ) → Total m n
≤-total 0 n = forward z≤n
≤-total n 0 = flipped z≤n
≤-total (suc m) (suc n) with ≤-total m n
...    | forward m≤n = forward (s≤s m≤n)
...    | flipped n≤m = flipped (s≤s n≤m) 

-- Helper function
≤-total' : ∀ (m  n : ℕ) → Total m n
≤-total' 0 n = forward z≤n
≤-total' n 0 = flipped z≤n
≤-total' (suc m) (suc n) = h (≤-total' m n) where
    h : Total m n → Total (suc m) (suc n)
    h (forward m≤n) = forward (s≤s m≤n)
    h (flipped n≤m) = flipped (s≤s n≤m)
    
-- Monotonic over Addition
+-mono_right-≤ : ∀ (n p q : ℕ) → p ≤ q → n + p ≤ n + q
+-mono_right-≤ 0 p q p≤q = p≤q
+-mono_right-≤ (suc n) p q p≤q = s≤s (+-mono_right-≤ n p q p≤q)

+-mono_left-≤ : ∀ (n p q : ℕ) → p ≤ q → p + n ≤ q + n
+-mono_left-≤ n p q p≤q rewrite +-comm p n | +-comm q n =  +-mono_right-≤ n p q p≤q

+-mono-≤ : ∀ (m n p q : ℕ) → m ≤ n → p ≤ q → m + p ≤ n + q
+-mono-≤ m n p q m≤n p≤q = ≤-trans (+-mono_left-≤ p m n m≤n) (+-mono_right-≤ n p q p≤q) 

-- Monotonic over Multiplication
*-mono_right-≤ : ∀ (n p q : ℕ) → p ≤ q → n * p ≤ n * q
*-mono_right-≤ 0 p q p≤q = z≤n
*-mono_right-≤ (suc n) p q p≤q = +-mono-≤ p q (n * p) (n * q) p≤q (*-mono_right-≤ n p q p≤q) 

*-mono_left-≤ : ∀ (n p q : ℕ) → p ≤ q → p * n ≤ q * n
*-mono_left-≤ n p q p≤q rewrite *-comm p n | *-comm q n = *-mono_right-≤ n p q p≤q 

*-mono-≤ : ∀ (m n p q : ℕ) → m ≤ n → p ≤ q → m * p ≤ n * q
*-mono-≤ m n p q m≤n p≤q = ≤-trans (*-mono_left-≤ p m n m≤n) (*-mono_right-≤ n p q p≤q)

data _<_ : ℕ → ℕ → Set where
    z<s : ∀ {n : ℕ} → 0 < n
    s<s : ∀ {m n : ℕ} → m < n → suc m < suc n

infixl 4 _<_ 

-- Transitive
<-trans : ∀ {m n p : ℕ} → m < n → n < p → m < p
<-trans z<s _ = z<s
<-trans (s<s x) (s<s y)= s<s (<-trans x y) 

-- Trichotomy
data Trichotomy : ℕ → ℕ → Set where
    forward : ∀ {m n : ℕ} → m < n → Trichotomy m n
    equal : ∀ {m n : ℕ} → m ≡ n → Trichotomy m n
    flipped : ∀ {m n : ℕ} → n < m → Trichotomy m n

<-trichotomy : ∀ (m n : ℕ) → Trichotomy m n
<-trichotomy 0 n = forward z<s
<-trichotomy n 0 = flipped z<s
<-trichotomy (suc m) (suc n) = h (<-trichotomy m n) where
    h : Trichotomy m n → Trichotomy (suc m) (suc n)
    h (forward m<n) = forward (s<s m<n)
    h (flipped n<m) = flipped (s<s n<m)
    h (equal n≡m) = equal (cong suc n≡m) 

-- Predicate
data even : ℕ → Set
data odd  : ℕ → Set 

data even where
    zero : even zero
    suc : ∀ {n : ℕ} → odd n → even (suc n)

data odd where
    suc : ∀ {n : ℕ} → even n → odd (suc n)

e+e≡e : ∀ {m n : ℕ} → even m → even n → even (m + n) 
o+e≡o : ∀ {m n : ℕ} → odd m → even n → odd (m + n)
-- o+o≡e : ∀ {m n : ℕ} → odd m → odd n → even (m + n)
e+e≡e zero n = n
e+e≡e (suc m) n = suc (o+e≡o m n)
o+e≡o (suc m) n = suc (e+e≡e m n)
