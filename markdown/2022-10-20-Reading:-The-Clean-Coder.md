> QA should find nothing

> You Must Know It Works

> How much of the code should be tested with these automated unit tests? All of it!

> Code is hard to test, because that code has been designed to be hard to test.

> You must be able to make changes without exorbitant costs.

> You ought to be able to describe all 24 patterns in the GOF book and have a working knowledge of many of the patterns in the POSA books.

-> Really not sure about this one. I have very strong feeling aobut GOF and just seeing that POSA has 4 books, with nearly now real reviews or cretique on the subject, im not so sure about this.

> You should know the SOLID principles

[Post: SOLID principles in functional programming](https://medium.com/@mkocik/solid-principles-in-functional-programming-b9b83aeddf80)

* **Single Responsibility Principle** - We use pure functions naturally. The function composition is also widely used. It gets intuitive to write functions with one responsibility and compose them together.
* **Open/Closed Principle** - Still holds true for FP: Software entities should be open for extension but closed for modification.
* **Liskov Substitution Principle** - FP does not have Inheritance, so this is always true
* **Interface Segregation Principle** - Still holds true for FP: Keep interfaces small so that users don’t end up depending on things they don’t need.
* **Dependency Inversion Principle** - It turns out that for FP this principle is natural by design. Function composition and Higher-order functions come in handy here, allowing to swap the implementation of concrete details when needed.
