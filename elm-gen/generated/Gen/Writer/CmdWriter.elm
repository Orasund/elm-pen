module Gen.Writer.CmdWriter exposing (..)



type alias CmdWriter a =
    ( a, Cmd msg )

start : Cmd msg -> a -> CmdWriter a
start out a =
    ( a, out )

andThen : (a -> CmdWriter b) -> CmdWriter a -> CmdWriter b
andThen fun ( a, out ) =
    let
        ( newA, newOut ) =
            fun a
    in
    ( newA
    , out |> (\c1 c2 -> Cmd.batch [c1,c2]) newOut
    )

map : ( a -> b ) -> CmdWriter a -> CmdWriter b
map fun =
    Tuple.mapFirst fun

mapOutput : ( Cmd msg -> Cmd msg ) -> CmdWriter a -> CmdWriter a
mapOutput fun =
    Tuple.mapSecond fun

end : ( a -> Cmd msg ) -> CmdWriter a -> Cmd msg
end fun ( a, out) =
    out |> (\c1 c2 -> Cmd.batch [c1,c2]) (fun a)