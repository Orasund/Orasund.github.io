module Data.String exposing (..)


toUrlSaveVersion : String -> String
toUrlSaveVersion =
    String.map
        (\c ->
            if Char.isAlphaNum c then
                c

            else
                '_'
        )
