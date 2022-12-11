Whenever I write a game in Elm, i tend to use [JohnBugner/elm-bag](https://dark.elm.dmy.fr/packages/JohnBugner/elm-bag/latest/) at some point.
But whenever i do, I actually want a more general implementation that can use any type as key.

> A bag is a set that can store a key multiple times.

So I'd like to use this opportunity to discuss different ways how I have design libraries sofar and what benefits different design might be. After that i might go and actually implement this, but that's not part of this essay.

For each implementation we will first look at the data type, then we will discuss three different functions: `empty`, `insert` and `toList`. We will then consider variations and look into benefits or possible pitfalls with it.

# Base Implementation

Let's start by a very basic implementation. I will purposefully try not to be smart about this, so that we than can discuss different implementations bases on this one.

``` elm
type alias AnyBag comparable =
    Dict comparable Int
```

Let's start with an implementation that actually doesn't solve the problem at all. Instead we will try to design our functions such that i allows to get and set any key.

``` elm
empty : AnyBag comparable
empty =
    Dict.empty
```

Constructing an empty bag is exactly the same as for a dict.

``` elm
insert : (key -> comparable) -> key -> AnyBag comparable -> AnyBag comparable
insert  encode key =
    Dict.get (encode key)
```

To insert an element we have to provide a function that converts the element into a comparable type.

``` elm
toList : (comparable -> key) -> key ->  AnyBag comparable -> List (key,Int)
toList decode key bag=
    bag
    |> Dict.toList
    |> List.map (Tuple.mapFirst decode)
```

To return a list we have to provide a function that converts the comparable type back into the key.

Is implementation is of course not perfect. The first problem that you might have noticed already is that if we have to different bags, with different encoder/decoders, that the type does not give any information as to which encoder/decoder to use. We can fix this by using a phantom type (= an additional type variable that's not used in the implementation itself.)

``` elm
type AnyBag comparable key =
    AnyBag (Dict comparable Int)
```

The second problem we might notice is that you always have to provide the same encoder and decoder and if you use the wrong function, you will get a wrong result. 

# Type with Functions

An idea for how you could ensure that the encoder and decoder function always are the same, is to add them to the type definition itself.

``` elm
type alias AnyBag comparable key =
    { dict : Dict comparable Int
    , encode : key -> comparable
    , decode : comparable -> key
    }
```

As you can see, we now have the type of the key as a type variable as well, so no need to use a phantom type.

``` elm
empty : {encode : key -> comparable, encode : comparable -> key} -> AnyBag comparable key
empty args =
    { dict = Dict.empty
    , encode = args.encode
    , decode = args.decode
    }
```

To construct an empty bag, we have to provide the two converter functions. Gladly, we only have to specify them once.

``` elm
insert : key -> AnyBag comparable key -> AnyBag comparable key
insert a bag =
    {bag 
    | dict = 
        bag.dict 
            |> Dict.update (bag.encode a)
                (\maybe ->
                    maybe 
                    |> Maybe.map ((+) 1)
                    |> Maybe.witDefault 1
                    |> Just
                )
    }
```

Inserting an element works just as expected

``` elm
toList : AnyBag comparable key -> List (key,Int)
toList bag =
    bag.dict
    |> Dict.toList
    |> List.map (Tuple.mapFirst bag.decode)
```

Also converting to a list looks nice.

Of course this only works if we can ensure that the functions don't change. On way to enforce this, we could use a Opaque type (= not exposing the constructor of the type).

A downside to this approach is sadly that Elm can't compare functions and so we would run into a runtime error whenever we try to compare two `AnyBag`'s. However most often this is not a problem. 

What is a problem in real life examples however is that you might have a decoder of type `comparable -> Maybe key`. You can fix this, by changing the implementation details of `insert`:

``` elm
insert : key -> AnyBag comparable key -> AnyBag comparable key
insert a bag =
    bag.encode a
    |> Maybe.map (\element -> 
        Dict.update element 
            (\maybe ->
                maybe
                |> Maybe.map ((+) 1)
                |> Maybe.withDefault 1
                |> Just
            )
            bag.dict
    )
    |> Maybe.map (\dict -> {bag | dict = dict})
    |> Maybe.withDefault bag
```

# Type with just the encoder

We have seen that the decoder could make some problems. So lets design a type that does not need a decoder.

I've first seen this idea implemented by [turboMaCk in their implementation of AnyDict](https://dark.elm.dmy.fr/packages/turboMaCk/any-dict/latest/).

``` elm
type alias AnyBag comparable key =
    { dict : Dict comparable (key,Int)
    , encode : key -> comparable
    }
```

It might not be obvious at first, why we included the key into the values of the dict. We will see the important's of that small change later.

``` elm
empty : (key -> comparable) -> AnyBag comparable key
empty encode =
    { dict = Dict.empty
    , encode = encode
    }
```

Constructing a bag got a bit simpler as before.

``` elm
insert : key -> AnyBag comparable key -> AnyBag comparable key
insert key bag =
    { bag 
    | dict =
        Dict.update (bag.encode key)
            (\maybe ->
                maybe
                |> Maybe.map (Tuple.mapSecond ((+) 1))
                |> Maybe.withDefault (key,1)
                |> Just
            )
            bag.dict
    }
```

For inserting an item, we have a bit more code as before, but it should will be understandable.

``` elm
toList : AnyBag comparable key -> List (key,Int)
toList bag =
    bag.dict |> Dict.values
```

For converting into a list we see our approach shine. By having the values already as `(key,Int)`, we just have to get them.

As before we again need to ensure that the key and the first value of the tuple are always the same.

``` elm
isValid : AnyBag comparable key -> Bool
isValid bag =
    bag.dict
    |> Dict.toList
    |> List.all (\(k1,(k2,_)) -> k1 == k2)
```

This is of course a liability. We are all humans and humans tend to do stupid things. So now more then ever, we should make the type opaque to really ensure nobody can shoot themselves in the foot. However there are downsides to using opaque types. In particular nobody can extend your library without rewriting the type and who knows how long you intend to maintain your library.

# Association Lists

Up until this point we assumed that we are really needing a dictionary, however for small amounts of values an association list may be faster.

``` elm
type alias AnyBag key =
    Array (key,Int)
```

The type is again trivially simple. Also notice how we now don't need to use a `comparable` type variable.

``` elm
empty : AnyBag key
empty =
    []
```

Constructing an empty bag is as simple as can be.

``` elm
insert : key -> AnyBag key -> AnyBag key
insert key bag =
    let
        rec : (AnyBag key,AnyBag key) -> AnyBag key
        rec (unchecked,checked) =
            case unchecked of
                (k,n) :: tail ->
                    if k == key then
                        (k,n + 1) :: tail ++ checked
                    else
                        rec (tail,(k,n) :: checked)
                [] ->
                    (key,1) :: checked
    in
    rec (bag,[])
```

Inserting an element is a bit tricky, but the idea is to add 1 to the first occurrence of the key. If the key does not exist, we add it to the front.

``` elm
toList : AnyBag key -> List key
toList bag =
    let
        unique : (key,List key,List key) -> List key
        unique (last,tail,output) =
            case tail of
                head :: rest ->
                    if last == head then
                        unique (last,rest,output)
                    else
                        unique (head,rest,last::output)
                [] ->
                    last::output
    in
    case bag of
        head :: tail ->
            unique (head,tail,[])
                |> List.sort
        [] ->
            []
```

One might naively believe that `toList` is not really needed. But for a real dictionary we would expect the result to have two properties: First we would expect each element to be unique (which in our implementation it not). Second the result is typically ordered - this is to ensure that the order does not change during time (which is also not valid as `insert` shuffles the elements around quite randomly).

This design is nearly perfect with no obvious problem (at least not for me). Of course performance wise, searching a list take O(n) time, where as a map needs O(log n) times. This means that for larger sets of data the association list becomes unuseable. The exact n for which the search time gets larger depends on implementation details and should be tested. But as a rough rule of thumb: If you intend to store less then 100 different keys, then an association list might be your best choice both in usability and performance.