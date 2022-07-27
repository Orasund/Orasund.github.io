---
title: "Terminology Overview"
tags: Collection
---

**MODERN** Terminology. If something is not here... maybe its outdated?

# Code Structuring

* Test Driven Design (TDD)

  Create tests first, then implement them and recheck if the tests work
  
  This does not mean to test everything. Or to have a test coverage of 80%.
  
  [Video: Ian Cooper - TDD, Where did it all go wrong](https://www.youtube.com/watch?v=EZ05e7EMOLM)
  
* Behaviour Driven Design (BDD)

  Same as TDD but rephrased: Create an executable Specification (can be a test), then implement it and check if the specification holds.
  
  [Daniel Terhorst-North about the creation of BDD](https://open.spotify.com/episode/5Pkv1z1jwix8sVXPj1yqBD?si=FccsNh9KSnmhVtKTDKMdJw)
  
* Domain Driven Design (DDD)

  Group programms into domain specifc sections -> might be split into microservices later.
  
# Writing Code

* Functional Programming

  Create composable Functions instead of Objects. Data should be immutable and dump.
  
  In Object Oriented Languages: Do Functional-First
  * Start with Functions and Data.
  * Create Objects only if you have to and remove them again once you don't need them anymore. 
  
  Good fits: DDD, Reactive Programming, Actor Model, Onion Architecture
  
* Keep it Simple Stupid (KISS)
  
  Choose the simplest solution first, Avoid Complexity.

* Self Documenting Code
  
  Name your functions, such that you can explain what you are doing, just by reading the code out loud.
  
  Best combinied with Functional Programming
  
  Does not replace Comment.
  
  
