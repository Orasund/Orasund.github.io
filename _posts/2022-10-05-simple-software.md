---
title: "Simple Software"
tags: [Functional Programming]
---
I would describe my programming philosophy as "creating simple software".
Here is what i mean by that.

# Keep it Simple and Stupid

There are a lot of programming paradims and trends floating around.
But for actual, every day work these are often a complete overkill.
Things may be simple and they may be boring. Thats good. That's exactly what we are looking after.
If a solution feels stupidly simple, then its a good indicator, that is is worth considering.

The part about keeping your programm stupid is meant in relation to your algorithms.
Make thinks as dumb as possible. Find short cuts or ask if the requirements can be adjusted to make a solution easier.
By restricting yourself so simple algorithms, you are forces to think of design decitions that really give you the money for their buck.

# Functional First

Functional programming is a bit of a hidden gem.
It provides you with a tool to build powerful programmings with simple fuctions.
Thats why i believe its a perfect fit for my first philosophy of keeping things simple.

However, functional is not always the best solution.
Thats why we should be flexible enough to include some OOP whenever the functional apporach does not work.
But personally i really do believe, that starting with a functional apprach will most often result in the best approach.

# Types over Tests

Try to model as many requirements as much as possible directly in your types and models.
And then you only write tests for the requirements that you can't describe by a type.

Here I love to quote the [Curry–Howard correspondence](https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence).
It states that checking a type is equivalent to proving a theory. This can go both ways.
So for assuming you type system is complex enough, you can actually formulate your requirements as types.

In practice this only goes so far, but it really sells the point.

# Refactoring is half the job

Refactoring should always be part of the development process.
Allowing refactoring to happen naturally, gives you a very agile and flexible code base.
My personal feeling would be that you should estimate about 50% of your time just for doing refactors.
Not that you will actually need it all the time, but whenever you actually do need to refactor, it really is a money sink.
So you should put money aside just for that.
