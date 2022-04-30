module Gen.Enum.Weekday exposing (..)

{-| This module contains the Weekday Enum.

    type Weekday
        = Monday
        | Tuesday
        | Wednesday
        | Thursday
        | Friday
        | Saturday
        | Sunday


# Basics

@docs Weekday, asList, next, prev


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


{-| Weekday type.
-}
type Weekday
    = Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
    | Sunday


{-| Lists all possible values of Weekday

    asList : List Weekday
    asList =
        [ Monday
        , Tuesday
        , Wednesday
        , Thursday
        , Friday
        , Saturday
        , Sunday
        ]

-}
asList : List Weekday
asList =
    [ Monday
    , Tuesday
    , Wednesday
    , Thursday
    , Friday
    , Saturday
    , Sunday
    ]


{-| Get the next Weekday.
-}
next : Weekday -> Weekday
next weekday =
    weekday
        |> toInt
        |> (+) 1
        |> fromInt
        |> Maybe.withDefault Monday


{-| Get the next Weekday.
-}
prev : Weekday -> Weekday
prev weekday =
    weekday
        |> toInt
        |> (+) -1
        |> fromInt
        |> Maybe.withDefault Sunday



-------------------------------------------------------------------------------
-- CONVERTERS
-------------------------------------------------------------------------------


{-| Convert `Weekday` into `Int`.

    toInt : Weekday -> Int
    toInt arg =
        case arg of
            Monday ->
                0

            Tuesday ->
                1

            Wednesday ->
                2

            Thursday ->
                3

            Friday ->
                4

            Saturday ->
                5

            Sunday ->
                6

If you need to convert all values of Weekday into ints, use `asList` instead.

    asList |> List.indexedMap (\i _ -> i)
        --> asList |> List.map toInt

-}
toInt : Weekday -> Int
toInt weekday =
    case weekday of
        Monday ->
            0

        Tuesday ->
            1

        Wednesday ->
            2

        Thursday ->
            3

        Friday ->
            4

        Saturday ->
            5

        Sunday ->
            6


{-| Convert `Int` into `Weekday`

Returns `Nothing` if the values is out of bounds.

    fromInt : Int -> Maybe Weekday
    fromInt int =
        case int of
            0 ->
                Just Monday

            1 ->
                Just Tuesday

            2 ->
                Just Wednesday

            3 ->
                Just Thursday

            4 ->
                Just Friday

            5 ->
                Just Saturday

            6 ->
                Just Sunday

            _ ->
                Nothing

-}
fromInt : Int -> Maybe Weekday
fromInt int =
    case int of
        0 ->
            Just Monday

        1 ->
            Just Tuesday

        2 ->
            Just Wednesday

        3 ->
            Just Thursday

        4 ->
            Just Friday

        5 ->
            Just Saturday

        6 ->
            Just Sunday

        _ ->
            Nothing


{-| Convert Weekday into String

    toString : Weekday -> String
    toString arg =
        case arg of
            Monday ->
                "Monday"

            Tuesday ->
                "Tuesday"

            Wednesday ->
                "Wednesday"

            Thursday ->
                "Thursday"

            Friday ->
                "Friday"

            Saturday ->
                "Saturday"

            Sunday ->
                "Sunday"

-}
toString : Weekday -> String
toString weekday =
    case weekday of
        Monday ->
            "Monday"

        Tuesday ->
            "Tuesday"

        Wednesday ->
            "Wednesday"

        Thursday ->
            "Thursday"

        Friday ->
            "Friday"

        Saturday ->
            "Saturday"

        Sunday ->
            "Sunday"


{-| Convert a String into a Weekday

Returns Nothing if the string is not valid.

    fromString : String -> Maybe Weekday
    fromString arg =
        case arg of
            "Monday" ->
                Just Monday

            "Tuesday" ->
                Just Tuesday

            "Wednesday" ->
                Just Wednesday

            "Thursday" ->
                Just Thursday

            "Friday" ->
                Just Friday

            "Saturday" ->
                Just Saturday

            "Sunday" ->
                Just Sunday

            _ ->
                Nothing

-}
fromString : String -> Maybe Weekday
fromString string =
    case string of
        "Monday" ->
            Just Monday

        "Tuesday" ->
            Just Tuesday

        "Wednesday" ->
            Just Wednesday

        "Thursday" ->
            Just Thursday

        "Friday" ->
            Just Friday

        "Saturday" ->
            Just Saturday

        "Sunday" ->
            Just Sunday

        _ ->
            Nothing



-------------------------------------------------------------------------------
-- JSON SERIALIZATION
-------------------------------------------------------------------------------


{-| Encodes the Weekday into a json value.

    encoder : Weekday -> Json.Encode.Value
    encoder arg =
        arg
            |> toString
            |> Json.Encode.string

-}
encoder : Weekday -> Json.Encode.Value
encoder weekday =
    weekday
        |> toString
        |> Json.Encode.string


{-| Decoder for decoding a json value into a Weekday

    decoder : Json.Decode.Decoder Weekday
    decoder =
        "Weekday expected. Valid values are \"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\" and \"Sunday\""
            |> decoderWithError

-}
decoder : Json.Decode.Decoder Weekday
decoder =
    "Weekday expected. Valid values are \"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\" and \"Sunday\""
        |> decoderWithError


{-| Decodes a json value into a Weekday.

Takes an error message as an argument.

-}
decoderWithError : String -> Json.Decode.Decoder Weekday
decoderWithError errorMessage =
    Json.Decode.string
        |> Json.Decode.andThen
            (\string ->
                case fromString string of
                    Just weekday ->
                        Json.Decode.succeed weekday

                    Nothing ->
                        Json.Decode.fail errorMessage
            )
