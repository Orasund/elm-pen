module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{{#imports}}{{.}}{{/imports}}

type alias {{moduleName}} a =
    ( a, {{output.type}} )

start : {{output.type}} -> a -> {{moduleName}} a
start out a =
    ( a, out )

andThen : (a -> {{moduleName}} b) -> {{moduleName}} a -> {{moduleName}} b
andThen fun ( a, out ) =
    let
        ( newA, newOut ) =
            fun a
    in
    ( newA
    , out |> {{output.append}} newOut
    )

map : ( a -> b ) -> {{moduleName}} a -> {{moduleName}} b
map fun =
    Tuple.mapFirst fun

mapOutput : ( {{output.type}} -> {{output.type}} ) -> {{moduleName}} a -> {{moduleName}} a
mapOutput fun =
    Tuple.mapSecond fun

end : ( a -> {{output.type}} ) -> {{moduleName}} a -> {{output.type}}
end fun ( a, out) =
    out |> {{output.append}} (fun a)