module Gen.Record.Model exposing (..)

import {.}
import {.}

type alias Model =
    { seed : Seed
   , time : Posix
   , todos : List String
    }

-------------------------------------------------------------------------------
-- GET
-------------------------------------------------------------------------------

getSeed : Model -> Seed
getSeed =
    .seed

getTime : Model -> Posix
getTime =
    .time

getTodos : Model -> List String
getTodos =
    .todos


-------------------------------------------------------------------------------
-- SET
-------------------------------------------------------------------------------



setSeed : Seed -> Model -> Model
setSeed seed model =
    { model | seed = seed }

setTime : Posix -> Model -> Model
setTime time model =
    { model | time = time }

setTodos : List String -> Model -> Model
setTodos todos model =
    { model | todos = todos }


-------------------------------------------------------------------------------
-- MAP
-------------------------------------------------------------------------------

mapSeed : (Seed -> Seed) -> Model -> Model
mapSeed fun model =
    { model | seed = fun model.seed }

mapTime : (Posix -> Posix) -> Model -> Model
mapTime fun model =
    { model | time = fun model.time }

mapTodos : (List String -> List String) -> Model -> Model
mapTodos fun model =
    { model | todos = fun model.todos }


-------------------------------------------------------------------------------
-- GET AND THEN
-------------------------------------------------------------------------------

getSeedAndThen : (Seed -> Model -> Model) -> Model -> Model
getSeedAndThen fun model =
    model |> fun model.seed
getTimeAndThen : (Posix -> Model -> Model) -> Model -> Model
getTimeAndThen fun model =
    model |> fun model.time
getTodosAndThen : (List String -> Model -> Model) -> Model -> Model
getTodosAndThen fun model =
    model |> fun model.todos
