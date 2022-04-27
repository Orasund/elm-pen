module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{{#imports}}
import {.}
{{/imports}}

type alias {{moduleName}} =
{{#fields}}
{{#if @first}}    { {{name}} : {{type}}
{{else}}   , {{name}} : {{type}}
{{/if}}
{{/fields}}
    }

-------------------------------------------------------------------------------
-- GET
-------------------------------------------------------------------------------

{{#fields}}
get{{capitalize name}} : {{../moduleName}} -> {{type}}
get{{capitalize name}} =
    .{{name}}

{{/fields}}

-------------------------------------------------------------------------------
-- SET
-------------------------------------------------------------------------------

{{#fields}}
set{{capitalize name}} : {{type}} -> {{../moduleName}} -> {{../moduleName}}
set{{capitalize name}} {{name}} {{decapitalize ../moduleName}} =
    { {{decapitalize ../moduleName}} | {{name}} = {{name}} }

{{/fields}}

-------------------------------------------------------------------------------
-- MAP
-------------------------------------------------------------------------------

{{#fields}}
map{{capitalize name}} : ({{type}} -> {{type}}) -> {{../moduleName}} -> {{../moduleName}}
map{{capitalize name}} fun {{decapitalize ../moduleName}} =
    { {{decapitalize ../moduleName}} | {{name}} = fun {{decapitalize ../moduleName}}.{{name}} }
