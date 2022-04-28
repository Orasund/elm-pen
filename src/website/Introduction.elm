module Introduction exposing (chapter)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Introduction"
        |> ElmBook.Chapter.render """

Elm-gen is a small CLI tool that lets you generate elm-files using [Handlebars.js](https://handlebarsjs.com/guide/).

It comes with a few templates out of the box (see Templates section),
but you can also add your own templates or change the existing ones if you want.

**This project is still in an alpha phase.**
If you encounter bugs or have issues setting it up, then you will have to fix it yourself.
I kindly ask you to also add an [issue on GitHub](https://github.com/Orasund/elm-gen/issues/new) and a pull request once you fixed it, so that i know what went wrong.

# Installation

1. Get the [js file from the repos]()


"""
