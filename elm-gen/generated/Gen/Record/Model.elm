module Gen.Record.Model exposing (..)

{-| This module contains the Model Record.

    type alias Model =
        { seed : Seed
        , time : Posix
        , todos : List String
        }

# Type

@docs Model

# Getter

@docs getSeed, getTime, getTodos

# Setter

@docs setSeed, setTime, setTodos

# Mapper

@docs mapSeed, mapTime, mapTodos

-}

import Random exposing (Seed)
import Time exposing (Posix)

{-| Model record -}
type alias Model =
    { seed : Seed
    , time : Posix
    , todos : List String
    }

-------------------------------------------------------------------------------
-- GETTER
-------------------------------------------------------------------------------

{-| Get the value of the seed field.

    getSeed : Model -> Seed
    getSeed =
        .seed
-}
getSeed : Model -> Seed
getSeed =
    .seed

{-| Get the value of the time field.

    getTime : Model -> Posix
    getTime =
        .time
-}
getTime : Model -> Posix
getTime =
    .time

{-| Get the value of the todos field.

    getTodos : Model -> List String
    getTodos =
        .todos
-}
getTodos : Model -> List String
getTodos =
    .todos


-------------------------------------------------------------------------------
-- SETTER
-------------------------------------------------------------------------------

{-| Set the value of the seed field.

    setSeed : Seed -> Model -> Model
    setSeed seed model =
        { model | seed = seed }

-}
setSeed : Seed -> Model -> Model
setSeed seed model =
    { model | seed = seed }

{-| Set the value of the time field.

    setTime : Posix -> Model -> Model
    setTime time model =
        { model | time = time }

-}
setTime : Posix -> Model -> Model
setTime time model =
    { model | time = time }

{-| Set the value of the todos field.

    setTodos : List String -> Model -> Model
    setTodos todos model =
        { model | todos = todos }

-}
setTodos : List String -> Model -> Model
setTodos todos model =
    { model | todos = todos }


-------------------------------------------------------------------------------
-- MAPPER
-------------------------------------------------------------------------------

{-| Map the value of the seed field.

    mapSeed : (Seed -> Seed) -> Model -> Model
    mapSeed fun model =
        { model | seed = fun model.seed }

-}
mapSeed : (Seed -> Seed) -> Model -> Model
mapSeed fun model =
    { model | seed = fun model.seed }

{-| Map the value of the time field.

    mapTime : (Posix -> Posix) -> Model -> Model
    mapTime fun model =
        { model | time = fun model.time }

-}
mapTime : (Posix -> Posix) -> Model -> Model
mapTime fun model =
    { model | time = fun model.time }

{-| Map the value of the todos field.

    mapTodos : (List String -> List String) -> Model -> Model
    mapTodos fun model =
        { model | todos = fun model.todos }

-}
mapTodos : (List String -> List String) -> Model -> Model
mapTodos fun model =
    { model | todos = fun model.todos }

