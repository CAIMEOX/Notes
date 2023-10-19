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

-- Introduce Disjoint Union / Sum Type
data _⊎_ (A B : Set) : Set where
    inj-left : A → A ⊎ B  -- ⊎-I₁
    inj-right : B → A ⊎ B  -- ⊎-I₂

-- Eliminate:
-- ⊎-E
case-⊎ : ∀ {A B C : Set} → (A → C) → (B → C) → A ⊎ B → C
case-⊎ f g (inj-left x) = f x
case-⊎ f g (inj-right y) = g y

η-⊎ : ∀ {A B : Set} (w : A ⊎ B) → case-⊎ inj-left inj-right w ≡ w
η-⊎ (inj-left w) = refl
η-⊎ (inj-right w) = refl

-- Function apply 
uniq-⊎ : ∀ {A B C : Set} (h : A ⊎ B → C) (w : A ⊎ B) → case-⊎ (h ∘ inj-left) (h ∘ inj-right) w ≡ h w
uniq-⊎ h (inj-left x) = refl
uniq-⊎ h (inj-right y) = refl

infixr 1 _⊎_

-- that is variant record type
⊎-count : Bool ⊎ Tri → ℕ
⊎-count (inj-left true)   =  1
⊎-count (inj-left false)  =  1
⊎-count (inj-right a)     =  4
⊎-count (inj-right b)     =  5
⊎-count (inj-right c)     =  1

⊎-swap : ∀ {A B : Set} → A ⊎ B → B ⊎ A
⊎-swap (inj-left x) = inj-right x
⊎-swap (inj-right x) = inj-left x

⊎-swap-identity : ∀ {A B : Set} → (w : A ⊎ B) → ⊎-swap (⊎-swap w) ≡ w
⊎-swap-identity (inj-left x) = refl
⊎-swap-identity (inj-right x) = refl

⊎-comm : ∀ {A B : Set} → A ⊎ B ≃ B ⊎ A
⊎-comm = record {
        to = ⊎-swap ; 
        from = ⊎-swap ;
        left = ⊎-swap-identity ;
        right = ⊎-swap-identity 
    }


⊎-assoc : ∀ {A B C : Set} → (A ⊎ B) ⊎ C ≃ A ⊎ (B ⊎ C)
⊎-assoc = record {
        to = ⊎-assoc-to ;
        from = ⊎-assoc-from ;
        left = ⊎-assoc-left ;
        right = ⊎-assoc-right 
    }
    where
    ⊎-assoc-to : ∀ {A B C : Set} → (A ⊎ B) ⊎ C → A ⊎ (B ⊎ C)
    ⊎-assoc-to (inj-left (inj-left x)) = inj-left x
    ⊎-assoc-to (inj-left (inj-right y)) = inj-right (inj-left y)
    ⊎-assoc-to (inj-right z) = inj-right (inj-right z)

    ⊎-assoc-from : ∀ {A B C : Set} → A ⊎ (B ⊎ C) → (A ⊎ B) ⊎ C
    ⊎-assoc-from (inj-left x) = inj-left (inj-left x)
    ⊎-assoc-from (inj-right (inj-left y)) = inj-left (inj-right y)
    ⊎-assoc-from (inj-right (inj-right z)) = inj-right z

    ⊎-assoc-left : ∀ {A B C : Set} → (w : ((A ⊎ B) ⊎ C)) → ⊎-assoc-from (⊎-assoc-to w) ≡ w
    ⊎-assoc-left (inj-left (inj-left x)) = refl
    ⊎-assoc-left (inj-left (inj-right y)) = refl
    ⊎-assoc-left (inj-right z) = refl

    ⊎-assoc-right : ∀ {A B C : Set} → (w : (A ⊎ (B ⊎ C))) → ⊎-assoc-to (⊎-assoc-from w) ≡ w
    ⊎-assoc-right (inj-left x) = refl
    ⊎-assoc-right (inj-right (inj-left y)) = refl
    ⊎-assoc-right (inj-right (inj-right z)) = refl

data ⊥ : Set where

-- exfalso
⊥-elim : ∀ {A : Set} → ⊥ → A
⊥-elim ()

uniq-⊥ : ∀ {A : Set} (h : ⊥ → A) (w : ⊥) → ⊥-elim w ≡  h w
uniq-⊥ h ()

⊥-count : ⊥ → ℕ 
⊥-count ()

⊥-identity-l : ∀ { A : Set } → ⊥ ⊎ A ≃ A
⊥-identity-l {A} = record {
        to = λ { (inj-right x) → x } ; 
        from = λ { x → (inj-right x) } ;
        left = λ { (inj-right x) → refl } ;
        right = λ y → refl
    }

