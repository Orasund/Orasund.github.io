---
title: "Exploring Monads"
tags: [Monad]
---
# Categories

> Categories are algebraically closed sets of functions.

We are mostly interested in functions from Types to Types or in other words, in the Category of Types.

# Functors

A functor is a function from one category to another.

From a programmers perspective a functor is a structure for which the following function can be defined.

```
map: (a -> b) -> Functor<a> -> Functor<b>
```

Example:

```
map: (a -> b) -> Optional<a> -> Optional<b>
```

# Semi-Group

A semi group has a combine function defined

```
combine: SemiGroup -> SemiGroup -> SemiGroup
```

Example would be:

```
join: String -> String -> String
```

# Monoid

A monoid is a structure where the following can be defined

```
combine: Monad -> Monad -> Monad

empty : Monad
```

Example:

```
combine: Int -> Int -> Int

empty : Int
```

# Monads

A monad is a bit more complicated:

```
empty:Monad<a>

combine: Monad<a> -> Monad<a> -> Monad<a>

map:(a->b) -> Monad<a> -> Monad<b>

andThen:(a -> Monad<b>)-> Monad<a> -> Monad<b>
```

Example

```
empty:List<a>

combine: List<a> -> List<a> -> List<a>

map:(a->b) -> List<a> -> List<b>

andThen:(a -> List<b>)-> List<a> -> List<b>
```

For lists, `andThen` is just `flatMap`.

You can actually also define `singleton` like this:

```
singleton : a -> List<a>
singleton a =
    map (\_ -> a) empty
```

`Nullable<a>` is not a Monad, because `map` is not associative(a requirement for functors) defined.

associativity for Monads:

```
(map g (map f input)) == map (\a -> g (f a)) input
```
However
```
map (\_ -> 42) (map (\_ -> Null) 0) = Null
map (\a -> (\_ -> 42) ((\_ -> Null) a)) 0 = 42
```