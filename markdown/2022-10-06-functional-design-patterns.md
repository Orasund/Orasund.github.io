There is this myth, that functional programming does not have any design patterns. [See Functional Design Patterns by Scott Wlaschin](https://www.youtube.com/watch?v=srQt1NAHYC0)

While this might hold for some of the more known patterns, it is definitely not true in general.
Design Patterns for Functional programming are generally more abstract, hard to pin it down to a use case. I would see it more like a set of tools that you can use, but don't have to.

# Monad

A monad is a fancy word for a data structure with an `andThen` function:

```
andThen : (a -> Monad b) -> Monad a -> Monad b
```

If you want to very fancy, you would say: 

> The Monad is a monoid in the category of (endo-)Functors.

But for starters its enough to know that its main feature is the `andThen` function.

An example for a monad would be a list (andThen = flatMap).

Main use for Monads is doing effects. Famous monads are: Reader monad, writer monad,IO monad(Reader + Writer), lense monad

# State Machines

Basic idea is to define an algebraic data type that specifies allows state transitions and to then have a run function that can manipulate state base on an input:

```
update: Msg -> State -> State
```

If you really want to get fancy, you can have the result again be a list of commands

```
update: Msg -> State -> (State, List Msg)
```

Join this up with a step function and you are all good to go

```
step : (State,List Msg) -> (State,List Msg)
```

Side note: `(State,List Msg)` is an IO monad. This is because list is a monad and it both reads and writes `State`.

# Domain Specific Languages

A DSL is very powerful. Its number one selling points should be: "A Langauges tailed to your exact company and your use case." Its the highest of all APIs, because you can actually program in it.

The idea behind is it very simple: You specify a syntax (this can be a Json Schema, some GraphQL or an actual parsed string) and the semantics are provided by your program. Now anyone can come along and write a script using your syntax and send it to your Server. The server will validate it (Essentially checking if you are allowed to do this), then run the script and report back.

At best this requires a single functional call and you are done.

SQL is a very nice example. You can do A LOT with just one sql query. Think how many REST endpoints you would need just to provide the same functionality as a SQL statement.

Other examples include Markdown, Swagger, Moustache.

But this is actually quite easy to pull of. All you really need it an algebraic data type and a case distinction that does different behavior depending on the case. Next to wrap it in a for-each loop and your semantics are done. For the syntax you can go with Json, YAML or any thing else. It does not need to be fancy at all.
