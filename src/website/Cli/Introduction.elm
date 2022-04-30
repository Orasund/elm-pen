module Cli.Introduction exposing (chapter)

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

1. Clone this project
2. Run `mpn run build`
3. Run `mpn link`
4. Go into your project
5. Get the [templates](https://github.com/Orasund/elm-gen/tree/master/elm-gen/templates) and put them into `elm-gen/templates` inside your project.
6. Get the [config file](https://github.com/Orasund/elm-gen/blob/master/elm-gen.json) and also put it into your project.
7. Run `elm-gen`
8. (optional) add `elm-gen/generated` to your `.gitignore`.

Now you are ready to go. You can modify the config file, add new templates or checkout the js file if you really want to get your hands dirty.

## Configuration

Inside the `elm-gen.json` file are a few fields that can be configured

* `generateInto` - The folder in which the generated files should live
* `templatesFrom` - The folder in which the templates are living
* `moduleBase` - Base module name. May contain `.`
* `pathToElmFormat` - optional. Path to Elm-format (if present). May be null to deactivate calling elm-format.
* `modules` - The modules that should be generated. The module names may contain multiple templates.
  E.g. the module name "Model" may have the templates "Record" and "Writer".
"""