⊥-identity-r : ∀ { A : Set } → A ⊎ ⊥ ≃ A
⊥-identity-r {A} = ≃-begin (A ⊎ ⊥) ≃⟨ ⊎-comm ⟩ (⊥ ⊎ A) ≃⟨ ⊥-identity-l ⟩ A ≃-∎

-- Implication is function (Modus ponens)
→-elim : ∀ {A B : Set} → (A → B) → A → B
→-elim X Y = X Y

η-→ : ∀ {A B : Set} (f : A → B) → (λ (x : A) → f x) ≡ f
η-→ f = refl 

-- This is crazy
→-count : (Bool → Tri) → ℕ
→-count f with f true | f false
...          | a     | a      =   1
...          | a     | b      =   2
...          | a     | c      =   3
...          | b     | a      =   4
...          | b     | b      =   5
...          | b     | c      =   6
...          | c     | a      =   7
...          | c     | b      =   8
...          | c     | c      =   9

currying : ∀ {A B C : Set} → (A → B → C) ≃ (A × B → C)
currying = record {
        to = λ { f → λ { ⟨ x , y ⟩ → f x y}} ;
        from = λ { g → λ x y → g ⟨ x , y ⟩ } ; 
        left = λ x → refl ;
        right = λ g → extensionality λ {  ⟨ x , y ⟩ → refl }
    }

→-distrib-⊎ : ∀ {A B C : Set} → (A ⊎ B → C) ≃ ((A → C) × (B → C))
→-distrib-⊎ = record {
        to = λ x → ⟨ x ∘ inj-left  , x ∘ inj-right ⟩ ; 
        from = λ{ ⟨ g , h ⟩ → λ { (inj-left x) → g x ; (inj-right x) → h x } } ;
        left = λ { f → extensionality λ { (inj-left x) → refl ; (inj-right x) → refl}} ;
        right = λ { ⟨ g , h ⟩ → refl }
    }

→-distrib-× : ∀ {A B C : Set} → (A → B × C) ≃  (A → B) × (A → C)
→-distrib-× = record {
        to = λ x → ⟨ left_proj ∘ x , right_proj ∘ x ⟩ ;
        from = λ { ⟨ g , h ⟩ → λ x → ⟨ g x , h x ⟩ } ;
        left = λ { f → extensionality λ { x → η-× (f x)}} ;
        right = λ { ⟨ g , h ⟩ → refl }
    }

×-distrib-⊎ : ∀ {A B C : Set} → (A ⊎ B) × C ≃ (A × C) ⊎ (B × C)
×-distrib-⊎ = record {
        to = λ { ⟨ inj-left x , z ⟩ → (inj-left ⟨ x , z ⟩) ;
                 ⟨ inj-right x , z ⟩ → (inj-right ⟨ x , z ⟩) } ;
        from = λ { (inj-left ⟨ x , z ⟩) → ⟨ inj-left x , z ⟩ ;
                   (inj-right ⟨ x , z ⟩) → ⟨ inj-right x , z ⟩ } ;
        left = λ { ⟨ inj-left x , x₁ ⟩ → refl
                 ; ⟨ inj-right x , x₁ ⟩ → refl } ;
        right = λ { (inj-left ⟨ x , y ⟩) → refl;
                    (inj-right ⟨ x , x₁ ⟩) → refl }
    }

⊎-distrib-× : ∀ {A B C : Set} → (A × B) ⊎ C ≲ (A ⊎ C) × (B ⊎ C) 
⊎-distrib-× = record {
        to = λ { (inj-left ⟨ x , z ⟩) → ⟨ inj-left x , inj-left z ⟩ ;
                 (inj-right z) → ⟨ inj-right z , inj-right z ⟩ } ;
        from = λ { ⟨ inj-left x , inj-left z ⟩ → (inj-left ⟨ x , z ⟩) ;
                   ⟨ inj-left x , inj-right z ⟩ → (inj-right z) ;
                   ⟨ inj-right z , _ ⟩ → (inj-right z) } ;
        left = λ { (inj-left ⟨ x , x₁ ⟩) → refl ; (inj-right x) → refl }
    }

-- The weak distributive law
⊎-weak-× : ∀ {A B C : Set} → (A ⊎ B) × C →  A ⊎ (B × C)
⊎-weak-× ⟨ inj-left x , x₁ ⟩ = inj-left x 
⊎-weak-× ⟨ inj-right x , x₁ ⟩ = inj-right ⟨ x , x₁ ⟩

⊎×-implies-×⊎ : ∀ {A B C D : Set} → (A × B) ⊎ (C × D) → (A ⊎ C) × (B ⊎ D)
⊎×-implies-×⊎ (inj-left x) = ⟨ inj-left (left_proj x) , inj-left (right_proj x) ⟩
⊎×-implies-×⊎ (inj-right x) = ⟨ inj-right (left_proj x) , inj-right (right_proj x ) ⟩
