/**
 * Construct the resulting json that will be used in the handlebars compiler.
 *
 * The following fields are always present
 * * moduleBase - The base namespace of your module. Example: `Gen`
 * * template - The template that handlebars should use. Example: `Enum`
 * * moduleName - Name of the module and the type. Example: `Direction`
 */
let constructData = (moduleBase, moduleName, template, baseData) => {
  baseData["moduleBase"] = moduleBase
  baseData["template"] = template
  baseData["moduleName"] = moduleName
  baseData
}

/**
 * Get the value of an optional type or throw an error
 */
let getOrThrow = (option: option<'a>, string: string) =>
  switch option {
  | Some(out) => out
  | None => Js.Exn.raiseError(string)
  }
