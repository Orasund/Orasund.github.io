---
title: "Writing View APIs"
tags: [elm]
---
I recently stumpled appon my old version of [elm-ui-widgets](https://package.elm-lang.org/packages/Orasund/elm-ui-widgets/latest/) and started thinking.
Over the span of 4 year my style of programming views changed and it was interesting to see my mindshift.

We will now use the example of a dialog window to see and appraoch it from different directions.

> A Dialog is a pop-up window that overlays everything else.

A dialog maybe have a shade that makes the background less visible.
And the shade might be clickable. If so, then the dialog should close again.

I'd also like to customize the shade and the content of the dialog.

# 2019 - Components

My first approach was done as part of a [game engine called pixelEngine](https://package.elm-lang.org/packages/Orasund/pixelengine/latest/).
It looked something like this:

```
type Msg
  = Enable
  | Disable

type Dialog
  = Dialog 
      { isEnabled : Bool
      }

dialog : List (Attribute msg) 
  -> { content : Html msg
     , shadeAttributes : List (Attribute msg)
     , shade : Bool
     , onClick : Maybe (Msg -> msg)
     }
  -> Dialog
  -> Html msg
  -> Html msg

update : Msg -> Dialog -> Dialog

init : Model
```

Now let's test the api by having two buttons that can open different dialogs.
The dialog of the first button will have no shade, while the second dialog has a blue shade.
The first dialog should be closeable by clicking somewhere else, but the second should not be closeable at all.

```
Html.div []
  [ Html.button [ Html.Event.onClick OpenFirstDialog ] [ Html.text "Open first Dialog" ]
  , Html.button [ Html.Event.onClick OpenSecondDialog ] [ Html.text "Open second Dialog" ]
  ]
  |> dialog []
    { content = Html.text "Im the first dialog"
    , shadeAttributes = []
    , shade = False
    , onClick = Just UpdateFirstDialog
    }
    model.firstDialog
  |> dialog []
    { content = Html.text "Im the second dialog"
    , shadeAttributes = [ Html.Attributes.style "background-color" "blue" ]
    , shade = True
    , onClick = Nothing
    }
    model.secondDialog
```

# 2020 - View Function

In 2020 I heared that one should not use components, but instead view functions are the way to go.
However I had now idea how this should look like. So in the early version of [elm-ui-widgets](https://package.elm-lang.org/packages/Orasund/elm-ui-widgets/latest/)
my approach looked something like this:

```
type alias DialogStyle =
  { element : Attribute msg
  , shade : Attribute msg
  }

defaultStyle : DialogStyle

dialog : DialogStyle -> { shade : Bool, onClick : Maybe msg } -> Element msg -> Attribute msg
```

Note how the model is now gone and also how the return type is a Attribute. I expected that the user would now how to update a Bool.

Our Test case would now look like this:

```
Element.column
  [ if model.showFirstDialog then
      Element.text "Im the first dialog"
        |> dialog defaultStyle { shade : False, onClick : Just CloseFirstDialog }
    else
      Element.none
  , if model.showSecondDialog then
      Element.text "Im the second dialog"
        |> dialog { defaultStyle | shade = [ Element.Background.color Color.blue ] } 
          { shade : True, onClick : Nothing }
    else
      Element.none
  ]
  [ Element.Input.button { onPress = Just OpenFirstDialog, label = Element.text "Open first Dialog" }
  , Element.Input.button { onPress = Just OpenSecondDialog, label = Element.text "Open second Dialog" }
  ]
```

# 2021 Multiple Modals

In 2021 I started to notice that in nearly every application i wrote, there was an edge case where multiple dialogs would be present at the same time.
And I always needed to only show the shade behind the top most modal so i grouped the dialogs and renamed it into multiModal.

It looked something like this:

```
multiModal : List (Attribute msg) -> { onClick : Maybe msg , content : List (Element msg) } -> Attribute msg
```

If you want a custom shade, you have to implement it yourself.

And so our example now looks like this:

```
Element.column
  ( if model.showFirstDialog || model.showSecondDialog then
    [multiModal []
    { onClick = 
        if model.showFirstDialog then
          Just CloseFirstDialog
        else 
          Nothing
    , content =
      (if model.showFirstDialog then
          Element.text "Im the first dialog"
        else
          Element.none
      )
      ++ if model.showSecondDialog then
          [ Element.el 
              [ Element.height Element.fill
              , Element.width Element.fill
              , Element.htmlattribute (Html.Attributes.style "backdrop-filter" "blur(10px)")
              , Element.Background.color Color.blue
              ]
              Element.none
          , Element.text "Im the second dialog"
          ]
        else
          []
    }] else []
  )
  [ Element.Input.button [] { onPress = Just OpenFirstDialog, label = Element.text "Open first Dialog" }
  , Element.Input.button [] { onPress = Just OpenSecondDialog, label = Element.text "Open second Dialog" }
  ]
```

We clearly have to do more and more work, but it's also far easier to customize things.

# 2022 Just a Stack

In 2022 I started a new package called [elm-layout](https://package.elm-lang.org/packages/Orasund/elm-layout/latest/). The idea was to do as little as possible.
And so implemented a function that displays element on top of eachother and nothing more.

```
stack : List (Attribute msg) -> List (Html msg) -> Html msg -> Html msg
```

and the example now looks like this:

```
Layout.column []
  [ Html.text "Open first Dialog" |> Layout.el [ Layout.asButton (Just OpenFirstDialog) ] 
  , Html.text "Open second Dialog" |> Layout.el [ Layout.asButton (Just OpenSecondDialog) ]
  ]
  |> if model.showFirstDialog || model.showSecondDialog then
    stack []
    [ if model.showSecondDialog then 
        Html.text "Im the second dialog"
      else
        Layout.none
    , Layout.el 
        ( [ Html.Attributes.style "height" "100%"
          , Html.Attributes.style "width" "100%"
          ] 
            ++ (
              if model.showSecondDialog then
                [ Html.Attributes.style "backdrop-filter" "blur(10px)"
                , Html.Attributes.style "background-color" "blue"
                ]
              else
                [ Html.Event.onClick CloseFirstDialog ]
            )
        )
        Layout.none
    , if model.showFirstDialog then
        Html.text "Im the first dialog"
      else
        Layout.none
    ] else identity
```
