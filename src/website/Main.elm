module Main exposing (main)

import Cli.Introduction
import ElmBook
import ElmBook.ThemeOptions
import Template.AddYourOwn
import Template.Enum
import Template.Record
import Template.Union


main : ElmBook.Book msg
main =
    ElmBook.book "Elm-Pen"
        |> ElmBook.withThemeOptions
            [ ElmBook.ThemeOptions.useHashBasedNavigation
            , ElmBook.ThemeOptions.subtitle "Generate your own Elm modules"
            ]
        |> ElmBook.withChapterGroups
            [ ( "CLI", [ Cli.Introduction.chapter ] )
            , ( "Templates"
              , [ Template.Enum.chapter
                , Template.Record.chapter
                , Template.Union.chapter
                , Template.AddYourOwn.chapter
                ]
              )
            ]
