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

## Installation

1. Get the [js file](https://github.com/Orasund/elm-gen/blob/master/src/cli/ElmGen.bs.js) from the repository and put it into your project.
2. Get the [templates](https://github.com/Orasund/elm-gen/tree/master/elm-gen/templates) and put them into `elm-gen/templates` inside your project.
3. Get the [config file](https://github.com/Orasund/elm-gen/blob/master/elm-gen.json) and also put it into your project.
4. Run `node ElmGen.bs.js` and check if the files have been generated inside `elm-gen/generated`.
5. Now you are ready to go. You can modify the config file, add new templates or checkout the js file if you really want to get your hands dirty.

"""
