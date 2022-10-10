module TableOfContent exposing (..)

import Data.String
import Html exposing (Html)
import Html.Attributes as Attr
import Markdown.Block


type Node
    = Node (List ( String, Node ))


addToNode : String -> Node -> Node
addToNode string (Node list) =
    Node (( string, Node [] ) :: list)


addSubNode : Node -> Node -> Node
addSubNode node (Node list) =
    case list of
        ( string, _ ) :: tail ->
            Node (( string, node ) :: tail)

        [] ->
            node


reverse : Node -> Node
reverse (Node list) =
    Node (List.reverse list)


toNodes : List ( Int, String ) -> Node
toNodes l =
    let
        rec : Int -> Node -> List ( Int, String ) -> ( Node, List ( Int, String ) )
        rec n node list =
            case list of
                ( n0, text ) :: tail ->
                    if n == n0 then
                        rec n (addToNode text node) tail

                    else if n < n0 then
                        list
                            |> rec (n + 1) (Node [])
                            |> (\( newNode, rest ) ->
                                    rest
                                        |> rec n (addSubNode (reverse newNode) node)
                               )

                    else
                        ( node, list )

                [] ->
                    ( node, list )
    in
    l
        |> rec 1 (Node [])
        |> Tuple.first
        |> reverse


viewNodes : Node -> Html Never
viewNodes (Node list) =
    list
        |> List.map
            (\( text, node ) ->
                [ Html.a [ "#" ++ (text |> Data.String.toUrlSaveVersion) |> Attr.href ] [ Html.text text ]
                , node
                    |> viewNodes
                ]
                    |> Html.li []
            )
        |> Html.ol []


view : List Markdown.Block.Block -> List (Html Never)
view list =
    [ Html.h2 [] [ Html.text "Table of Content" ]
    , list
        |> List.filterMap
            (\block ->
                case block of
                    Markdown.Block.Heading headingLevel inlines ->
                        let
                            n =
                                case headingLevel of
                                    Markdown.Block.H1 ->
                                        1

                                    Markdown.Block.H2 ->
                                        2

                                    Markdown.Block.H3 ->
                                        3

                                    Markdown.Block.H4 ->
                                        4

                                    Markdown.Block.H5 ->
                                        5

                                    Markdown.Block.H6 ->
                                        6

                            text =
                                inlines
                                    |> List.map
                                        (\inline ->
                                            case inline of
                                                Markdown.Block.Text s ->
                                                    s

                                                _ ->
                                                    ""
                                        )
                                    |> String.concat
                        in
                        Just ( n, text )

                    _ ->
                        Nothing
            )
        |> toNodes
        |> viewNodes
    ]
