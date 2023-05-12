---
title: "Three Programming Practices For Working In Teams"
tags: [Clean Code]
---
# Three Programming Practices For Working in Teams

If you work on your own, you can get away with quite a lot of things that one would otherwise consider bad practices.

However, as soon as you work in a team things change. 
Now you have to take into account how you communicated with each other, 
which words you use and how you can combine your individual programming styles into some guidelines that make your code look cohesive.

I now present ten programming practices, that i consider a good set of rules that make things generally easier without much tradeoff.

## 1. KISS - Keep it simple and stupid

You might feel inclined to write a perfect algorithm, that solves your problem to perfection.
It might be the perfect fit for this one design pattern you always wanted to used at some point.
And maybe your result is even nicely documented with comments explaining exactly why specific edge cases required a more complicated approach.

However, code need to be maintained. And at some point the specification changed and something has to go into the algorithm and extend it.
You can't do it - you probably have other things to do - so you hand over the task to your junior developer or even do a midlevel developer that you can trust.

They will go in and add the change. It works, it maybe even tested. Perfect, right?

Wrong. Remember how you where proud of catching all the edge cases? Well, how do you know that this next developer has also though of all the edge cases?
Have you written them down somewhere?
And what about your design pattern - a midlevel developer might know that pattern and might even know you can extend it without breaking it.
But a junior developer will most likely destroy or abuse it.

**Keep it simple**

A way better approach would have been to write an algorithm that covers 80% of the cases. For the remaining 20% you fail fast and fail loud.
Let the user know, that they encountered an edge case and should get in contact.

This gives you a good indicated which edges happen a lot and you might sind that you can handle these cases somewhere earlier in the code.

**Keep it stupid**

The resulting algorithm should really be as straight forward as possible. A junior developer should understand what is does.
For the places where you might need a trick, you explain what trick you are using and why.
This should be enough for any developer to really be able to maintain the code.

## 2. The scout rule - Leave the coder cleaner than before

You always write the cleanest code possible - of course you do.
But you can't enforce the same for all your team members.
You only have that much time and its simply impossible to look over every Pull Request.

That's where the scout rule comes to the rescue and really steals the show:

Whenever you encoder some bad code - just clean it up a bit. Most of the time you already did too much. The moment you ask yourself if you might rewrite this one function, you might already go a bit overboard. Think simple: whats the smallest change that would make the biggest impact?

It also does not have to just be you cleaning up. Your team can help. A junior developer might not spot bad code right away or might start refactoring parts that where perfectly fine - but these refactors most often start a conversation with the junior developer. And you can be sure, they will definitely learn and profit from it. The next time they encounter the same code smell, they will definitely know what to do.

Now, that you and your team practice the scout rule, you might even notice that you don't have to always write perfectly clean code. It's okay to just quickly get the idea out and only later come back and clean it up.

## 3. It's okay not to generalize

We all heard scary bed time stories about code that got duplicated multiple times and how maintaining that code was a nightmare.

But you might also have experienced code bases where everything is generalized to a point where you need to touch five different files just to change a small thing.

The truth lies somewhere in between and im here to tell you: It's ok to generalize. Actually you can even have duplicated code lying around without doing any harm. A good rule of thump is:

**Try to generalize just before it gets a burden to maintain otherwise.**

Same goes with classes: Classes can be an unwanted overhead. Sometimes its enough to add a comment that separates the functions from the rest.
