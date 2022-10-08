---
title: "Investigating Design Patterns"
tags: Collection
---

I take my stand that design pattern are outdated in the days of functional programming.
Here is me proving my point using Elm.

# Behavioral Patterns

## Chain of Responsibility

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

## Command

```
type alias Command =
    State -> State

copy : String -> Command

cut : Segment -> Command

paste : Segment -> Command

undo : Command

execute : Command -> Editor -> Editor
execute command editor =
    { editor | state = command editor state }
```

The Command pattern uses functions as data to separate the create of the function from the execution.

## Iterator

In functional programming, Folding takes the role of iterators

## Mediator Pattern

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

The Mediator is a Dict containing update functions.

## Memento Pattern

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

## Observer Pattern

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

The Observer Pattern is nothing more then folding over a list of updateFunctions.

## State Pattern

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
                Published
            else
                Moderation
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
The main idea is to but the function in the record. This way it can chance during runtime. 

I would however only advice this pattern, if a state machine does not do the job.

## Strategy Pattern

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

## Template Pattern

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
mineData args file =
    file
    |> args.extractData
    |> internalFunction1
    |> args.parseData
    |> internalFunction2
    |> args.analyseData
    |> internalFunction3
    |> args.toReport
```

The idea behind the template pattern is to have a record containing all subfunctions required for the task.

## Visitor Pattern

[https://refactoring.guru/design-patterns/visitor](https://refactoring.guru/design-patterns/visitor)

```
type alias ExportVisitor a =
    a -> Excel

exportFromCity : ExportVisitor City

exportFromIndustry : ExportVisitor Industry

exportFromSightSeeing : ExportVisitor Excel
```

A Visitor is just a function where the implementation depends on the input. Note how it does not matter how `City`, `Industry` and `Visitor` relate with each other. In the example they are part of a Union Type, but this does not have to be.