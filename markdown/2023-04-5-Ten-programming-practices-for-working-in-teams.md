If you work on your own, you can get away with quite a lot of things that one would otherwise consider bad practices.

However, as soon as you work in a team things change. 
Now you have to take into account how you communicated with eachother, 
which words you use and how you can combine your indiviual programming styles into some guidelines that make your code look cohesive.

I now present ten programming practices, that i consider a good set of rules that make things generally easier without much tradeoff.

## 1. Keep it simple and stupid

You might feel inclined to write a perfect algorithm, that solves your problem to perfection.
It might be the perfect fit for this one design pattern you always wanted to used at some point.
And maybe your result is even nicely documentated with comments explaining exactly why specific edge cases required a more complicated approach.

However, code need to be maintained. And at some point the specification changed and something has to go into the algorithm and extend it.
You can't do it - you proberbly have other things to do - so you hand over the task to your junior developer or even do a midlevel developer that you can trust.

They will go in and add the change. It works, it maybe even tested. Perfect, right?

Wrong. Remeber how you where proud of catching all the edge cases? Well, how do you know that this next developer has also though of all the edge cases?
Have you written them down somewhere?
And what about your design pattern - a midlevel developer might know that pattern and might even know you can extend it without breaking it.
But a junior developer will most likely destroy or abuse it.

**Keep it simple**

A way better approach would have been to write an algorithm that convers 80% of the cases. For the remaining 20% you fail fast and fail loud.
Let the user know, that they encoutered an edgecase and should get in contact.

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

It also does not have to just be you cleaning up. Your team can help. A junior developer might not spot bad code right away or might start refactoring parts that where perfectly fine - but these refactors most often start a conversation with the junior developer. And you can be sure, they will definetly learn and profit from it. The next time they encounter the same code smell, they will definelty know what to do.

Now, that you and your team pratice the scout rule, you might even notice that you don't have to always write perfectly clean code. It's okey to just quickly get the idea out and only later come back and clean it up.
