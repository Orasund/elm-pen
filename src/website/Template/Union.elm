module Template.Union exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Union"
        |> ElmBook.Chapter.render """

The Union template creates a type with at most one argument per constructor.


## JSON Structure

The Writer templates needs the following json structure:

``` 
{
    "imports": Maybe (List String),
    "variants": {
        "name": String,
        "type": Maybe String,
        "polymorphic": Maybe Bool,
    }
}
```

Requirements

* The optional `imports` field contains normal imports.
* The `variants` field is a record that represents the output type:
  * The optional `type` as string
  * The optional `polymorphic` flag specifies if the type has a type variable.
    Only one type variable is allowed and also the variable need to be behind the type name, so something like `Result a String` is not allowed.

Example:

``` json
{
    "variants": [
          { "name": "Waiting" },
          { "name": "Result", "type": "Result String", "polymorphic": true },
          { "name": "Failure", "type": "String" },
          { "name": "Success", "polymorphic": true }
        ]
}
```
"""
