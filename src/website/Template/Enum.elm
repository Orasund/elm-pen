module Template.Enum exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Enum"
        |> ElmBook.Chapter.render """

The Enum template creates a new type containing the constructors specified in `variants`.
Additionally, it adds utility functions like converters from and to Int and String.

If `withJsonConverters` is set to true, it will generate JSON converters.
You will have to add the `core/json` dependency to your elm.json file.

## JSON Structure

The Enum templates needs the following json schema:

``` 
{
    "type": "object",
    "properties": {
      "variants": {
        "type": "array",
        "items": { "type": "string" },
        "minItems": 1
      },
      "isCyclic": { "type": "boolean" },
      "withJsonConverters": { "type": "boolean" }
    },
    "required": ["variants"]
}
```

Requirements

* The `variants` fields must be a non empty list of 0-argument constructors. No spaces allowed!
* The optional `isCyclic` flag specifies if `next` and `prev` should wrap around.
* The optional `withJsonConverters` flag specifies if `elm/json` should be used to create json converters.

Example:

``` json
{
    "sorts": [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    ],
    "isCyclic": true,
    "withJsonConverters": true
}
```
"""
