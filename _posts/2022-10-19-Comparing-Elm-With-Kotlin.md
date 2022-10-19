---
title: "Comparing Elm With Kotlin"
tags: [elm,state machine]
---
I'm using Kotlin at work and Elm for hobby project. Every now and then I forget that im using Kotlin and try to write Kotlin in a more functional Style - just like i would in Elm.

Today I want to showcase some of those gotcha moments and discuss reasons why Kotlin might have decided against a more functional approach.

# Pattern Matching Pairs/Tuples

In Elm we like to use state machines to model our state. So something like the following might be considered idiomatic Elm.

```
type Model
    = LoginScreen LoginModel
    | LoggedIn LoggedInModel

type Msg
    = Login
    | Logout

update : Msg -> Model -> Model
update msg model =
    case (msg,model) of
        (Login,LoginScreen m) ->
            login m
        (Logout,LoggedIn m) ->
            logout m
        _ ->
            model
```

However in Kotlin you can't pattern match a pair(tuple). You have to do something like this:

```
sealed class Model
class LoginScreen(val model:LoginModel): Model
class LoggedIn(val model:LoggedInModel): Model

enum class Msg { Login, Logout }

fun update(val msg : Msg, val model : Model) : Model =
    when {
        msg == Login && model is LoginScreen -> login model
        msg == Logout && model is LoggedIn -> logout model
        else -> model
    }
```

The big difference here is that Kotlin uses smart cast to figure out that the model passed into `login` has a different type then the model passed into `logout`.

While this might seem odd at first, if you really think about the mechanics behind the scenes, that both approaches are actually very similar. While Elm uses pattern matching to figure out the correct type, Kotlin has to do the same task when smart casting. However: Elms type system is total, Kotlin's smart cast is not. That means in Kotlin you always need to hope that the smart cast is actually smart enough and if not, simply updating your Kotlin version might fix the problem. However the fact that smart casting is happing behind the scenes means, that you don't have to use a `when` block. You can also write the same thing using a couple of `if` blocks. This is something Elm completely lacks. But this also means that people coming from a Java world can use smart casting just with the knowledge they already have.

# Destructuring Lists

In Elm, lists are our bread and butter. Destructuring a list should be a no brainer.

```
case list of
    head :: tail ->
        someComputation head tail
    [] ->
        displayNoContent
```

In Kotlin this is not possible. The best you can do is the following

```
list.getOrNull(0)
    ?.let{ head ->
      val tail = list.drop(1)
      someComputation head tail
    }
    ?: displayNoContent
```

I don't know the reason for this - the underlying implementation is a LinkedList. More general, deconstructing isn't really a good idea in Kotlin, because deconstructing is ordered: The first argument of your constructor is the first argument of the deconstruction. Rearranging the arguments in the data structure might silently break your code - and thats not a good sign. So keep you hands off deconstructing anything (other than tuples).

# Result

Elm does not have Exceptions, it has Results. Kotlin also has results, but the Error Type is always Throwable. Not only that, Kotlin forces you to end the function with "Catching" if it returns a Result. To add insult to injury, you have to also create a function with the same name except "Catching".

This is intentionally. [The Kotlin Language Developers are still thinking about the Result type](https://github.com/Kotlin/KEEP/blob/master/proposals/stdlib/result.md) and do not want to break production code once they change their mind. So they currently only allow Result for very specific contexts. But until then, we should use Exceptions instead.