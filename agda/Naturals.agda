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

