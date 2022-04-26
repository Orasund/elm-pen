module Gen.Enum.Vegetable exposing (..)

{-| This module contains the Enum Vegetable.

    type Vegetable
        = Potato
        | Carrot
        | Tomato
        | Onion
        | Cucumber
        | Broccoli


# Basics

@docs Vegetable, asList


# Converters

@docs toInt, fromInt, toString, fromString


-}

import Array exposing (Array)

-- This is a generated file. DO NOT CHANGE ANYTHING IN HERE.

-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------

{-| Vegetable type. -}
type Vegetable
   = Potato
   | Carrot
   | Tomato
   | Onion
   | Cucumber
   | Broccoli

{-| Lists all possible values of Vegetable

    asList : List Vegetable
    asList =
        [ Potato
        , Carrot
        , Tomato
        , Onion
        , Cucumber
        , Broccoli
        ]

-}
asList : List Vegetable
asList =
    [ Potato
    , Carrot
    , Tomato
    , Onion
    , Cucumber
    , Broccoli
    ]

-------------------------------------------------------------------------------
-- CONVERTERS
-------------------------------------------------------------------------------

{-| Convert `Vegetable` into `Int`.

    toInt : Vegetable -> Int
    toInt arg =
        case arg of
            Potato -> 0
            Carrot -> 1
            Tomato -> 2
            Onion -> 3
            Cucumber -> 4
            Broccoli -> 5

If you need to convert all values of Vegetable into ints, use `asList` instead.

    asList |> List.indexedMap (\i _ -> i)
        --> asList |> List.map toInt
-}
toInt : Vegetable -> Int
toInt arg =
    case arg of
        Potato -> 0
        Carrot -> 1
        Tomato -> 2
        Onion -> 3
        Cucumber -> 4
        Broccoli -> 5

{-| Convert `Int` into `Vegetable`

Returns `Nothing` if the values is out of bounds.

    fromInt : Int -> Maybe Vegetable
    fromInt int =
        case int of
            0 -> Just Potato 
            1 -> Just Carrot 
            2 -> Just Tomato 
            3 -> Just Onion 
            4 -> Just Cucumber 
            5 -> Just Broccoli 
            _ -> Nothing

-}
fromInt : Int -> Maybe Vegetable
fromInt int =
    case int of
        0 -> Just Potato 
        1 -> Just Carrot 
        2 -> Just Tomato 
        3 -> Just Onion 
        4 -> Just Cucumber 
        5 -> Just Broccoli 
        _ -> Nothing
    
{-| Convert Vegetable into String

    toString : Vegetable -> String
    toString arg =
        case arg of
            Potato -> "Potato"
            Carrot -> "Carrot"
            Tomato -> "Tomato"
            Onion -> "Onion"
            Cucumber -> "Cucumber"
            Broccoli -> "Broccoli"

-}
toString : Vegetable -> String
toString arg =
    case arg of
        Potato -> "Potato"
        Carrot -> "Carrot"
        Tomato -> "Tomato"
        Onion -> "Onion"
        Cucumber -> "Cucumber"
        Broccoli -> "Broccoli"

{-| Convert a String into a Vegetable

Returns Nothing if the string is not valid.

    fromString : String -> Maybe Vegetable
    fromString arg =
        case arg of
            "Potato" -> Just Potato 
            "Carrot" -> Just Carrot 
            "Tomato" -> Just Tomato 
            "Onion" -> Just Onion 
            "Cucumber" -> Just Cucumber 
            "Broccoli" -> Just Broccoli 
            _ -> Nothing
-}
fromString : String -> Maybe Vegetable
fromString arg =
    case arg of
        "Potato" -> Just Potato 
        "Carrot" -> Just Carrot 
        "Tomato" -> Just Tomato 
        "Onion" -> Just Onion 
        "Cucumber" -> Just Cucumber 
        "Broccoli" -> Just Broccoli 
        _ -> Nothing

