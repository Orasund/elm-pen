module Template.Record exposing (..)

import ElmBook.Chapter


chapter : ElmBook.Chapter.Chapter msg
chapter =
    ElmBook.Chapter.chapter "Record"
        |> ElmBook.Chapter.render """

The Record template creates a new record alias with getters, setters and mappers for all fields.

If `withJsonDecoder` or `withJsonEncoder` is set to true, it will generate JSON decoders and encoders respectively.

## JSON Structure

The Record templates needs the following json schema:

``` 
{
    "type": "object",
    "properties": {
      "imports": { "type": "array", "items": { "type": "string" } },
      "fields": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": { "type": "string" },
            "type": { "type": "string" },
            "jsonDecoder": { "type": "string" },
            "jsonEncoder": { "type": "string" }
          },
          "required": ["name", "type"]
        },
        "minItems": 1
      },
      "withJsonDecoder": { "type": "boolean" },
      "withJsonEncoder": { "type": "boolean" }
    },
    "required": ["fields"]
}
```

* The optional `imports` field contains normal imports.
* The `fields` field is a list of the fields with
  * The `name` of the field.
  * The `type` of the field. Type variables are NOT supported!
  * The `jsonDecoder` of the type.
    If `withJsonDecoder` is true, then all fields need a json decoder
  * The `jsonEncoder` of the type.
    If `withJsonEncoder` is true, then all fields need a json encoder
* The optional `withJsonDecoder` field states if the decoder should be generated as well.
* The optional `withJsonEncoder` field states if the encoder should be generated as well.

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
