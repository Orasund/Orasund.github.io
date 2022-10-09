module Post exposing (main, metadataHtml)

import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes as Attr exposing (class, href)
import Layout
import Page
import TableOfContent


tagsToHtml : List String -> List (Html Never)
tagsToHtml tags =
    let
        tagLink tag =
            "/tags/" ++ String.toLower tag

        linkify tag =
            a [ href <| tagLink tag ] [ text tag ]
    in
    List.map linkify tags


metadataHtml : Elmstatic.Post -> Html Never
metadataHtml post =
    div [ class "post-metadata" ]
        ([ span [] [ text post.date ]
         , span [] [ text "•" ]
         ]
            ++ tagsToHtml post.tags
        )


keywords : List String
keywords =
    [ "Elm", "Functional Programming", "TDD", "Video", "Book" ]


main : Elmstatic.Layout
main =
    Elmstatic.layout Elmstatic.decodePost <|
        \content ->
            (content.content
                |> Page.parseBlocks
                |> (\blocks ->
                        [ metadataHtml content
                        , [ Html.strong [] [ Html.text "Keywords:" ]
                          , Html.text " "
                          , keywords
                                |> List.filter
                                    (\key ->
                                        content.content
                                            |> String.toLower
                                            |> String.contains (key |> String.toLower)
                                    )
                                |> String.join ", "
                                |> Html.text
                          ]
                            |> Html.p []
                        , Html.hr [] []
                        , Page.markdown blocks
                        ]
                   )
            )
                |> Page.layout content.title
                    (content.content
                        |> Page.parseBlocks
                        |> TableOfContent.view
                        |> Layout.column [ Attr.style "position" "sticky", Attr.style "top" "0" ]
                        |> List.singleton
                    )
                |> Ok
