---
title: "Reading: The Clean Coder"
tags: [functional programming]
---
> QA should find nothing

> You Must Know It Works

> How much of the code should be tested with these automated unit tests? All of it!

> Code is hard to test, because that code has been designed to be hard to test.

> You must be able to make changes without exorbitant costs.

> You ought to be able to describe all 24 patterns in the GOF book and have a working knowledge of many of the patterns in the POSA books.

-> Really not sure about this one. I have very strong feeling aobut GOF and just seeing that POSA has 4 books, with nearly no real reviews or cretique on the subject, im not so sure about this.

> You should know the SOLID principles

[Post: SOLID principles in functional programming](https://medium.com/@mkocik/solid-principles-in-functional-programming-b9b83aeddf80)

* **Single Responsibility Principle** - We use pure functions naturally. The function composition is also widely used. It gets intuitive to write functions with one responsibility and compose them together.
* **Open/Closed Principle** - Still holds true for FP: Software entities should be open for extension but closed for modification.
* **Liskov Substitution Principle** - FP does not have Inheritance, so this is always true
* **Interface Segregation Principle** - Still holds true for FP: Keep interfaces small so that users don’t end up depending on things they don’t need.
* **Dependency Inversion Principle** - It turns out that for FP this principle is natural by design. Function composition and Higher-order functions come in handy here, allowing to swap the implementation of concrete details when needed.

# Chapter 4 - Coding

> Much has been written about the hyper-productive state known as “flow.”
Some programmers call it “the Zone.”

> Avoid the Zone. This state of consciousness is not really hyper-productive and is
certainly not infallible. It’s really just a mild meditative state in which
certain rational faculties are diminished in favor of a sense of speed.

> Nowadays when I feel myself slipping into the Zone, I walk away for a few
minutes. I clear my head by answering a few emails or looking at some
tweets.

-> I'm really not seeing his point there. I do not have the feeling that the quality sufferes when im in the flow. In the contrary, the friction between my thoughts and the implementation of those thought is less than none. That does not mean that my thoughts are perfect, and yes errors still happen. But the flow is more to get an idea down onto paper. Sometimes im also in the flow, while doing test-coverage. It quite a different type of flow, more like a trance, but still i never have experienced the quality of my code to drop during that time.