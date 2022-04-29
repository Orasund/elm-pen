module Gen.Writer.CmdWriter exposing (..)

{-| This module contains the CmdWriter Writer.

    type alias CmdWriter state out =
        ( state, Cmd out )

This module implements the writer monad.

That's just a fancy way of saying that it using `state` for computation and stores the result in `Cmd`.


# Basics

@docs CmdWriter, start, andThen, stop


# Pause and Continue

@docs pause, continue


# Modifications

@docs map, mapOutput

-}

-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------


{-| CmdWriter type
-}
type alias CmdWriter state =
    ( state, Cmd out )


{-| Start the writing process.

    start : state -> CmdWriter state out
    start a =
        ( a, Cmd.none )

Use `andThen` for computation steps.
Use `stop` to end the process and get the output.

If you already have a Cmd that you want to continue on, use `continue` instead.

-}
start : state -> CmdWriter state out
start a =
    ( a, Cmd.none )


{-| Apply a computation to the writer.

    andThen : (state1 -> CmdWriter state2 out) -> CmdWriter state1 out -> CmdWriter state2 out
    andThen fun ( a, out ) =
        let
            ( newA, newOut ) =
                fun a
        in
        ( newA
        , out |> (\c1 c2 -> Cmd.batch [ c1, c2 ]) newOut
        )

Note that CmdWriter is just a tuple, where the output is stored in the second argument.

-}
andThen : (state1 -> CmdWriter state2 out) -> CmdWriter state1 out -> CmdWriter state2 out
andThen fun ( a, out ) =
    let
        ( newA, newOut ) =
            fun a
    in
    ( newA
    , out |> (\c1 c2 -> Cmd.batch [ c1, c2 ]) newOut
    )


{-| Stop the writer, turn the current state into Cmd and return the output.

    stop : (state -> Cmd out) -> CmdWriter state out -> Cmd out
    stop fun ( a, out ) =
        out |> (\c1 c2 -> Cmd.batch [ c1, c2 ]) (fun a)

If you want to ignore the current state and just get the current output, use `pause` instead.

-}
stop : (state -> Cmd out) -> CmdWriter state out -> Cmd out
stop fun ( a, out ) =
    out |> (\c1 c2 -> Cmd.batch [ c1, c2 ]) (fun a)



-------------------------------------------------------------------------------
-- PAUSE AND CONTINUE
-------------------------------------------------------------------------------


{-| Get the current output.

    pause : CmdWriter state out -> Cmd out
    pause =
        Tuple.second

-}
pause : CmdWriter state out -> Cmd out
pause =
    Tuple.second


{-| Continue the computation with a Cmd.

    continue : Cmd out -> state -> CmdWriter state out
    continue out a =
        ( a, out )

If you have already a CmdWriter that you want to continue using, use `mapOutput` instead.

-}
continue : Cmd out -> state -> CmdWriter state out
continue out a =
    ( a, out )



-------------------------------------------------------------------------------
-- MODIFICATIONS
-------------------------------------------------------------------------------


{-| Map the state of a CmdWriter.

    map : (state1 -> state2) -> CmdWriter state1 out -> CmdWriter state2 out
    map fun =
        Tuple.mapFirst fun

-}
map : (state1 -> state2) -> CmdWriter state1 out -> CmdWriter state2 out
map fun =
    Tuple.mapFirst fun


{-| Map the output of a CmdWriter

    mapOutput : (Cmd out1 -> Cmd out2) -> CmdWriter state out1 -> CmdWriter state out2
    mapOutput fun =
        Tuple.mapSecond fun

-}
mapOutput : (Cmd out1 -> Cmd out2) -> CmdWriter state out1 -> CmdWriter state out2
mapOutput fun =
    Tuple.mapSecond fun
