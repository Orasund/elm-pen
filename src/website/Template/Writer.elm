module Template.Writer exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Writer"
        |> ElmBook.Chapter.render """

The Writer template creates the functions needed to write to a specific type.

## JSON Structure

The Writer templates needs the following json structure:

``` 
{
    "imports": List String,
    "output": {
        "type": String,
        "isPolymorphic": Maybe Bool,
        "empty": String,
        "append": String
    }
}
```

Requirements

* The `imports` field contains normal imports.
* The `output` field is a record that represents the output type:
  * The `type` as string
  * The optional `IsPolymorphic` flag specifies if the type has a type variable.
    Only one type variable is allowed and also the variable need to be behind the type name, so something like `Result a String` is not allowed.
  * The `empty` function specifies the default value.
  * The `append` function sepcifies how two values of this type can be combined.

Example:

``` json
{
    "imports": [],
    "output": {
        "type": "Cmd",
        "isPolymorphic": true,
        "empty": "Cmd.none",
        "append": "(\\c1 c2 -> Cmd.batch [c1,c2])"
    }
}
```
"""
