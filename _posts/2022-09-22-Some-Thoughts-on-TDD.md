---
title: "Some Thoughts on Test Driven Development"
tags: essay
---

tltr;
* Make less tests with higher coverage.
* Write that are more valuable than the time they take to run.
* Use tests as requirements not as documentation.

# What is TDD

The core idea of TDD is to first write down your requirements as tests and then implement them. If all tests passed, then you can assume that you implemented a correct soluction.

[Video: Ian Cooper - TDD, Where did it all go wrong](https://www.youtube.com/watch?v=EZ05e7EMOLM)
[Daniel Terhorst-North about the creation of BDD](https://open.spotify.com/episode/5Pkv1z1jwix8sVXPj1yqBD?si=FccsNh9KSnmhVtKTDKMdJw)

"Behaviour Driven Development" will often be used to empathis this.

This style is very hard to actually pull off, as you are required to actually have requirements in form of tests to begin with.

Thats why the industry mostly uses TDD as a synonym for a high code coverage.

# Reasons against TDD

From my experience the original intend of TDD was been completely lost:
If someone says they develop test driven, then they don't mean that they start with test and that they see their tests as some form of specification.
Rather, I noticest that what they actually mean is that they try to have a high test coverage - usually at about 80%.
They try to create as many tests as possible - even if some tests overlap - as long as it increases the test coverage.
And once they notice that a test fails, they rewrite it so that it works again. This in particular really cracks me up.
Either my test are the specification, in that case i should write them once and then hopefully never ever touch them again,
or they document my current behaviour but then i should only write them after im done - together with other forms of documentation.

I once had a PR rejected because I had not touched a test.
The reviewer assumed that i was impossible for me to change something without breaking at least one test.
But the change itself was a fix for a bug that only occured on a specific date at a specific time - of course non of the existing test had covered that.
We had an argument about it. He wanted me to add a test where i unit test that specific timestamp.
I was against it as it was not a edge case in the specification - just some error that occured because our original algorithm was wrong. 

This incident really got me thinking. In a sense we both where correct, but we clearly had different views as to what our tests represented.
I would want to believe that there is a place in between, where tests represent the specification but also cover a lot of the code. It might not be 80% though.
I'm still uncertain if a high code coverage is actually useful. Mostly because whenever i've seen a code coverage of 80%, it invoved a lot of (sloppy) mocks.
Creating Mocked tests is always a double edged sword, because you need to be certain that your mocked data is acutally correct.
Invalid mocks can validate everything.
I have, however, also managed a full test coverage without mocks - ok, i must clearify, i used a pure fuctional programming language (Elm).
So there would not really have been anything that needed mocking. But still.
I do acutally believe that functional programming requires less tests then OOP.
My guess for a reason, why this might be the case, would be the more expressive type system.
A type annotation is in a sense a proof (see Curry–Howard correspondence). So i somehow see a relation to the whole validate vs verify topic.
But that a topic for another day.

## Mocking leads to false assumtions
Mocking is needed to acutally archive TDD but this might result in false mocks. But writing tests without mocks can be done. The solution is to seperate effects from logic and then only test the logic. To tests effect we can use system tests.

## Code Coverage of 80% does not come naturally
I've never seen anyone actually do TDD in a way where they end up with a code coverage of 80% by their first attempt. Most often you have around 50% by the first try, then check your code coverage and create the missing tests. Thats because a lot of tests are useless(Mocking a lot with no real data) or testing unwanted behaviour(Fail states).

## Harder to refactor
If you go for a bottom-up approach, then you are also directly testing implementation decitions. This means whenever you want to switch to a different implementation, you will have to adapt or rewrite all associated tests.

## Longer Pipeline Time
A project with a code coverage of 80% or a bottom-up-TDD approach will take much longer as to complete the pipeline. This slows down development my a massive amount. It's not only that the CD/CI process takes longer, developers are thrown out of their flow if they have to wait 30 to 60min just to see if the PR is green or not.
