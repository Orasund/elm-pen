module Main exposing (main)

import ElmBook
import ElmBook.ThemeOptions
import Introduction


main : ElmBook.Book msg
main =
    ElmBook.book "Elm-Gen"
        |> ElmBook.withThemeOptions
            [ ElmBook.ThemeOptions.useHashBasedNavigation
            , ElmBook.ThemeOptions.subtitle "Generate your own Elm modules"
            ]
        |> ElmBook.withChapters
            [ Introduction.chapter ]
