module Template.Enum exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Enum"
        |> ElmBook.Chapter.render """

The Enum template creates a new type containing the Constructurs specified in `sorts`.
Additionally, it add utillity functions like converters from and to Int and String.

If `withJsonConverters` is set to true, it will generate JSON converters.
You will have to add the `core/json` dependency to your elm.json file.

## JSON Structure

The Enum templates needs the following json structure:

``` 
{
    "sorts": List String,
    "withJsonConverters": Maybe Bool
}
```

Requirements

* The `sorts` fields must be a non empty list of 0-argument constructors. No spaces allowed!
* The `withJsonConverters` field is optional and will default to false.

Example:

``` json
{
    "sorts": ["Up", "Right", "Down", "Left"],
    "withJsonConverters": true
}
```
"""
