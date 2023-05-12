---
title: "_Pure_Functions"
tags: [functional programming]
---
**About this Series**
_I noticed that for some reason its really hard to explain functional programming in a couple of sentences without getting to technical or theoretical.
I'd like to have a clear definition written down, one that I can show my colleges and that I can use to differentiate FP from OOP._

_In this series I try to explain functional programming. 
If my explaination falls apart, I have to start again but each time looking at it from a different persective._

# Pure Functions

Functional Programming is about thinking and using pure functions.

A function is "Pure" if it only returns an output with no side effects.

```
//Javascript
function subtractPrice(number) = { 
  // You are allowed to define constants in a pure function
  const price = 20

  return number - price
};
```

So lets look at a function that has side effects:

```
async function buy(userId) = {
  let user = await getUser(userId);
  user.money -= 20;
  await postUser(userId,user);
  return user;
};
```

Side effects are anything that changes something outside the function.
`postUser` is a remote calls so that is definetly a side effects.
But `getUser` while not modifying anything, it still triggers a process on a computer somewhere on the world.

Now comes a tricky question: Is `user.money -= 20;` a side effect?
One might argue that the user is defined inside the function, so modifing them is allowed.

And that might be correct, but it actually just depends on how strict you define "pure".

Lets say we would define a new function:

```
function subtractPriceFromUser(user) = {
  user.money -= 20;
  return;
}
```

Here we clearly modify something outside of the function.
So we can see that modifing a varaible might sometimes be considered a side effect.

So how can we do better?

```
async function buy(userId) = {
  return updateUser(userId,withPriceSubstracted)
}

//Sideeffects with not buisness logic
async function updateUser(userId,fun) = {
  const user = await getUser(userId).then(fun)
  await setUser(userId,user)
  return user
}

//buisness logic with no sideeffects
function withPriceSubtracted(user) = {
  return { ...user, money = user.money - 20 }
}
```

You might say, that not a lot has changed. 
And you would be correct. We are still doing the same things.
However, we seperated the pure part from the side effects. 

Thats the essence of functional programming.
