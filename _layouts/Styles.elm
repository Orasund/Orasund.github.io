module Styles exposing (styles)

import Css exposing (..)
import Css.Global exposing (..)
import Css.Media as Media exposing (..)
import Html exposing (Html)
import Html.Styled


styles : Html msg
styles =
    let
        wideScreen =
            withMedia [ only screen [ Media.minWidth <| Css.px 600 ] ]

        codeStyle =
            [ fontFamilies [ "Inconsolata", .value monospace ]
            , Css.px 8 |> Css.borderRadius
            ]
    in
    global
        [ body
            [ padding <| px 0
            , margin <| px 0
            , backgroundColor <| hex "ffffff"
            , Css.color <| hex "363636"
            , fontFamilies [ "Open Sans", "Arial", .value sansSerif ]
            , fontSize <| px 16
            , lineHeight <| Css.em 1.4
            ]
        , a
            [ Css.color <| hex "348aa7"
            , textDecoration none
            ]
        , code codeStyle
        , each [ h1, h2, h3, h4, h5, h6 ]
            [ fontFamilies [ "Proza Libre", "Helvetica", .value sansSerif ]
            , lineHeight <| Css.em 1.1
            ]
        , class "title" [ fontSize <| Css.em 2.0, marginBottom <| rem 1.61616 ]
        , h1
            [ fontSize <| Css.em 1.33333
            , marginBottom <| rem 1.21212
            , Css.borderBottom3 (Css.px 1) Css.solid (Css.hex "F0F0F0")
            , Css.paddingBottom (Css.px 4)
            ]
        , h2
            [ fontSize <| Css.em 1.2
            , marginBottom <| rem 0.80808
            ]
        , each [ h3, h5, h6 ] [ fontSize <| Css.em 1.0, marginBottom <| rem 0.60606 ]
        , p [ margin3 auto auto (rem 1.5) ]
        , Css.Global.small [ fontSize <| pct 65 ]
        , Css.Global.ul [ Css.property "padding-inline-start" "30px" ]
        , Css.Global.ol [ Css.property "padding-inline-start" "30px" ]
        , each [ class "sidebar", class "sidebar2" ]
            [ fontSize <| Css.em 0.9
            , descendants [ each [ h1, h2, h3 ] [ Css.margin Css.zero ] ]
            , 64 |> px |> paddingTop
            ]
        , class "header-logo"
            [ paddingTop <| px 6
            , textAlign center
            , backgroundColor <| hex "f2fae8"
            , wideScreen [ textAlign left, borderBottom3 (px 2) solid (hex "3c8765") ]
            ]
        , class "navigation"
            [ textAlign center
            , backgroundColor <| hex "f2fae8"
            , Css.padding <| Css.px 16
            ]
        , class "content"
            [ Css.maxWidth <| vw 100
            , Css.padding <| Css.px 16
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
            [ marginTop <| Css.em -0.5
            , marginBottom <| Css.em 2.0
            , descendants
                [ each [ a, span ]
                    [ display inlineBlock
                    , marginRight <| px 5
                    ]
                , a
                    [ border3 (px 1) solid (hex "e0e0e0")
                    , borderRadius <| px 3
                    , backgroundColor <| hex "f2fae8"
                    , paddingLeft <| px 5
                    , paddingRight <| px 5
                    ]
                ]
            ]
        ]
        |> Html.Styled.toUnstyled
