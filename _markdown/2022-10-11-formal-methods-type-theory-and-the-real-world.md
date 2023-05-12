# Formal Methods, Type Theory and the real world

While studing at the university, I had the feeling, that there was this perfect solution out there, how to validate code. And the industry is just not seeing it.
Well, it turns out, I was the one not seeing the truth.

## Formal Methods

Formal Methods was the holy grail of doing things right. JUST write a proof that your programm is currect and you're done.

### Hore Calculus

The is to define a mathematical calculus, so that we can reason about computer programs.
That way we can actually prove that the implementation is valid with respect to the specification.
However the proving process can't be automized - there are some parts where you have to be creative about it.
Just checking all possible solutions woun't do the job, because these can be infinite.

### Model Checking and SMT Solvers

Model checking is a different approach, where we can actually check automatically if programm is correct, just by going through all possible states.
However the problem here is that this only works for finite systems.
So we have to model the real programm into a programm with finite states -  for examples by limiting the amount of values an int may have.

### Proof Assistants

So lets go back to hore calculus any see how far we can actually automate.
And whenever we are stuck, we just ask a human for help. This is the core idea of proof assistants.
This can actually work quite well - assuming the human knows all the right answers.
But for problems where the human isn't sure or the specification is wrong, this approach isn't really better than doing the proof manually.

Wait... the Specification can we wrong?

## Who Validates the Specification

Up until this point we where expecting the specification to be valid.
However we soon see that wrting a verification (say in the Java Modelling Language) takes more lines of code and the actual programm.
But validating the specification would meant that we have some higher way of comparing a written specification with real code.

Someone: "Tests"

Did I just hear someone say "Tests"? Bad Human, Bad! We all know tests are not avalid way of proving anything.
They can only ever give us a general idea if its the correct direction or not. But they can never validate a specification.

Someone: "I just wanted to be realistic about this"

No. Bad. We need more theory if we want to archive anything.

## Type Theory

Type Theory is essentially a different model of looking at mathematics. In particular by the [Curry–Howard_correspondence](https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence), its actually equivalent: Proving a theorem is the same as thing as checking a type. In order to do this, we have to introduce a type system that is powerfull enough, such that we can actually describe any theorem as a type. At thats what depedence types are for.

### Dependent types

If you have ever heard of [Agda](https://wiki.portal.chalmers.se/agda/pmwiki.php), that exactly that: Have a programming language, where you can actually prove the validity of a program, by specifing its type. That being say, we still have to do some proving, but now its typed. (yeaah🎉)

### Refinement types

Now you might ask, what we could do without having to prove anything. The answer is refinement types. I can point to my master thesis, if someone wants to hear the details. But long answer, short: You are very limited in the things you can validate, with very specific hard borders that are well defined. So we know already, that we will never be able to automaticall prove everything - but its also a long way to this border. But that said, the algorithm behind it (or rather the SMT solver behind it) isn't total - so you will always find counter examples, where you can write a valid refinement type but its can't be type checked.

So you are essentially breaking your type system, just by adding refinement types. So thats not good...

So then, whats the smallest thing we can do without breaking the type system and without needing to prove something...

Someone "Tests"

You know... maybe you are right.

## Reality

Sadly the reality is, that all the magic, that you hear in university, it's that powerful after all. It's not the holy grail. It's not solving all our problems with no down sides. The reality is that if we really want to check if our programm is valid in a consistant way, we only have tests to help.

Or so you might think if you are living behind a rock.

### Functional Programming

There is a revolution ongoing. A slow an quited one - but its happing. And this revolution is called functional programming and a more powerful typesystem.

What Hindley-Milner has shown for his programming language called "ML", is that we can have a type system that is better then what our current programming languages use. And although its better, we do not loose totality and we do not need to type check anything. Even better. This type system can actually infer the type of an expression - so no need specifing the type.

Nowadays ML is no longer used, but other languages have picked up that type system and used it with pride. Im talking about Haskell(PureScript), Elm, F# and OCaml(ReScript) and many more. 
