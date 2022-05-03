module Cli.Introduction exposing (chapter)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Introduction"
        |> ElmBook.Chapter.render """

Elm-pen is a small CLI tool that lets you generate elm-files using [Handlebars.js](https://handlebarsjs.com/guide/).

It comes with a few templates out of the box (see Templates section),
but you can also add your own templates or change the existing ones if you want.

**This project is still in an alpha phase.**
If you encounter bugs or have issues setting it up, then you will have to fix it yourself.
I kindly ask you to also add an [issue on GitHub](https://github.com/Orasund/elm-pen/issues/new) and a pull request once you fixed it, so that i know what went wrong.

## Installation

1. Clone this project
2. Run `npm run build`
3. Run `npm link`
4. Go into your project
5. Run `elm-pen`
6. (optional) add `elm-pen/generated` to your `.gitignore`.

Now you are ready to go. You can modify the config file, add new templates or checkout the js file if you really want to get your hands dirty.

## Configuration

The fields in the `elm-pen.json` file be configured.

* `generateInto` - The folder in which the generated files should live
* `templatesFrom` - The folder in which the templates are living
* `moduleBase` - Base module name. May contain `.`
* `pathToElmFormat` - optional. Path to Elm-format (if present). May be null to deactivate calling elm-format.
* `modules` - The modules that should be generated. The module names may contain multiple templates.
  E.g. the module name "Model" may have the templates "Record" and "Writer".
"""
