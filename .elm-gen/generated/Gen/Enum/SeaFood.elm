module Gen.Enum.SeaFood exposing (..)

{-| This is a generated file. DO NOT CHANGE ANYTHING.


# Basics

@docs SeaFood, asList, fish, octopus, lobster


# Converters

@docs toInt, fromInt, toString, fromString

-}

-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------

type SeaFood
   = Fish
   | Octopus
   | Lobster

asList : List SeaFood
asList =
    [ Fish
    , Octopus
    , Lobster
    ]

fish : SeaFood
fish =
    Fish

octopus : SeaFood
octopus =
    Octopus

lobster : SeaFood
lobster =
    Lobster


-------------------------------------------------------------------------------
-- CONVERTERS
-------------------------------------------------------------------------------

toInt : SeaFood -> Int
toInt arg =
    case arg of
        Fish -> 0
        Octopus -> 1
        Lobster -> 2

fromInt : Int -> Maybe SeaFood
fromInt int =
    case int of
        0 -> Just Fish 
        1 -> Just Octopus 
        2 -> Just Lobster 
        _ -> Nothing
    
toString : SeaFood -> String
toString arg =
    case arg of
        Fish -> "Fish"
        Octopus -> "Octopus"
        Lobster -> "Lobster"

fromString : String -> Maybe SeaFood
fromString arg =
    case arg of
        "Fish" -> Just Fish 
        "Octopus" -> Just Octopus 
        "Lobster" -> Just Lobster 
        _ -> Nothing