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

We are using [handlebars.js](https://handlebarsjs.com/guide/) as template language.

Additionally, we included two special helper functions: `capitalize` and `decapitalize`

* **capitalize** will make the first letter of the string into an uppercase
* **decapitalize** will make the first letter of the string into a lowercase
"""
