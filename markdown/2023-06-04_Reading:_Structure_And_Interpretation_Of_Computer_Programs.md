# 1. Building Abstractions with Functions

In the first chapter we define

* arithmatics over numbers
* constants (const)
* functions (function name(arugment) {return statement})
* if expressions (value ? trueBranch : falseBranch)

Tree Accumulation := Evaluating a Tree by combining branches

substitution Model of a function := Beta reduction

when introducing higher order function, the book uses named functions instead of unnamed lambda functions

## Conclusion

The first chapter covers everything to make a language turing complete. The example are standard textbook examples.

# 2. Building Abstractions with Data

In the second chapter we define tuple as our primary data. It can be defined as

``` javascript
const tuple = (a,b) => (f) => f(a,b)
const head = (t) => t((a,b) => a)
const tail = (t) => t((a,b) => b)
```

## Hierarchical Data and the Closure Property --Bookmark
