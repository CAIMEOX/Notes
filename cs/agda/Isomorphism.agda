module Isomorphism where

import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; cong; cong-app)
open Eq.≡-Reasoning
open import Data.Nat using (ℕ; zero; suc; _+_)
open import Data.Nat.Properties using (+-comm)

_∘_ : ∀ {A B C : Set} → (B → C) → (A → B) → (A → C)
(g ∘ f) x  = g (f x)

-- Function extensionality 
postulate
    extensionality : ∀ {A B : Set} { f g : A → B } → (∀ (x : A) → f x ≡ g x) → f ≡ g

_+'_ : ℕ → ℕ → ℕ
m +' zero = m
m +' suc n = suc (m +' n)

same-app : ∀ (m n : ℕ) → m +' n ≡ m + n
same-app m n rewrite +-comm m n = h m n
    where h : ∀ (m n : ℕ) → m +' n ≡ n + m
          h m zero rewrite +-comm m zero = refl
          h m (suc n) = cong suc (h m n)

same : _+'_ ≡ _+_
same = extensionality (λ x → extensionality (λ y → same-app x y))

-- More general : Dependent Type
postulate
  ∀-extensionality : ∀ {A : Set} {B : A → Set} {f g : ∀(x : A) → B x} → (∀ (x : A) → f x ≡ g x) → f ≡ g

infix 0 _≃_
record _≃_ (A B : Set) : Set where
    field
        to : A → B
        from : B → A
        left : ∀ (x : A) → from (to x) ≡ x
        right : ∀ (y : B) → to (from y) ≡ y
open _≃_
-- More about Record : Connectives

-- Isomorphism is a relation
≃-refl : ∀ { A : Set } → A ≃ A
≃-refl = record {
        to = λ { x → x } ;
        from = λ { x → x } ; 
        left = λ x → refl ;
        right = λ x → refl 
    }

≃-sym : ∀ { A B : Set } → A ≃ B → B ≃ A
≃-sym AB = record {
        to = from AB ; 
        from = to AB ;
        left = right AB ;
        right = left AB
    }

≃-trans : ∀ {A B C : Set} → A ≃ B → B ≃ C → A ≃ C
≃-trans AB BC = record {
        to = to BC ∘ to AB ;
        from = from AB ∘ from BC ;
        left = λ{ x →
            begin
                (from AB ∘ from BC) ((to BC ∘ to AB) x)
            ≡⟨⟩
                from AB (from BC (to BC (to AB x)))
            ≡⟨ cong (from AB) (left BC (to AB x)) ⟩
                from AB (to AB x)
            ≡⟨ left AB x ⟩
                x
            ∎ } ;
        right = λ{ x →
            begin
                (to BC ∘ to AB) ((from AB ∘ from BC) x) 
            ≡⟨⟩
                to BC (to AB (from AB (from BC x)))
            ≡⟨ cong (to BC) (right AB (from BC x)) ⟩
                to BC (from BC x) 
            ≡⟨ right BC x ⟩
                x
            ∎ } 
    }

module ≃-Reasoning where
    infix 1 ≃-begin_
    infixr 2 _≃⟨_⟩_
    infix  3 _≃-∎

    ≃-begin_ : ∀ {A B : Set} → A ≃ B → A ≃ B
    ≃-begin A≃B = A≃B
    
    _≃⟨_⟩_ : ∀ (A : Set) {B C : Set} → A ≃ B → B ≃ C → A ≃ C
    A ≃⟨ A≃B ⟩ B≃C = ≃-trans A≃B B≃C

    _≃-∎ : ∀ (A : Set) → A ≃ A
    A ≃-∎ = ≃-refl

open ≃-Reasoning

-- Embedding 
infix 0 _≲_
record _≲_ (A B : Set) : Set where
    field
        to : A → B
        from : B → A
        left : ∀ (x : A) → from (to x) ≡ x
open _≲_

≲-refl : ∀ {A : Set} → A ≲ A
≲-refl = record {
        to = λ { x → x } ;
        from = λ { x → x } ;
        left = λ { x → refl }
    }

≲-trans : ∀ {A B C : Set} → A ≲ B → B ≲ C → A ≲ C
≲-trans A≲B B≲C = record { 
        to = λ{ x → to   B≲C (to   A≲B x)} ;
        from = λ{ y → from A≲B (from B≲C y)} ;
        left = λ{ x →
            begin
                from A≲B (from B≲C (to B≲C (to A≲B x)))
            ≡⟨ cong (from A≲B) (left B≲C (to A≲B x)) ⟩
                from A≲B (to A≲B x)
            ≡⟨ left A≲B x ⟩
                x
            ∎
       }
    }

≲-antisym : ∀ {A B : Set} → (AB : A ≲ B) → (BA : B ≲ A) → (to AB ≡ from BA) → (from AB ≡ to BA) → A ≃ B
≲-antisym AB BA tf ft = record {
        to = to AB ;
        from = from AB ;
        left = left AB ;
        right = λ { y → 
            begin
                to AB (from AB y)
            ≡⟨ cong (to AB) (cong-app ft y) ⟩ 
                to AB (to BA y)
            ≡⟨ cong-app tf (to BA y) ⟩
                from BA (to BA y)
            ≡⟨ left BA y ⟩
                y
            ∎
        }
    }

module ≲-Reasoning where

  infix  1 ≲-begin_
  infixr 2 _≲⟨_⟩_
  infix  3 _≲-∎

  ≲-begin_ : ∀ {A B : Set} → A ≲ B → A ≲ B
  ≲-begin A≲B = A≲B

  _≲⟨_⟩_ : ∀ (A : Set) {B C : Set} → A ≲ B → B ≲ C → A ≲ C
  A ≲⟨ A≲B ⟩ B≲C = ≲-trans A≲B B≲C

  _≲-∎ : ∀ (A : Set) → A ≲ A
  A ≲-∎ = ≲-refl

open ≲-Reasoning

≃-implies-≲ : ∀ {A B : Set} → A ≃ B → A ≲ B
≃-implies-≲ AB = record {
        to = to AB ;
        from = from AB ; 
        left = left AB 
    }

record _⇔_ (A B : Set) : Set where
    field
        to : A → B
        from : B → A
open _⇔_

⇔-refl : ∀ {A : Set} → A ⇔ A
⇔-refl = record {
        to = λ { x → x } ;
        from = λ { x → x} 
    }

⇔-trans : ∀ {A B C : Set} → A ⇔ B → B ⇔ C → A ⇔ C
⇔-trans AB BC = record {
        to = to BC ∘ to AB ;
        from = from AB ∘ from BC 
    }

⇔-sym : ∀ {A B : Set} → A ⇔ B → B ⇔ A
⇔-sym AB = record {
        to = from AB ;
        from = to AB  
    }
