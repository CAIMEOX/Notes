module Connectives where

-- Propositions as types
-- Conjunction -> Product
-- Disjunction -> Sum
-- True -> Unit Type
-- False -> Empty Type
-- Implication -> Function Space

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)
open Eq.≡-Reasoning
open import Data.Nat using (ℕ)
open import Function using (_∘_)

-- Requires Isomorphism
open import Isomorphism using (_≃_; _≲_; extensionality; _⇔_)
open Isomorphism.≃-Reasoning

data _×_ (A B : Set) : Set where
    ⟨_,_⟩ : A → B → A × B -- Introduce ×-I (How to define)

-- Eliminate (How to use) : 
-- ×-E₁
left_proj : ∀ {A B : Set} → A × B → A
left_proj ⟨ x , y ⟩ = x
-- ×-E₂
right_proj : ∀ {A B : Set} → A × B → B
right_proj ⟨ x , y ⟩ = y

η-× : ∀ {A B : Set} (w : A × B) → ⟨ left_proj w , right_proj w ⟩ ≡ w
η-× ⟨ x , y ⟩ = refl

infixr 2 _×_

-- Declare by record
record _×'_ (A B : Set) : Set where
    constructor ⟨_,_⟩'
    field
        left_proj' : A
        right_proj' : B
open _×'_

--  we have η-quality definitionally 
η-×' : ∀ {A B : Set} (w : A ×' B) → ⟨ left_proj' w , right_proj' w ⟩' ≡ w
η-×' w = refl

data Bool : Set where
    true : Bool
    false : Bool

data Tri : Set where
    a : Tri
    b : Tri
    c : Tri

×-count : Bool × Tri → ℕ
×-count ⟨ true , a ⟩ = 1
×-count ⟨ true , b ⟩ = 1
×-count ⟨ true , c ⟩ = 4
×-count ⟨ false , a ⟩ = 5
×-count ⟨ false , b ⟩ = 1
×-count ⟨ false , c ⟩ = 4

×-comm : ∀ {A B : Set} → A × B ≃ B × A
×-comm = record {
        to = λ { ⟨ x , y ⟩ → ⟨ y , x ⟩ } ;
        from = λ { ⟨ x , y ⟩ → ⟨ y , x ⟩ } ;
        left = λ { ⟨ x , y ⟩ → refl } ;
        right = λ { ⟨ x , y ⟩ → refl }
    }

×-assoc : ∀ {A B C : Set} → (A × B) × C ≃ A × (B × C)
×-assoc = record {
        to = λ { ⟨ ⟨ x , y ⟩ , z ⟩ → ⟨ x , ⟨ y , z ⟩ ⟩ } ;
        from = λ { ⟨ x , ⟨ y , z ⟩ ⟩ → ⟨ ⟨ x , y ⟩ , z ⟩} ;
        left = λ { ⟨ ⟨ x , y ⟩ , z ⟩ → refl } ;
        right = λ { ⟨ x , ⟨ y , z ⟩ ⟩ → refl }
    }

open Isomorphism._⇔_

⇔≃× : ∀ {A B : Set} → A ⇔ B ≃ (A → B) × (B → A)
⇔≃× = record {
        to = λ { AB → ⟨ (to AB) , (from AB) ⟩ } ;
        from = λ { w → record { to = left_proj w ; from = right_proj w } } ; 
        left = λ x → refl ;
        right = λ w → 
            begin
                ⟨ to (record { to = left_proj w ; from = right_proj w }) ,
                 from (record { to = left_proj w ; from = right_proj w  }) ⟩ 
            ≡⟨⟩
                ⟨ left_proj w , right_proj w ⟩
            ≡⟨ η-× w ⟩
                w 
            ∎
    }

-- Introduce
data T : Set where
    tt : T

η-T : ∀ (w : T) → tt ≡ w
η-T tt = refl

-- Record
record T' : Set where
    constructor tt'

η-T' : ∀ (w : T') → tt' ≡ w
η-T' w = refl

truth : T'
truth = _

T-identity_l : ∀ {A : Set} → T × A ≃ A
T-identity_l = record {
        to = λ { ⟨ tt , x ⟩ → x } ;
        from = λ { x → ⟨ tt , x ⟩ } ;
        left = λ { ⟨ tt , x ⟩ → refl } ; 
        right = λ { x → refl }
    }

T-identity_r : ∀ {A : Set} → A × T ≃ A
T-identity_r {A} = ≃-begin (A × T) ≃⟨ ×-comm ⟩ (T × A) ≃⟨ T-identity_l ⟩ A ≃-∎
  
