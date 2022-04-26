module Gen.Enum.Vegetable exposing (..)

{-| This is a generated file. DO NOT CHANGE ANYTHING.


# Basics

@docs Vegetable, asList, potato, carrot, tomato, onion, cucumber, broccoli


# Converters

@docs toInt, fromInt, toString, fromString

-}

-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------

type Vegetable
   = Potato
   | Carrot
   | Tomato
   | Onion
   | Cucumber
   | Broccoli

asList : List Vegetable
asList =
    [ Potato
    , Carrot
    , Tomato
    , Onion
    , Cucumber
    , Broccoli
    ]

potato : Vegetable
potato =
    Potato

carrot : Vegetable
carrot =
    Carrot

tomato : Vegetable
tomato =
    Tomato

onion : Vegetable
onion =
    Onion

cucumber : Vegetable
cucumber =
    Cucumber

broccoli : Vegetable
broccoli =
    Broccoli


-------------------------------------------------------------------------------
-- CONVERTERS
-------------------------------------------------------------------------------

toInt : Vegetable -> Int
toInt arg =
    case arg of
        Potato -> 0
        Carrot -> 1
        Tomato -> 2
        Onion -> 3
        Cucumber -> 4
        Broccoli -> 5

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
    
toString : Vegetable -> String
toString arg =
    case arg of
        Potato -> "Potato"
        Carrot -> "Carrot"
        Tomato -> "Tomato"
        Onion -> "Onion"
        Cucumber -> "Cucumber"
        Broccoli -> "Broccoli"

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