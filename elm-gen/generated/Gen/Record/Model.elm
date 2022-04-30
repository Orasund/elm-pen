module Gen.Record.Model exposing (..)

{-| This module contains the Model Record.

    type alias Model =
        { weekday : Weekday
        , todos : Array String
        }


# Type

@docs Model


# Getter

@docs getWeekday, getTodos


# Setter

@docs setWeekday, setTodos


# Mapper

@docs mapWeekday, mapTodos


# Serialization

@docs encoder
@docs decoder

-}

import Array exposing (Array)
import Gen.Enum.Weekday as Weekday exposing (Weekday)
import Json.Decode as D
import Json.Encode as E



-- This is a generated file. DO NOT CHANGE ANYTHING IN HERE.
-------------------------------------------------------------------------------
-- TYPE
-------------------------------------------------------------------------------


{-| Model record
-}
type alias Model =
    { weekday : Weekday
    , todos : Array String
    }



-------------------------------------------------------------------------------
-- GETTER
-------------------------------------------------------------------------------


{-| Get the value of the weekday field.

    getWeekday : Model -> Weekday
    getWeekday =
        .weekday

-}
getWeekday : Model -> Weekday
getWeekday =
    .weekday


{-| Get the value of the todos field.

    getTodos : Model -> Array String
    getTodos =
        .todos

-}
getTodos : Model -> Array String
getTodos =
    .todos



-------------------------------------------------------------------------------
-- SETTER
-------------------------------------------------------------------------------


{-| Set the value of the weekday field.

    setWeekday : Weekday -> Model -> Model
    setWeekday weekday model =
        { model | weekday = weekday }

-}
setWeekday : Weekday -> Model -> Model
setWeekday weekday model =
    { model | weekday = weekday }


{-| Set the value of the todos field.

    setTodos : Array String -> Model -> Model
    setTodos todos model =
        { model | todos = todos }

-}
setTodos : Array String -> Model -> Model
setTodos todos model =
    { model | todos = todos }



-------------------------------------------------------------------------------
-- MAPPER
-------------------------------------------------------------------------------


{-| Map the value of the weekday field.

    mapWeekday : (Weekday -> Weekday) -> Model -> Model
    mapWeekday fun model =
        { model | weekday = fun model.weekday }

-}
mapWeekday : (Weekday -> Weekday) -> Model -> Model
mapWeekday fun model =
    { model | weekday = fun model.weekday }


{-| Map the value of the todos field.

    mapTodos : (Array String -> Array String) -> Model -> Model
    mapTodos fun model =
        { model | todos = fun model.todos }

-}
mapTodos : (Array String -> Array String) -> Model -> Model
mapTodos fun model =
    { model | todos = fun model.todos }



-------------------------------------------------------------------------------
-- SERIALIZATION
-------------------------------------------------------------------------------


{-| Json encoder for Model
-}
encoder : Model -> E.Value
encoder model =
    E.object
        [ ( "weekday", Weekday.encoder model.weekday )
        , ( "todos", E.array E.string model.todos )
        ]


{-| Json decoder for Model
-}
decoder : D.Decoder Model
decoder =
    D.succeed
        (\weekday todos ->
            { weekday = weekday
            , todos = todos
            }
        )
        |> D.andThen (\fun -> D.map fun Weekday.decoder)
        |> D.andThen (\fun -> D.map fun (D.array D.string))
