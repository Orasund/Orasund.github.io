module Styles exposing (styles)

import Css exposing (..)
import Css.Global exposing (..)
import Css.Media exposing (..)
import Html exposing (Html)
import Html.Styled


styles : Html msg
styles =
    let
        codeStyle =
            [ fontFamilies [ "Inconsolata", .value monospace ]
            , Css.px 8 |> Css.borderRadius
            ]
    in
    global
        [ body
            [ padding <| px 0
            , margin <| px 0
            , backgroundColor <| hex "fffbf8"
            , Css.color <| hex "363636"
            , fontFamilies [ "Open Sans", "Arial", .value sansSerif ]
            , fontSize <| px 18
            , lineHeight <| Css.px 32
            ]
        , a
            [ Css.color <| hex "348aa7"
            , textDecoration none
            ]
        , code codeStyle
        , each [ h1, h2, h3, h4, h5, h6 ]
            [ fontFamilies [ "Proza Libre", "Helvetica", .value sansSerif ]
            , lineHeight <| Css.px 32
            , Css.px -8 |> Css.marginLeft
            , Css.px -8 |> Css.marginRight
            ]
        , class "title"
            [ fontSize <| Css.em 1.8
            , Css.property "margin-block-start" "0px"
            , Css.property "margin-block-end" "64px"
            , Css.height Css.inherit
            , Css.px 16 |> Css.paddingLeft
            , Css.px 16 |> Css.paddingRight
            , Css.px -24 |> Css.marginLeft
            , Css.px -24 |> Css.marginRight
            ]
        , h1
            [ fontSize <| Css.em 1.33333
            , Css.borderBottom3 (Css.px 1) Css.solid (Css.hex "363636")
            , Css.property "margin-block-start" "64px"
            , Css.property "margin-block-end" "32px"
            , Css.boxSizing Css.borderBox
            , Css.px 32 |> Css.height
            ]
        , h2
            [ fontSize <| Css.em 1.2
            , marginBottom <| rem 0.80808
            , Css.property "margin-block-start" "32px"
            , Css.property "margin-block-end" "32px"
            ]
        , each [ h3, h5, h6 ]
            [ fontSize <| Css.em 1.0
            , Css.property "margin-block-start" "32px"
            , Css.property "margin-block-end" "0px"
            ]
        , Css.Global.small [ fontSize <| pct 65 ]
        , Css.Global.ul [ Css.property "padding-inline-start" "30px" ]
        , Css.Global.ol [ Css.property "padding-inline-start" "30px" ]
        , Css.Global.p
            [ Css.property "margin-block-start" "32px"
            , Css.property "margin-block-end" "32px"
            ]
        , each [ class "sidebar", class "sidebar2" ]
            [ fontSize <| Css.em 0.9
            , descendants [ each [ h1, h2, h3 ] [ Css.margin Css.zero ] ]
            , 64 |> px |> paddingTop
            ]
        , class "navigation"
            [ textAlign center
            , backgroundColor <| hex "F0F0F0"
            , Css.padding <| Css.px 16
            ]
        , class "content"
            [ Css.maxWidth <| vw 100
            , Css.padding2 (Css.px 32) (Css.px 40)
            , "linear-gradient(#F0F0F0 1px, transparent 0), "
                ++ "linear-gradient(90deg, #F0F0F0 1px, transparent 0)"
                |> Css.property "background-image"
            , Css.backgroundSize2 (Css.px 32) (Css.px 32)
            ]
        , class "footer"
            [ textAlign center
            , backgroundColor <| hex "348aa7"
            , Css.color <| hex "ffffff"
            , descendants
                [ a [ Css.color <| hex "ffffff", textDecoration none ]
                , svg [ paddingRight <| px 5, verticalAlign baseline ]
                ]
            , Css.padding <| Css.px 16
            ]
        , class "post-metadata"
            [ Css.height <| Css.px 32
            , marginTop <| Css.px 32
            , marginBottom <| Css.px 32
            , descendants
                [ each [ a, span ]
                    [ display inlineBlock
                    , marginRight <| px 5
                    ]
                , a
                    [ borderRadius <| px 16
                    , backgroundColor <| hex "348aa7"
                    , Css.color <| Css.hex "fff"
                    , paddingLeft <| px 8
                    , paddingRight <| px 8
                    , Css.px 24 |> Css.lineHeight
                    ]
                ]
            ]
        ]
        |> Html.Styled.toUnstyled
