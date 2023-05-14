---
title: "Reading Structure And Interpretation Of Computer Programs"
tags: [Book,JavaScript]
---
# Reading: Structure And Interpretation Of Computer Programs

## 1. Building Abstractions with Functions

In the first chapter we define

* arithmatics over numbers
* constants (const)
* functions (function name(arugment) {return statement})
* if expressions (value ? trueBranch : falseBranch)

Tree Accumulation := Evaluating a Tree by combining branches

substitution Model of a function := Beta reduction

when introducing higher order function, the book uses named functions instead of unnamed lambda functions

### Conclusion

The first chapter covers everything to make a language turing complete. The example are standard textbook examples.

## 2. Building Abstractions with Data

In the second chapter we define pair as our primary data. It can be defined as

``` javascript
const pair = (a,b) => (f) => f(a,b)
const head = (t) => t((a,b) => a)
const tail = (t) => t((a,b) => b)
```

We also define list using the pair implementation

``` javascript
const emptyList = null
const cons = (e,list) => pair(e,list) 
```

and trees by using list as elements of lists.

Next they started defining a painter using matricies. With the painter we can define different operations on images.

Finally we look at how to define packages using tagged types and a lookup table for packages to be "installed" in.

At the end we define our own type system to support subtyping.

### passing messages to sub functions

> This style of programming is called message passing. The name comes from the image that a data object is an entity that receives the requested operation name as a “message.”

## 3. Modularity, Objects, and State

In the third chapter we define mutability.

We then model object by using stateful functions with subfunctions.


We finish by defining a stream

```
stream = (head,() => computeTail () )
```