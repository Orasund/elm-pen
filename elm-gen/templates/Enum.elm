module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{-| This module contains the {{moduleName}} {{template}}.

    type {{moduleName}}
{{#sorts}}
{{#if @first}}        = {{.}}
{{else}}        | {{.}}
{{/if}}
{{/sorts}}


# Basics

@docs {{moduleName}}, asList


# Converters

@docs toInt, fromInt, toString, fromString

{{#if withJsonConverters}}
# Json Serialization

@docs encode, decoder, decoderWithError
{{/if}}

-}

import Array exposing (Array)
{{#if withJsonConverters}}
import Json.Decode
import Json.Encode
{{/if}}

-- This is a generated file. DO NOT CHANGE ANYTHING IN HERE.

-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------

{-| {{moduleName}} type. -}
type {{moduleName}}
{{#sorts}}
{{#if @first}}   = {{.}}
{{else}}   | {{.}}
{{/if}}
{{/sorts}}

{-| Lists all possible values of {{moduleName}}

    asList : List {{moduleName}}
    asList =
{{#sorts}}{{#if @first}}        [ {{.}}{{else}}
        , {{.}}{{/if}}{{/sorts}}
        ]

-}
asList : List {{moduleName}}
asList =
{{#sorts}}{{#if @first}}    [ {{.}}{{else}}
    , {{.}}{{/if}}{{/sorts}}
    ]

-------------------------------------------------------------------------------
-- CONVERTERS
-------------------------------------------------------------------------------

{-| Convert `{{moduleName}}` into `Int`.

    toInt : {{moduleName}} -> Int
    toInt arg =
        case arg of
{{#sorts}}
            {{.}} -> {{@index}}
{{/sorts}}

If you need to convert all values of {{moduleName}} into ints, use `asList` instead.

    asList |> List.indexedMap (\i _ -> i)
        --> asList |> List.map toInt
-}
toInt : {{moduleName}} -> Int
toInt {{decapitalize moduleName}} =
    case {{decapitalize moduleName}} of
{{#sorts}}
        {{.}} -> {{@index}}
{{/sorts}}

{-| Convert `Int` into `{{moduleName}}`

Returns `Nothing` if the values is out of bounds.

    fromInt : Int -> Maybe {{moduleName}}
    fromInt int =
        case int of
    {{#sorts}}
            {{@index}} -> Just {{.}} 
    {{/sorts}}
            _ -> Nothing

-}
fromInt : Int -> Maybe {{moduleName}}
fromInt int =
    case int of
{{#sorts}}
        {{@index}} -> Just {{.}} 
{{/sorts}}
        _ -> Nothing
    
{-| Convert {{moduleName}} into String

    toString : {{moduleName}} -> String
    toString arg =
        case arg of
{{#sorts}}
            {{.}} -> "{{.}}"
{{/sorts}}

-}
toString : {{moduleName}} -> String
toString {{decapitalize moduleName}} =
    case {{decapitalize moduleName}} of
{{#sorts}}
        {{.}} -> "{{.}}"
{{/sorts}}

{-| Convert a String into a {{moduleName}}

Returns Nothing if the string is not valid.

    fromString : String -> Maybe {{moduleName}}
    fromString arg =
        case arg of
{{#sorts}}
            "{{.}}" -> Just {{.}} 
{{/sorts}}
            _ -> Nothing
-}
fromString : String -> Maybe {{moduleName}}
fromString string =
    case string of
{{#sorts}}
        "{{.}}" -> Just {{.}} 
{{/sorts}}
        _ -> Nothing

{{#if withJsonConverters}}
-------------------------------------------------------------------------------
-- JSON SERIALIZATION
-------------------------------------------------------------------------------

{-| Encodes the {{moduleName}} into a json value.

    encode : {{moduleName}} -> Json.Encode.Value
    encode arg =
        arg
            |> toString
            |> Json.Encode.string

-}
encode : {{moduleName}} -> Json.Encode.Value
encode {{decapitalize moduleName}} =
    {{decapitalize moduleName}}
        |> toString
        |> Json.Encode.string

{-| Decoder for decoding a json value into a {{moduleName}}

    decoder : Json.Decode.Decoder {{moduleName}}
    decoder =
        "{{moduleName}} expected. Valid values are {{#sorts}}{{#if @first}}{{else}}{{#if @last}} and {{else}}, {{/if}}{{/if}}\"{{.}}\"{{/sorts}}"
            |> decoderWithError 

-}
decoder : Json.Decode.Decoder {{moduleName}}
decoder =
    "{{moduleName}} expected. Valid values are {{#sorts}}{{#if @first}}{{else}}{{#if @last}} and {{else}}, {{/if}}{{/if}}\"{{.}}\"{{/sorts}}"
        |> decoderWithError 

{-| Decodes a json value into a {{moduleName}}. 

Takes an error message as an argument.

-}
decoderWithError : String -> Json.Decode.Decoder {{moduleName}}
decoderWithError errorMessage =
    Json.Decode.string
        |> Json.Decode.andThen (\string -> 
            case fromString string of
                Just {{decapitalize moduleName}} ->
                    Json.Decode.succeed {{decapitalize moduleName}}
                Nothing ->
                    Json.Decode.fail errorMessage
        )
{{/if}}