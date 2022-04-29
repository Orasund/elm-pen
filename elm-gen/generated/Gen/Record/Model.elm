module Gen.Record.Model exposing (..)

{-| This module contains the Model Record.

    type alias Model =
        { direction : Direction
        , todos : Array String
        }


# Type

@docs Model


# Getter

@docs getDirection, getTodos


# Setter

@docs setDirection, setTodos


# Mapper

@docs mapDirection, mapTodos

# Serialization

@docs encoder
@docs decoder

-}

import Array exposing (Array)
import Gen.Enum.Direction as Direction exposing (Direction)
import Json.Encode as E
import Json.Decode as D

{-| Model record
-}
type alias Model =
    { direction : Direction
    , todos : Array String
    }



-------------------------------------------------------------------------------
-- GETTER
-------------------------------------------------------------------------------


{-| Get the value of the direction field.

    getDirection : Model -> Direction
    getDirection =
        .direction

-}
getDirection : Model -> Direction
getDirection =
    .direction


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


{-| Set the value of the direction field.

    setDirection : Direction -> Model -> Model
    setDirection direction model =
        { model | direction = direction }

-}
setDirection : Direction -> Model -> Model
setDirection direction model =
    { model | direction = direction }


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


{-| Map the value of the direction field.

    mapDirection : (Direction -> Direction) -> Model -> Model
    mapDirection fun model =
        { model | direction = fun model.direction }

-}
mapDirection : (Direction -> Direction) -> Model -> Model
mapDirection fun model =
    { model | direction = fun model.direction }


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

encoder :  Model -> E.Value
encoder model =
     E.object
        [ ("direction",(Direction.encoder) model.direction )
        , ("todos",(E.array E.string) model.todos )
        ]

decoder : D.Decoder Model
decoder =
    D.succeed
        (\ direction todos ->
            { direction = direction
            , todos = todos
            }
        )
            |> D.andThen (\fun ->  D.map fun (Direction.decoder) )
            |> D.andThen (\fun ->  D.map fun (D.array D.string) )
