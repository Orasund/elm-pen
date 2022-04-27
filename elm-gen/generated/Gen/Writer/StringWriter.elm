module Gen.Writer.StringWriter exposing (..)

{-| This module contains the StringWriter Writer.

    type alias StringWriter state  =
        ( state, String  )

This module implements the writer monad.

That's just a fancy way of saying that it using `state` for computation and stores the result in `String`.

# Basics

@docs StringWriter, start, andThen, stop

# Pause and Continue

@docs pause, continue

# Modifications

@docs map, mapOutput

-}



-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------

{-| StringWriter type -}
type alias StringWriter state  =
    ( state, String  )

{-| Start the writing process.

    start : state -> StringWriter state 
    start a =
        ( a, "")

Use `andThen` for computation steps.
Use `stop` to end the process and get the output.

If you already have a String that you want to continue on, use `continue` instead.

-}
start : state -> StringWriter state 
start a =
    ( a, "")

{-| Apply a computation to the writer.

    andThen : (state1 -> StringWriter state2 ) -> StringWriter state1  -> StringWriter state2 
    andThen fun ( a, out ) =
        let
            ( newA, newOut ) =
                fun a
        in
        ( newA
        , out |> (\c1 c2 -> c2 ++ c1) newOut
        )

Note that StringWriter is just a tuple, where the output is stored in the second argument.

-}
andThen : (state1 -> StringWriter state2 ) -> StringWriter state1  -> StringWriter state2 
andThen fun ( a, out ) =
    let
        ( newA, newOut ) =
            fun a
    in
    ( newA
    , out |> (\c1 c2 -> c2 ++ c1) newOut
    )

{-| Stop the writer, turn the current state into String and return the output.

    stop : ( state -> String  ) -> StringWriter state  -> String 
    stop fun ( a, out) =
        out |> (\c1 c2 -> c2 ++ c1) (fun a)

If you want to ignore the current state and just get the current output, use `pause` instead.
-}
stop : ( state -> String  ) -> StringWriter state  -> String 
stop fun ( a, out) =
    out |> (\c1 c2 -> c2 ++ c1) (fun a)

-------------------------------------------------------------------------------
-- PAUSE AND CONTINUE
-------------------------------------------------------------------------------

{-| Get the current output.

    pause : StringWriter state  -> String 
    pause =
        Tuple.second

-}
pause : StringWriter state  -> String 
pause =
    Tuple.second

{-| Continue the computation with a String.

    continue : String  -> state -> StringWriter state 
    continue out a =
        ( a, out )

If you have already a StringWriter that you want to continue using, use `mapOutput` instead.

-}
continue : String  -> state -> StringWriter state 
continue out a =
    ( a, out )

-------------------------------------------------------------------------------
-- MODIFICATIONS
-------------------------------------------------------------------------------

{-| Map the state of a StringWriter.

    map : ( state1 -> state2 ) -> StringWriter state1  -> StringWriter state2 
    map fun =
        Tuple.mapFirst fun

-}
map : ( state1 -> state2 ) -> StringWriter state1  -> StringWriter state2 
map fun =
    Tuple.mapFirst fun

{-| Map the output of a StringWriter

    mapOutput : ( String  -> String  ) -> StringWriter state  -> StringWriter state 
    mapOutput fun =
        Tuple.mapSecond fun

-}
mapOutput : ( String  -> String  ) -> StringWriter state  -> StringWriter state 
mapOutput fun =
    Tuple.mapSecond fun



