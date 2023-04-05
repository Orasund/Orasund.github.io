If you work on your own, you can get away with quite a lot of things that one would otherwise consider bad practices.

However, as soon as you work in a team things change. 
Now you have to take into account how you communicated with eachother, 
which words you use and how you can combine your indiviual programming styles into some guidelines that make your code look cohesive.

I now present ten programming practices, that i consider a good set of rules that make things generally easier without much tradeoff.

## 1. Keep it stupid and simple

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

