module Page.Posts/Slug_ exposing (Model, Msg, Data, page)

import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never

type alias RouteParams =
    { slug : String }

page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = data
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    DataSource.succeed []


data : RouteParams -> DataSource Data
data routeParams =
    File.bodyWithFrontmatter blogPostDecoder
        ("blog/"++ routeParams.slug ++".md")

type alias BlogPostMetadata =
    { body : String
    , title : String
    , tags : List String
    }

blogPostDecoder : String -> Decoder BlogPostMetadata
blogPostDecoder body =
    Decode.map2 (BlogPostMetadata body)
        (Decode.field "title" Decode.string)
        (Decode.field "tags" tagsDecoder)

tagsDecoder : Decoder (List String)
tagsDecoder =
    Decode.map (String.split " ")
        Decode.string



head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    ()


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    View.placeholder "Posts/Slug_"