module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{-| This module contains the {{moduleName}} {{template}}.

    type alias {{moduleName}} =
{{#fields}}
{{#if @first}}        { {{name}} : {{type}}
{{else}}        , {{name}} : {{type}}
{{/if}}
{{/fields}}
        }


# Type

@docs {{moduleName}}


# Getter

@docs {{#fields}}{{#if @first}}{{else}}, {{/if}}get{{capitalize name}}{{/fields}}


# Setter

@docs {{#fields}}{{#if @first}}{{else}}, {{/if}}set{{capitalize name}}{{/fields}}


# Mapper

@docs {{#fields}}{{#if @first}}{{else}}, {{/if}}map{{capitalize name}}{{/fields}}

-}

{{#imports}}
import {{.}}
{{/imports}}


{-| {{moduleName}} record
-}
type alias {{moduleName}} =
{{#fields}}
{{#if @first}}    { {{name}} : {{type}}
{{else}}    , {{name}} : {{type}}
{{/if}}
{{/fields}}
    }



-------------------------------------------------------------------------------
-- GETTER
-------------------------------------------------------------------------------


{{#fields}}
{-| Get the value of the {{name}} field.

    get{{capitalize name}} : {{../moduleName}} -> {{type}}
    get{{capitalize name}} =
        .{{name}}

-}
get{{capitalize name}} : {{../moduleName}} -> {{type}}
get{{capitalize name}} =
    .{{name}}


{{/fields}}


-------------------------------------------------------------------------------
-- SETTER
-------------------------------------------------------------------------------


{{#fields}}
{-| Set the value of the {{name}} field.

    set{{capitalize name}} : {{type}} -> {{../moduleName}} -> {{../moduleName}}
    set{{capitalize name}} {{name}} {{decapitalize ../moduleName}} =
        { {{decapitalize ../moduleName}} | {{name}} = {{name}} }

-}
set{{capitalize name}} : {{type}} -> {{../moduleName}} -> {{../moduleName}}
set{{capitalize name}} {{name}} {{decapitalize ../moduleName}} =
    { {{decapitalize ../moduleName}} | {{name}} = {{name}} }


{{/fields}}

-------------------------------------------------------------------------------
-- MAPPER
-------------------------------------------------------------------------------


{{#fields}}
{-| Map the value of the {{name}} field.

    map{{capitalize name}} : ({{type}} -> {{type}}) -> {{../moduleName}} -> {{../moduleName}}
    map{{capitalize name}} fun {{decapitalize ../moduleName}} =
        { {{decapitalize ../moduleName}} | {{name}} = fun {{decapitalize ../moduleName}}.{{name}} }

-}
map{{capitalize name}} : ({{type}} -> {{type}}) -> {{../moduleName}} -> {{../moduleName}}
map{{capitalize name}} fun {{decapitalize ../moduleName}} =
    { {{decapitalize ../moduleName}} | {{name}} = fun {{decapitalize ../moduleName}}.{{name}} }


{{/fields}}