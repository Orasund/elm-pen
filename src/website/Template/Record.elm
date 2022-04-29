module Template.Record exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Record"
        |> ElmBook.Chapter.render """

The Record template creates a new record alias and getters, setters and mappers for all fields.

If `withJsonDecoder` or `withJsonEncoder` is set to true, it will generate JSON decoders and encoders respectively.
You will have to add the `core/json` dependency to your elm.json file.

## JSON Structure

The Record templates needs the following json structure:

``` 
{
    "imports": List String,
    "fields": 
        List 
            { "name" : String
            , "type": String 
            , "jsonDecoder" : Maybe String
            , "jsonEncoder" : Maybe String
            },
    "withJsonDecoder" : Maybe Bool,
    "withJsonDecoder" : Maybe Bool
}
```

* The `imports` field contains normal imports.
* The `fields` field is a list of the fields with
  * The `name` of the field.
  * The `type` of the field. Type variables are NOT supported!
  * Optional `jsonDecoder` of the type. 
    If `withJsonDecoder` is true, then all fields need a json decoder
  * Optional `jsonEncoder` of the type. 
    If `withJsonEncoder` is true, then all fields need a json encoder
* The `withJsonDecoder` field is optional and states if the decoder should be generated aswell. Defaults to false.
* The `withJsonEncoder` field is optional and states if the encoder should be generated aswell. Defaults to false.

Example:

``` json
{
    "imports": [
        "Array exposing (Array)",
        "Gen.Enum.Direction as Direction exposing (Direction)"
    ],
    "fields": [
        {
        "name": "direction",
        "type": "Direction",
        "jsonDecoder": "Direction.decoder",
        "jsonEncoder": "Direction.encoder"
        },
        {
        "name": "todos",
        "type": "Array String",
        "jsonDecoder": "D.array D.string",
        "jsonEncoder": "E.array E.string"
        }
    ],
    "withJsonDecoder": true,
    "withJsonEncoder": true
}
```
"""
