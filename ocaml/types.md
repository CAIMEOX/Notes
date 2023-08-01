# Data Types

> Crash Notes for ocaml programming language. Fun with Functional programming!

Basic Ocaml Data Types
```ocaml
# [];;	
- : 'a list = []
# [1;1;4];;
- : int list = [1; 1; 4]
```

Product Types (Tuple):
```ocaml
# (1,2);;
- : int * int = (1, 2)
# (true, 1.0, 2, "string");;      
- : bool * float * int * string = (true, 1., 2, "string")
```

Record (Tagged and order irrelevant Union)
```ocaml
# type vec3 = {x: int; y:int; z:int};;
type vec3 = { x : int; y : int; z : int; }
# let a = {x=1;y=2;z=3};;
val a : vec3 = {x = 1; y = 2; z = 3}
```
Record should contain all the fields.

Mutable fields:
```ocaml
# type vars = { mutable v : int}
let add1 va = va.v <- va.v + 1
```

Sum Type:
```ocaml
# type color = Red | Green | Blue | Yellow
# let pattern = [(1, Green); (2, Red); (3, Yellow)];;
val pattern : (int * color) list = [(1, Green); (2, Red); (3, Yellow)]
```

Pattern matching:

```ocaml
# let c2s c =  
  match c with
  | Red -> "red"
  | Green -> "green"
  | Yellow -> "yellow"
  | Blue -> "blue"
  ;;
val c2s : color -> string = <fun>
```

Multi-case (Notice another definition of function):
```ocaml
# let rec is_primary = function
  | Red | Green | Blue -> true
  | _ -> false;;    
val is_primary : color -> bool = <fun>
```

Type constructor:
```ocaml
# type color =
  | Red
  | Green
  | Blue
  | RGB of float * float * float;;
type color = Red | Green | Blue | RGB of float * float * float
```

Recursive types:
```ocaml
type color =
  | Red
  | Green
  | Blue
  | RGB of float * float * float
  | Mix of float * color * color;;
```

The Mix contains a proportion: float and two colors.

Destructor and `let in` expression:

```ocaml
# let rec rgb_of_colour = function
  | Red -> (1.0, 0.0, 0.0)
  | Green -> (0.0, 1.0, 0.0)
  | Blue -> (0.0, 0.0, 1.0)
  | Yellow -> (1.0, 1.0, 0.0)
  | RGB (r, g, b) -> (r, g, b)
  | Mix (p, a, b) ->
      let (r1, g1, b1) = rgb_of_colour a in
      let (r2, g2, b2) = rgb_of_colour b in
      let mix x y = x *. p +. y *. (1.0 -. p) in
        (mix r1 r2, mix g1 g2, mix b1 b2);;                    
val rgb_of_colour : colour -> float * float * float = <fun>
```

Use `of` notation for records:
```ocaml
# type colour =
  | Red
  | Green
  | Blue
  | Yellow
  | RGB of {r : float; g : float; b : float}
  | Mix of {proportion : float; c1 : colour; c2 : colour};;
```


Polymorphic data types:
```ocaml
type 'a tree =
  | Leaf
  | Node of 'a tree * 'a * 'a tree;;
type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree
```

We give the type **parameter** 'a before the type name refers to polymorphic types.

```ocaml
# let rec total = function
  | Leaf -> 0
  | Node (l, n, r) -> total l + n + total r;;
val total : int tree -> int = <fun>
```
`total` operates only on trees of type **int** tree!

```ocaml
# let rec flip = function
  | Leaf -> Leaf
  | Node (l, n, r) -> Node (flip r, n ,flip l);;
val flip : 'a tree -> 'a tree = <fun>
```

`flip` is polymorphic.

Binary Search tree (A smaller key is always left of a larger key. This implies the key should be **ordered** type):
```ocaml
# let rec insert (k, v) = function
  | Leaf -> Node (Leaf, (k, v), Leaf)
  | Node (l, (k', v'), r) ->
    if (k < k') then Node (insert (k, v) l, (k', v'), r)
    else if k > k' then Node (l, (k', v'), insert (k, v) r)
    else Node (l, (k, v), r);;
val insert : 'a * 'b -> ('a * 'b) tree -> ('a * 'b) tree = <fun>
```

The Maybe Type:
```ocaml
# type 'a maybe = Nothing | Just of 'a;;
# let mb = Just 1;;
val mb : int maybe = Just 1
```

Lift as functor:
```ocaml
# let map f = function
  | Nothing -> Nothing
  | Just v -> Just (f v);;
val map : ('a -> 'b) -> 'a maybe -> 'b maybe = <fun>
```

Math Expression interpreter:
```ocaml
type expr =
  | Plus of expr * expr
  | Minus of expr * expr
  | Times of expr * expr
  | Divide of expr * expr
  | Var of string

let rec toString e =
  match e with
  | Plus (left, right) ->
     "(" ^ toString left ^ " + " ^ toString right ^ ")"
  | Minus (left, right) ->
     "(" ^ toString left ^ " - " ^ toString right ^ ")"
  | Times (left, right) ->
   "(" ^ toString left ^ " * " ^ toString right ^ ")"
  | Divide (left, right) ->
   "(" ^ toString left ^ " / " ^ toString right ^ ")"
  | Var v -> v;;
```
The `^` operator concatenates strings
```ocaml
# print_endline (toString (Times (Var "n", Plus (Var "x", Var "y"))));;
(n * (x + y))
- : unit = ()
```

`print_endline` is a function used to print string in terminal.

A simple factorize function:
```ocaml
# let factorize e =
  match e with
  | Plus (Times (e1, e2), Times (e3, e4)) when e1 = e3 ->
     Times (e1, Plus (e2, e4))
  | Plus (Times (e1, e2), Times (e3, e4)) when e2 = e4 ->
     Times (Plus (e1, e3), e4)
  | e -> e;;            
val factorize : expr -> expr = <fun>
```
**when**-clause behaves as guard, which means that the pattern match only happens if the pattern matches and the condition in the when-clause is satisfied.

The `=` operator, which tests for "**structural equality**", which checks all the layers.
( Notice that we don't use `==` here !)

The `as` keyword can be used to name part of an expression. 
```ocaml
| Letter ("A" | "B" | "C" | "D") as n -> n
| Node (l, ((k, _) as pair), r) when k = k' -> Some pair
```

**Mutually** recursive data types (commonly used for **decoration**):
```ocaml
type t = A | B of t' and t' = C | D of t
```

Example for decorating a tree:
```ocaml
type t' = Int of int | Add of t * t
  and t = {annotation : string; data : t'}
```

Calculate Sum (The `let rec f ... and m ...` indicates that the functions call themselves (**rec**) and each other (**and**)):
```ocaml
let rec sum = function
  | Int a -> a
  | Add (a, a') -> sumT a + sumT a'
  and sumT {annotation; data} =
    if annotation <> "" then Printf.printf "Touching %s\n" annotation;
    sum data;;
```