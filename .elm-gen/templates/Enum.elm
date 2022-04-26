module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{-| This is a generated file. DO NOT CHANGE ANYTHING.


# Basics

@docs {{moduleName}}, asList{{#sorts}}, {{decapitalize .}}{{/sorts}}


# Converters

@docs toInt, fromInt, toString, fromString

-}

-------------------------------------------------------------------------------
-- BASICS
-------------------------------------------------------------------------------

type {{moduleName}}
{{#sorts}}
{{#if @first}}   = {{.}}
{{else}}   | {{.}}
{{/if}}
{{/sorts}}

asList : List {{moduleName}}
asList =
{{#sorts}}{{#if @first}}    [ {{.}}{{else}}
    , {{.}}{{/if}}{{/sorts}}
    ]

{{#sorts}}
{{decapitalize .}} : {{../moduleName}}
{{decapitalize .}} =
    {{.}}

{{/sorts}}

-------------------------------------------------------------------------------
-- CONVERTERS
-------------------------------------------------------------------------------

toInt : {{moduleName}} -> Int
toInt arg =
    case arg of
{{#sorts}}
        {{.}} -> {{@index}}
{{/sorts}}

fromInt : Int -> Maybe {{moduleName}}
fromInt int =
    case int of
{{#sorts}}
        {{@index}} -> Just {{.}} 
{{/sorts}}
        _ -> Nothing
    
toString : {{moduleName}} -> String
toString arg =
    case arg of
{{#sorts}}
        {{.}} -> "{{.}}"
{{/sorts}}

fromString : String -> Maybe {{moduleName}}
fromString arg =
    case arg of
{{#sorts}}
        "{{.}}" -> Just {{.}} 
{{/sorts}}
        _ -> Nothing