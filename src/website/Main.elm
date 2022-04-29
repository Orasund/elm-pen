module Main exposing (main)

import ElmBook
import ElmBook.ThemeOptions
import Introduction
import Template.Enum


main : ElmBook.Book msg
main =
    ElmBook.book "Elm-Gen"
        |> ElmBook.withThemeOptions
            [ ElmBook.ThemeOptions.useHashBasedNavigation
            , ElmBook.ThemeOptions.subtitle "Generate your own Elm modules"
            ]
        |> ElmBook.withChapterGroups
            [ ( "CLI", [ Introduction.chapter ] )
            , ( "Templates", [ Template.Enum.chapter ] )
            ]
