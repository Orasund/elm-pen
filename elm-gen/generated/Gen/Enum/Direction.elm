module Gen.Enum.Direction exposing (..)

{-| This module contains the Enum Direction.

    type Direction
        = Up
        | Right
        | Down
        | Left


# Basics

@docs Direction, asList


# Converters

@docs toInt, fromInt, toString, fromString

# Json Serialization

@docs encode, decoder, decoderWithError

-}

import Array exposing (Array)
import Json.Decode
import Json.Encode

-- This is a generated file. DO NOT CHANGE ANYTHING IN HERE.

-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------

{-| Direction type. -}
type Direction
   = Up
   | Right
   | Down
   | Left

{-| Lists all possible values of Direction

    asList : List Direction
    asList =
        [ Up
        , Right
        , Down
        , Left
        ]

-}
asList : List Direction
asList =
    [ Up
    , Right
    , Down
    , Left
    ]

-------------------------------------------------------------------------------
-- CONVERTERS
-------------------------------------------------------------------------------

{-| Convert `Direction` into `Int`.

    toInt : Direction -> Int
    toInt arg =
        case arg of
            Up -> 0
            Right -> 1
            Down -> 2
            Left -> 3

If you need to convert all values of Direction into ints, use `asList` instead.

    asList |> List.indexedMap (\i _ -> i)
        --> asList |> List.map toInt
-}
toInt : Direction -> Int
toInt direction =
    case direction of
        Up -> 0
        Right -> 1
        Down -> 2
        Left -> 3

{-| Convert `Int` into `Direction`

Returns `Nothing` if the values is out of bounds.

    fromInt : Int -> Maybe Direction
    fromInt int =
        case int of
            0 -> Just Up 
            1 -> Just Right 
            2 -> Just Down 
            3 -> Just Left 
            _ -> Nothing

-}
fromInt : Int -> Maybe Direction
fromInt int =
    case int of
        0 -> Just Up 
        1 -> Just Right 
        2 -> Just Down 
        3 -> Just Left 
        _ -> Nothing
    
{-| Convert Direction into String

    toString : Direction -> String
    toString arg =
        case arg of
            Up -> "Up"
            Right -> "Right"
            Down -> "Down"
            Left -> "Left"

-}
toString : Direction -> String
toString direction =
    case direction of
        Up -> "Up"
        Right -> "Right"
        Down -> "Down"
        Left -> "Left"

{-| Convert a String into a Direction

Returns Nothing if the string is not valid.

    fromString : String -> Maybe Direction
    fromString arg =
        case arg of
            "Up" -> Just Up 
            "Right" -> Just Right 
            "Down" -> Just Down 
            "Left" -> Just Left 
            _ -> Nothing
-}
fromString : String -> Maybe Direction
fromString string =
    case string of
        "Up" -> Just Up 
        "Right" -> Just Right 
        "Down" -> Just Down 
        "Left" -> Just Left 
        _ -> Nothing

-------------------------------------------------------------------------------
-- JSON SERIALIZATION
-------------------------------------------------------------------------------

{-| Encodes the Direction into a json value.

    encode : Direction -> Json.Encode.Value
    encode arg =
        arg
            |> toString
            |> Json.Encode.string

-}
encode : Direction -> Json.Encode.Value
encode direction =
    direction
        |> toString
        |> Json.Encode.string

{-| Decoder for decoding a json value into a Direction

    decoder : Json.Decode.Decoder Direction
    decoder =
        "Direction expected. Valid values are \"Up\", \"Right\", \"Down\" and \"Left\""
            |> decoderWithError 

-}
decoder : Json.Decode.Decoder Direction
decoder =
    "Direction expected. Valid values are \"Up\", \"Right\", \"Down\" and \"Left\""
        |> decoderWithError 

{-| Decodes a json value into a Direction. 

Takes an error message as an argument.

-}
decoderWithError : String -> Json.Decode.Decoder Direction
decoderWithError errorMessage =
    Json.Decode.string
        |> Json.Decode.andThen (\string -> 
            case fromString string of
                Just direction ->
                    Json.Decode.succeed direction
                Nothing ->
                    Json.Decode.fail errorMessage
                |> Maybe.withDefault default
        )
