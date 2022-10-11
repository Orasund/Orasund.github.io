While studing at the university, I had the feeling, that there was this perfect solution out there, how to validate code. And the industry is just not seeing it.
Well, it turns out, I was the one not seeing the truth.

# Formal Methods

Formal Methods was the holy grail of doing things right. JUST write a proof that your programm is currect and you're done.

## Hore Calculus

The is to define a mathematical calculus, so that we can reason about computer programs.
That way we can actually prove that the implementation is valid with respect to the specification.
However the proving process can't be automized - there are some parts where you have to be creative about it.
Just checking all possible solutions woun't do the job, because these can be infinite.

## Model Checking and SMT Solvers

Model checking is a different approach, where we can actually check automatically if programm is correct, just by going through all possible states.
However the problem here is that this only works for finite systems.
So we have to model the real programm into a programm with finite states -  for examples by limiting the amount of values an int may have.

## Proof Assistants

So lets go back to hore calculus any see how far we can actually automate.
And whenever we are stuck, we just ask a human for help. This is the core idea of proof assistants.
This can actually work quite well - assuming the human knows all the right answers.
But for problems where the human isn't sure or the specification is wrong, this approach isn't really better than doing the proof manually.

Wait... the Specification can we wrong?

# Who Validates the Specification

Up until this point we where expecting the specification to be valid.
However we soon see that wrting a verification (say in the Java Modelling Language) takes more lines of code and the actual programm.
But validating the specification would meant that we have some higher way of comparing a written specification with real code.

Someone: "Tests"

Did I just hear someone say "Tests"? Bad Human, Bad! We all know tests are not avalid way of proving anything.
They can only ever give us a general idea if its the correct direction or not. But they can never validate a specification.

Someone: "I just wanted to be realistic about this"

No. Bad. We need more theory if we want to archive anything.

# Type Theory

# Reality
