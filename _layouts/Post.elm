module Post exposing (main, metadataHtml)

import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes as Attr exposing (alt, attribute, class, href, src)
import Page
import Layout

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


main : Elmstatic.Layout
main =
    Elmstatic.layout Elmstatic.decodePost <|
        \content ->
            (content.content
                |> Page.parseBlocks
                |> (\blocks ->
                        [ metadataHtml content ]
                            ++ [ Html.hr [] [], Page.markdown blocks ]
                   )
            )
                |> Page.layout content.title (content.content|> Page.parseBlocks|>Page.tableOfContent|> Layout.el [Attr.position "sticky", Attr.top "0"] )
                |> Ok
