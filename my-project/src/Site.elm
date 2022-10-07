module Site exposing (config)

import DataSource
import DataSource.Glob
import Head
import Html exposing (a)
import Pages.Manifest as Manifest
import Route
import SiteConfig exposing (SiteConfig)


type alias Data =
    List String


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = "https://elm-pages.com"
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.Glob.succeed (\slug -> slug)
        |> DataSource.Glob.match (DataSource.Glob.literal "content/blog/")
        |> DataSource.Glob.capture DataSource.Glob.wildcard
        |> DataSource.Glob.match (DataSource.Glob.literal ".md")
        |> DataSource.Glob.toDataSource


head : Data -> List Head.Tag
head static =
    [ Head.sitemapLink "/sitemap.xml"
    ]


manifest : Data -> Manifest.Config
manifest static =
    Manifest.init
        { name = "Site Name"
        , description = "Description"
        , startUrl = Route.Index |> Route.toPath
        , icons = []
        }
