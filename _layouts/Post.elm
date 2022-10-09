module Post exposing (main, metadataHtml)

import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes as Attr exposing (class, href)
import LaData.String
import Page
import TableOfContent


tagsToHtml : List String -> List (Html Never)
tagsToHtml tags =
    let
        tagLink tag =
            "/tags/" ++ Data.String.toLower tag

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
    Elmstatic.layout Elmstatic.decodePost
        (\content ->
            let
                blocks =
                    content.content
                        |> Page.parseBlocks
            in
            [ metadataHtml content
            , [ Html.strong [] [ Html.text "Keywords:" ]
              , Html.text " "
              , keywords
                    |> List.filter
                        (\key ->
                            content.content
                                |> Data.String.toLower
                                |> Data.String.contains (key |> Data.String.toLower)
                        )
                    |> Data.String.join ", "
                    |> Html.text
              ]
                |> Html.p []
            , Html.br [] []
            , Html.br [] []
            , Page.markdown blocks
            ]
                |> Page.layout content.title
                    (blocks
                        |> TableOfContent.view
                        |> Layout.column [ Attr.style "position" "sticky", Attr.style "top" "0" ]
                        |> List.singleton
                    )
                |> Ok
        )
