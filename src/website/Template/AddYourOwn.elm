module Template.AddYourOwn exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Add Your Own"
        |> ElmBook.Chapter.render """

To create your own template, add this minimal template to your templates folder (default is `elm-pen/templates`).

```
module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{-| This module contains the {{moduleName}} {{template}}.
-}

-- Generated with [Elm-pen](https://orasund.github.io/elm-pen) Version {{version}}
```

To test your new template, add an entry to the `elm-pen.json` file.

```
{ ..
, "Test" { "YourTemplate" : {} }
}
```

You can now extend the template and add any needed variables into the `elm-pen.json` file.

Note that we are using [handlebars.js](https://handlebarsjs.com/guide/) as template language.

Additionally, elm-pen comes with a few custom helpers out of the box.

* **capitalize** will make the first letter of the string into an uppercase.
* **decapitalize** will make the first letter of the string into a lowercase.
* **eq** takes two integers and returns if they are equal. Should be used with @index.
* **and** takes two values and return if they both are "not empty". Essentially the same as combining two if statements.
* **or** same as for `and` but returns if either is not empty.
"""
