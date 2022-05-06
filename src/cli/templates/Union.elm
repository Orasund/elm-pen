module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{-| This module contains the {{moduleName}} {{template}}.

@docs {{moduleName}}

## Is

@docs {{#sorts}}{{#if @first}}{{else}} ,{{/if}}is{{name}}{{/sorts}}

## If

@docs {{#sorts}}{{#if @first}}{{else}} ,{{/if}}{{#if (or polymorphic type)}}if{{name}}{{/if}}{{/sorts}}

## Map

@docs {{#sorts}}{{#if @first}}{{else}} ,{{/if}}{{#if (or polymorphic type)}}map{{name}}{{/if}}{{/sorts}}
-}

{-| {{moduleName}} type.
-}
type {{moduleName}}{{#sorts}}{{#if polymorphic}} a{{@index}}{{/if}}{{/sorts}}
{{#sorts}}
{{#if @first}}   = {{name}}{{else}}   | {{name}}{{/if}} {{#if (or polymorphic type)}}({{#if type}}{{type}}{{/if}} {{#if polymorphic}} a{{@index}}{{/if}}){{/if}}
{{/sorts}}

-------------------------------------------------------------------------------
-- IS
-------------------------------------------------------------------------------
{{#sorts}}
{-| Compute if the value is a {{name}}.

Useful if you don't want to do a full case distinction inside an if condition.

-}
is{{name}} : {{../moduleName}}{{#../sorts}}{{#if polymorphic}} a{{@index}}{{/if}}{{/../sorts}} -> Bool
is{{name}} {{decapitalize ../moduleName}} = 
    case {{decapitalize ../moduleName}} of
{{#../sorts}}
{{#if (or type polymorphic)}}
        {{name}} _ -> {{#if (eq @index @../index)}} True {{else}} False {{/if}}
{{else}}
        {{name}} -> {{#if (eq @index @../index)}} True {{else}} False {{/if}}
{{/if}}
{{/../sorts}}
{{/sorts}}

-------------------------------------------------------------------------------
-- IF
-------------------------------------------------------------------------------
{{#sorts}}
{{#if (or polymorphic type)}}
{-| Calls a function, if the value is a {{name}}.

You can turn the function into a getter by passing the identity as function

-}
if{{name}} : {{#if type}}{{#if polymorphic}}({{type}} {{#../sorts}}{{#if (and polymorphic (eq @index @../index))}} a{{@index}}{{/if}}{{/../sorts}} -> out){{else}}({{type}} -> out){{/if}}{{else if polymorphic}}({{#../sorts}}{{#if (and polymorphic (eq @index @../index))}} a{{@index}}{{/if}}{{/../sorts}} -> out){{/if}} -> {{../moduleName}}{{#../sorts}}{{#if polymorphic}} a{{@index}}{{/if}}{{/../sorts}} -> Maybe out
if{{name}} fun {{decapitalize ../moduleName}} =
    case {{decapitalize ../moduleName}} of
{{#../sorts}}
{{#if (eq @index @../index)}}
    {{name}} t -> Just (fun t)
{{else if (or type polymorphic)}}
    {{name}} a -> Nothing
{{else}}
    {{name}} -> Nothing
{{/if}}
{{/../sorts}}

{{/if}}
{{/sorts}}

-------------------------------------------------------------------------------
-- MAP
-------------------------------------------------------------------------------
{{#sorts}}
{{#if (or polymorphic type)}}
{-| Map the argument of {{name}}.
-}
map{{name}} : {{#if type}}{{#if polymorphic}}({{type}} {{#../sorts}}{{#if (and polymorphic (eq @index @../index))}} a{{@index}}{{/if}}{{/../sorts}} -> {{type}}{{#../sorts}}{{#if (and polymorphic (eq @index @../index))}} b{{@index}}{{/if}}{{/../sorts}}){{else}}({{type}} -> {{type}}){{/if}}{{else if polymorphic}}({{#../sorts}}{{#if (and polymorphic (eq @index @../index))}} a{{@index}}{{/if}}{{/../sorts}} -> {{#../sorts}}{{#if (and polymorphic (eq @index @../index))}} b{{@index}}{{/if}}{{/../sorts}}){{/if}} -> {{../moduleName}}{{#../sorts}}{{#if polymorphic}} a{{@index}}{{/if}}{{/../sorts}} -> {{../moduleName}}{{#../sorts}}{{#if polymorphic}}{{#if (eq @index @../index )}} b{{else}} a{{/if}}{{@index}}{{/if}}{{/../sorts}}
map{{name}} fun {{decapitalize ../moduleName}} =
    case {{decapitalize ../moduleName}} of
{{#../sorts}}
{{#if (eq @index @../index)}}
    {{name}} t -> {{name}} (fun t)
{{else if (or type polymorphic)}}
    {{name}} a -> {{name}} a
{{else}}
    {{name}} -> {{name}}
{{/if}}
{{/../sorts}}
{{/if}}

{{/sorts}}

-- Generated with [Elm-pen](https://orasund.github.io/elm-pen) Version {{version}}
