module Negation where

open import Relation.Binary.PropositionalEquality using (_≡_; refl)
open import Data.Nat using (ℕ; zero; suc)
open import Data.Empty using (⊥; ⊥-elim)
open import Data.Sum using (_⊎_; inj₁; inj₂)
open import Data.Product using (_×_)
open import Isomorphism using (_≃_; extensionality)

-- Reductio ad Absurdum
¬_ : Set → Set
¬ A = A → ⊥

-- A special case of →-elim
¬-elim : ∀ {A : Set} → ¬ A → A → ⊥
¬-elim ¬x x = ¬x x

infix 3 ¬_

-- ¬ ¬ A = ¬ ( ¬ A ) = ¬ A → ⊥
¬¬-intro : ∀ {A : Set} → A → ¬ ¬ A
¬¬-intro x = λ ¬A → ¬A x
-- We cannot prove the reverse

¬¬¬-elim : ∀ {A : Set} → ¬ ¬ ¬ A → ¬ A
¬¬¬-elim x = λ y → x (¬¬-intro y)

-- contraposition
contraposition : ∀ {A B : Set} → (A → B) → (¬ B → ¬ A)
contraposition f = λ x y → x (f y)

_≢_ : ∀ {A : Set} → A → A → Set
x ≢ y = ¬ (x ≡ y)

-- Lambda absurd pattern
_ : 1 ≢ 2
_ = λ()

peano : ∀ {m : ℕ} → zero ≢ suc m 
peano = λ()

id : ⊥ → ⊥
id ()

