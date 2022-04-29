module Template.Record exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Record"
        |> ElmBook.Chapter.render """

The Record template creates a new record alias and getters, setters and mappers for all fields.

If `withJsonConverters` is set to true, it will generate JSON converters.
You will have to add the `core/json` dependency to your elm.json file.

## JSON Structure

The Enum templates needs the following json structure:

``` 
{
    "imports": List String,
    "fields": List { "name" : String, "type": String }
}
```

* the `imports` field contains normal imports.
* the `fields` field is a list of `name`s and `type`s. Type variables are NOT supported!

Example:

``` json
{
    "imports": [
        "Array exposing (Array)",
        "Gen.Enum.Direction exposing (Direction)"
    ],
    "fields": [
        { "name": "direction", "type": "Direction" },
        { "name": "todos", "type": "Array String" }
    ]
}
```
"""
