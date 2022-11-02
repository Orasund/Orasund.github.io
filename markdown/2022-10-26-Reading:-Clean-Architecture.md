# What is Design and Architecture

> There is no difference between them. None at all.

"Architecture" is used in context of high level. "Design" is more low level.

# A Tale of two values

# Paradigm Overview

Strucuted(Imperative) Programming, Object Oriented Programing and Functional Programming

## Structured Programmings

Not use `goto`, use `ifThenElse` and `while`/`for` instead.

## Object Oriented Programming

Functions and variables should be grouped by the Objects that they transform.

## Functional Programming

Functions should not change existing values.

> One of the most common compromises in regards to immutability is to separate the application into mutable and immutable components.

### Event Sourcing

aka. Event Stream

Main Idea: Assume all events can be stored in a single list/stream.

You might not actually store everything for eternity and you might need a lot of storage to do so, but as a benefit you can work completely with pure functions.

# Design Principles

aka SOLID Principles

Solid principles look at groupings. (in OOP Objects, in PF namespaces and types).

SOLID Principles is about designing the interactions between groups - interfaces, types, compositions, inheritances.

## Single Responsibility Principle

A group should only ever have one common attribute.

The following type violated this principle.

```
{-| Don't do this -}
type AnimalOrBuilding
    = Cat CatState
    | Dog DogState
    | Cinema CinemaState
    | Shop ShopState

toString : AnimalOrBuilding -> String

isHungry : AnimalOrBuilding -> Bool

isOpen : AnimalOrBuilding -> Bool
```

Here we group things that are either animals or building. To fix this we need to understand why we need animals and building in the same type. Maybe we are creating a game and want to display both animals and buildings on the screen. After a bit of consideration we might come up with something like the following.

```
type Entity
    = AnimalEntity Animal
    | BuildingEntity Building

type Animal
    = Cat CatState
    | Dog DogState

type Building
    = Cinema CinemaState
    | Shop ShopState

toString : Entity -> String

isHungry : Animal -> Bool

isOpen : Building -> Bool
```

## The Open-Closed Principle

External groups should not be able to change design decisions.

Consider the following structure

```
module Dog exposing (replaceAllDogs)

import World exposing (World)

replaceAllDogs : Dog -> World -> World
```

Here the module responsible for the dog can modify the world. Something like that is often the root cause of circular dependencies (`World` can modify `Dog` and `Dog` can modify `World`).

We should move `replaceAllDogs` into the `World` module. If we can't do this - for example because `World` is part of an external library - then we have to create an extension of the existing module.

```
module World.Extra exposing (replaceAllAnimals)

replaceAllAnimals : Animal -> World -> World
```

## The Liskov substitution principle

This principle states that the implementation should not change for subtypes.

Say we have a function that behaves seemingly completely different for Animals as for Buildings.

```
type Entity
    = Animal { lastEaten : Food }
    | Building { people : List String }

add : String -> Entity -> Entity
add string entity =
    case entity of
        Animal _ ->
            Animal {lastEaten = foodFromString string }
        Building {people} ->
            Building {people = string :: people} 
```

This is bad design, as it requires the user to know the implemented behavior. So instead we should split this function and maybe also rename it to something more useful.

```
feed : String -> Entity -> Maybe Entity
feed string entity =
    case entity of
        Animal _ ->
            Just (Animal {lastEaten = foodFromString string })
        _ ->
            Nothing

enter : Entity -> Maybe Entity
enter entity =
    case entity of
        Building {people} ->
            Just (Building {people = string :: people})
        _ ->
            Nothing
```

## The Interface Segregation Principle

groups should only contain as little as possible.

Going back to the previous example of joining animals and buildings into entities. Now assume we want to be really smart and replace the custom type with a record.

```
type alias Entity =
    { name : String
    , isOpen : Maybe Bool
    , isHungry : Maybe Bool
    }

isCat entity =
    entity.isHungry /= Nothing

isBuilding entity =
    entity.isOpen /= Nothing
```

Whenever we want to add or change a field related to cats, we would need to also check that the code related to buildings is still working.

So instead, we should only group the most necessary fields.

```
type alias EntityState =
    { name : String
    , sort : EntitySort
    }

type EntitySort
    = Animal { isHungry : Bool }
    | Building { isOpen : Bool }
```
