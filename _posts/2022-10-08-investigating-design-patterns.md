---
title: "Investigating Design Patterns"
tags: [Elm,Functional Programming,Monad]
---
There is this myth, that functional programming does not have any design patterns. [See Functional Design Patterns by Scott Wlaschin](https://www.youtube.com/watch?v=srQt1NAHYC0)

I wanted to know myself if this is actually a valid statement and if not how many design pattern are actually outdated in the days of functional programming. My language of choice will be Elm.

I will use ✅ for patterns that have a place in function programming and ❌ for patterns that are too easy to really call them a "pattern" or for patterns that are simply outdated.

# Creational Patterns

## ❌ Factory Pattern

[https://refactoring.guru/design-patterns/factory-method](https://refactoring.guru/design-patterns/factory-method)

```
type TrasportationType
    = Road
    | Sea

createTruck : Transport

createShip : Transport

transportFactory : TransportationType -> Transport
```

The factory pattern is just a function that takes some additional arguments to decide how to construct a structure.

## ❌ Abstract Factory Pattern

[https://refactoring.guru/design-patterns/abstract-factory](https://refactoring.guru/design-patterns/abstract-factory)

```
type FurnitureType
    = Chair
    | CoffeeTable
    | Sofa

type FurnitureStyle
    = Victorian
    | Modern

modernFactory : FurnitureType -> Furniture

victorianFactory : FurnitureType -> Furniture

furnitureFactory : FurnitureStyle -> FurnitureType -> Furniture
```

An abstract factory pattern is just a partial function.

## ✅ Builder Pattern

[https://refactoring.guru/design-patterns/builder](https://refactoring.guru/design-patterns/builder)

```
newHouse : HouseBuilder

withWalls : WallDesign -> HouseBuilder -> HouseBuilder

withDoors : DoorDesign -> HouseBuilder -> HouseBuilder

withWindows : WindowDesign -> HouseBuilder -> HouseBuilder

withRoof : RoofDesign -> HouseBuilder -> HouseBuilder

withGarage : GarageDesign -> HouseBuilder -> HouseBuilder

build : HouseBuilder -> House
```

The builder pattern use a seperate builder to collect all the information needed for constructing the desired structure.

## ❌ Singleton Pattern

[https://refactoring.guru/design-patterns/singleton](https://refactoring.guru/design-patterns/singleton)

The singleton pattern is the default behavior for functional programming.

## ❌ Prototype Pattern

[https://refactoring.guru/design-patterns/prototype](https://refactoring.guru/design-patterns/prototype)

Coping is the default behavior of functional programming, therefor the prototype makes no sense in this context.

# Structural Patterns

## ❌ Adapter Pattern

[https://refactoring.guru/design-patterns/adapter](https://refactoring.guru/design-patterns/adapter)

```
computeXml : XML -> XML

xmlToJson : XML -> Json

jsonToXml : Json -> XML

jsonAdapter : (XML -> XML) -> Json -> Json
```

A adapter is just a higher order function with a set of mappers.

## ❌ Bridge Pattern

[https://refactoring.guru/design-patterns/bridge](https://refactoring.guru/design-patterns/bridge)

The bridge pattern uses composition over inherence. This is the default behavior for functional programming.

## ❌ Composite Pattern

[https://refactoring.guru/design-patterns/composite](https://refactoring.guru/design-patterns/composite)

```
type Order
    = Product { price : Int }
    | Box (List Order)

calculatePrice : Order -> Int
calculatePrice order =
    case order of
        Product {price} ->
            price
        Box list ->
            list
                |> List.map calculatePrice
                |> List.sum
```

The composite pattern is just a recursive type and a recursive function to go with it.

Note the function on display is not tail recursive and therefore not the most efficient.

## ❌ Decorator Pattern

[https://refactoring.guru/design-patterns/decorator](https://refactoring.guru/design-patterns/decorator)

```
sendEmail : {email : String} -> String -> Cmd msg

sendSms : {phone : String} -> String -> Cmd msg

sendFacebook : {facebookId : String} -> String -> Cmd msg

sendSlack : {slackId : String} -> String -> Cmd msg

andThen : (String -> Cmd msg) -> (String,Cmd msg) -> (String,Cmd msg)
```

The decorator pattern makes no real sense in the context of functional programming, however we can produce the same behavior using the Monad pattern.

In this example `(String,Cmd msg)` is the monad, passing the string to various functions.

## ❌ Facade Pattern

[https://refactoring.guru/design-patterns/facade](https://refactoring.guru/design-patterns/facade)

The facade pattern is essentially saying that one can write simpler modules that call more complicated onces.

## ✅ Flyweight Pattern

[https://refactoring.guru/design-patterns/flyweight]
(https://refactoring.guru/design-patterns/flyweight)

```
type alias MovingParticle
    { particle: Id
    , state : ParticleState
    }

type alias Game =
    { particles : Dict Id Particle
    , movingParticles : Dict Position MovingParticle
    }
```

The flyweight pattern states that for memory intense structures, one should store the common parts in a dictionary and only reference it by its id.

## ✅ Proxy Pattern

[https://refactoring.guru/design-patterns/proxy](https://refactoring.guru/design-patterns/proxy)

```
pay : Int -> CreditCard -> CreditCard

syncCreditCard : CreditCard -> Cmd msg
```

The proxy pattern simplifies time and resource intense computations by creating a proxy structure that simulates the computation and regularly syncs up with the real thing.

# Behavioral Patterns

## ✅ Chain of Responsibility

[https://refactoring.guru/design-patterns/chain-of-responsibility](https://refactoring.guru/design-patterns/chain-of-responsibility)

```
type Handler =
    Request -> Maybe Response

handleRequest : Request -> List Handler -> Maybe Response
handleRequest request handlers =
    case handlers of
        [] -> Nothing
        head :: tail ->
            case head request of
                Just head ->
                    Just head
                Nothing ->
                    handleRequest request tail
```
The chain of responsibility is a list of possible implementation. We go through the list and find the first implementation that is successful.

## ❌ Command

[https://refactoring.guru/design-patterns/command](https://refactoring.guru/design-patterns/command)

```
type alias Command =
    State -> State

copy : String -> Command

cut : Segment -> Command

paste : Segment -> Command

undo : Command

execute : Command -> State -> State
```

The Command pattern uses functions as data to separate the creation of the function from the execution.

## ❌ Iterator

[https://refactoring.guru/design-patterns/iterator](https://refactoring.guru/design-patterns/iterator)

Folding takes the role of iterators in functional programming.

## ✅ Mediator Pattern

[https://refactoring.guru/design-patterns/mediator](https://refactoring.guru/design-patterns/mediator)

```
type alias Mediator =
    { components : Dict String (State -> State)
    , state : State
    }

notify : String -> Mediator -> Mediator
notify component mediator =
    let
        fun = 
            mediator.components
                |> Dict.get component
    in
    {mediator | state = fun mediator.state}
```

The Mediator is a dictionary containing update functions.

## ❌ Memento Pattern

[https://refactoring.guru/design-patterns/memento](https://refactoring.guru/design-patterns/memento)

```
type Editor =
    Editor (State,List State)

save : Editor -> Editor
save (Editor (state,list)) =
    Editor (state,state :: list)

undo : Editor -> Editor
undo (Editor (state,list)) =
    case list of
        head :: tail ->
            Editor (head, tail)
        [] -> 
            Editor (state,list)
```

The Memento pattern is an opaque non empty list with functions to push onto and pull from the list.

## ✅ Observer Pattern

[https://refactoring.guru/design-patterns/observer](https://refactoring.guru/design-patterns/observer)

```
type alias Model =
    { subscriber : List (State -> State)
    , state : State
    }

notifySubscriber : Model -> Model
notifySubscriber model =
    { model
    | state =
        model.subscriber
            |> List.foldl 
                (\fun state -> fun state )
                model.state
    }
```

The Observer Pattern is nothing more then folding over a list of update functions.

## ✅ State Pattern

[https://refactoring.guru/design-patterns/state](https://refactoring.guru/design-patterns/state)

```
type alias State =
    { document : Document
    , publish : Document -> State
    , render : Document -> Html msg
    }

draft : Document -> State
draft document =
    { document = document
    , publish =
        (\d ->
            if d.isAdmin then
                published d
            else
                moderation d
        )
    , render = renderDraft
    }

moderation : Document -> State
moderation document =
    { document = document
    , publish = (\_ -> published document)
    , render = renderModeration
    }

published : Document -> State
published document =
    { document = document
    , publish = (\_ -> published document)
    , render = renderPublished
    }

renderDraft : Document -> Html msg

renderModeration : Document -> Html msg

renderPublished : Document -> Html msg
```
The article argues against a state machine, as it might not scale that well.

Instead, the State pattern uses functions inside a record. This way it can chance during runtime. 

I would however only advice this pattern, if a state machine does not do the job.

## ❌ Strategy Pattern

[https://refactoring.guru/design-patterns/strategy](https://refactoring.guru/design-patterns/strategy)

```
type alias RouteStrategy =
    Point -> Route -> Route

buildRoute: RouteStrategy -> List Point -> Route

roadStrategy : RouteStrategy

walkingStrategy : RouteStrategy

publicTransportStrategy : RouteStrategy
```

The strategy pattern is nothing more than a higher order function. 

## ✅ Template Pattern

[https://refactoring.guru/design-patterns/template-method](https://refactoring.guru/design-patterns/template-method)

```
type alias Template =
    { extractData : File -> String
    , parseData : String -> Data
    , analyseData : Data -> Analysis
    , toReport : Analysis -> Report
    } 

defaultTemplate : Template

mineData : Template -> File -> Report
```

The idea behind the template pattern is to have a record containing all subfunctions required for the task.

## ❌ Visitor Pattern

[https://refactoring.guru/design-patterns/visitor](https://refactoring.guru/design-patterns/visitor)

```
type alias ExportVisitor a =
    a -> Excel

exportFromCity : ExportVisitor City

exportFromIndustry : ExportVisitor Industry

exportFromSightSeeing : ExportVisitor Excel
```

A Visitor is just a function where the implementation depends on the input. Note how it does not matter how `City`, `Industry` and `Visitor` relate with each other. In the example they are part of a Union Type, but this does not has to be.