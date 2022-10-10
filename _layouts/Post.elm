module Post exposing (main, metadataHtml)

import Elmstatic exposing (..)
import Generated.Toc
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
                                |> String.toLower
                                |> String.contains (key |> String.toLower)
                        )
                    |> String.join ", "
                    |> Html.text
              ]
                |> Html.p []
            , Html.br [] []
            , Html.br [] []
            , Page.markdown blocks
            ]
                |> Page.layout content.title
                    { leftSidebar =
                        blocks
                            |> TableOfContent.view
                            |> Layout.column
                                [ Attr.style "position" "sticky"
                                , Attr.style "top" "0"
                                , Attr.style "padding" "8px"
                                ]
                            |> List.singleton
                    , rightSidebar =
                        Html.h2 [] [ Html.text "Posts" ]
                            :: (Generated.Toc.posts
                                    |> List.map
                                        (\{ title, path } ->
                                            Html.a [ "/posts/" ++ path |> Attr.href ] [ Html.text title ]
                                        )
                                    |> List.intersperse (Html.br [] [])
                               )
                            |> Layout.column [ Attr.style "padding" "8px" ]
                            |> List.singleton
                    }
                |> Ok
        )
