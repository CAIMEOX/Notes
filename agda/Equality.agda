module Equality where

data _≡_ {A : Set} (x : A) : A → Set where
    refl : x ≡ x

infixl 4 refl 

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

- Reasoning
module ≡-Reasoning {A : Set} where
    infix 1 begin_
    infixr 2 _≡⟨⟩_ _≡⟨_⟩_
    infix 3 _∎

    begin_ : ∀ {x y : A} → x ≡ y → x ≡ y
    begin a = a

    _≡⟨⟩_ : ∀ (x : A) {y : A} → x ≡ y → x ≡ y
    x ≡⟨⟩ x≡y = x≡y

    _≡⟨_⟩_ : ∀ (x : A) {y z : A} → x ≡ y → y ≡ z → x ≡ z
    x ≡⟨ x≡y ⟩ y≡z = trans x≡y y≡z

    _∎ : ∀ (x : A) → x ≡ x
    x ∎ = refl

open ≡-Reasoning