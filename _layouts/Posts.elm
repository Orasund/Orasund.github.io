module Posts exposing (main)

import Elmstatic exposing (..)
import Html exposing (..)
import Html.Attributes as Attr
import Page
import Post


main : Elmstatic.Layout
main =
    let
        postItem post =
            div []
                [ a [ Attr.href ("/" ++ post.link) ] [ h2 [] [ text post.title ] ]
                , Post.metadataHtml post
                ]

        postListContent posts =
            if List.isEmpty posts then
                [ text "No posts yet!" ]

            else
                List.map postItem posts

        sortPosts posts =
            List.sortBy .date posts
                |> List.reverse
    in
    Elmstatic.layout Elmstatic.decodePostList <|
        \content ->
            sortPosts content.posts
                |> postListContent
                |> Page.layout
                    { siteTitle = content.siteTitle
                    , title = content.title
                    , leftSidebar = []
                    , rightSidebar = []
                    }
                |> Ok
