module Cli.Introduction exposing (chapter)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Introduction"
        |> ElmBook.Chapter.render """

Elm-pen is a small CLI tool that lets you generate elm-files using [Handlebars.js](https://handlebarsjs.com/guide/).

It comes with a few templates out of the box (see the Templates section).

You can also add your own templates or change the existing ones if you want.

**This project is still in an alpha phase.**
If you encounter bugs or have issues setting it up, then you will have to fix it yourself.
I kindly ask you to also add an [issue on GitHub](https://github.com/Orasund/elm-pen/issues/new), so that i know what went wrong.

## Installation

```npm install -g elm-pen```

## Generating Files

Use the following command to start generating files.

```elm-pen```

On the first run, it will generate a `elm-pen.json` file as well as some example files.

## Configuration

Change the fields in `elm-pen.json` to your liking.

* `generateInto` - The folder in which the generated files should live
* `templatesFrom` - The folder in which the templates are living
* `moduleBase` - Base module name. May contain `.`
* `pathToElmFormat` - optional. Path to Elm-format (if present). May be null to deactivate calling elm-format.
* `modules` - The modules that should be generated. The module names may contain multiple templates.
  E.g. the module name "Model" may have the templates "Record" and "Writer".
"""
