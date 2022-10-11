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
            a [ href <| tagLink tag ]
                [ tag
                    |> String.split " "
                    |> List.map
                        (\s ->
                            case String.toList s of
                                head :: tail ->
                                    Char.toUpper head
                                        :: tail
                                        |> String.fromList

                                [] ->
                                    ""
                        )
                    |> String.join " "
                    |> text
                ]
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
            , Page.markdown blocks
            ]
                |> Page.layout content.title
                    { leftSidebar =
                        [ Html.h2 [] [ Html.text "Posts" ]
                        , Html.br [] []
                        ]
                            ++ (Generated.Toc.posts
                                    |> List.map
                                        (\{ title, path } ->
                                            Html.a [ "/posts/" ++ path |> Attr.href ] [ Html.text title ]
                                        )
                               )
                            |> Layout.column
                                [ Attr.style "padding" "8px"
                                , Attr.style "float" "right" 
                                ]
                            |> List.singleton
                    , rightSidebar =
                        blocks
                            |> TableOfContent.view
                            |> Layout.column
                                [ Attr.style "position" "sticky"
                                , Attr.style "top" "0"
                                , Attr.style "padding" "8px"
                                ]
                            |> List.singleton
                    }
                |> Ok
        )
