//Import Handlebars.js
type handlebars<'a> = {
  registerHelper: (. string, string => string) => unit,
  compile: (. string, {"strict": bool}, . 'a) => string,
}
@module external handlebars: handlebars<'whatever> = "handlebars"

//Import File Service
type fs = {
  readFileSync: (. string, string) => string,
  existsSync: (. string) => bool,
  mkdirSync: (. string, {"recursive": bool}) => unit,
  writeFileSync: (. string, string, {"flag": string}) => unit,
}
@module external fs: fs = "fs"

// bind to JS' JSON.parse
type json<'a> = {
  "generateInto": string,
  "templatesFrom": string,
  "moduleBase": string,
  "modules": Js.Dict.t<Js.Dict.t<'a>>,
}
@scope("JSON") @val
external parseJson: string => json<{..}> = "parse"

let elmGen = "elm-gen"

//Register additional functions
handlebars.registerHelper(."capitalize", (aString: string) =>
  Js.String.charAt(0, aString)->Js.String.toUpperCase ++ Js.String.substringToEnd(~from=1, aString)
)
handlebars.registerHelper(."decapitalize", aString =>
  Js.String.charAt(0, aString)->Js.String.toLowerCase ++ Js.String.substringToEnd(~from=1, aString)
)

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
 * Generate the actual module based on module name, template and the json data
 */
let generateModule = (generateInto, templatesFrom, data) => {
  let moduleBase = data["moduleBase"]
  let moduleName = data["moduleName"]
  let template = data["template"]

  try {
    //read template
    let templateData = fs.readFileSync(. `${templatesFrom}/${template}.elm`, "utf8")

    //compile files
    let moduleTemplate = handlebars.compile(. templateData, {"strict": true})
    let output = moduleTemplate(. data)
    let namespace = Js.String.replace(".", "/", moduleBase)
    let dir = `${generateInto}/${namespace}/${template}`
    let generatedPath = `${dir}/${moduleName}.elm`

    //create folder structure
    if !fs.existsSync(. dir) {
      fs.mkdirSync(. dir, {"recursive": true})
    }

    //create file
    fs.writeFileSync(. generatedPath, output, {"flag": "w+"})
    Js.Console.log(`⭐ Generated ${template} ${moduleName}`)
  } catch {
  | Js.Exn.Error(err) => Js.Console.error(err)
  }
}

try {
  //Read json structure
  let json = parseJson(fs.readFileSync(. `${elmGen}.json`, "utf8"))
  json["modules"]

  //Loop over every entry in the json list
  |> Js.Dict.entries
  |> Js.Array.forEach(tup => {
    let (moduleName, moduleTemplates: Js.Dict.t<'whatever>) = tup

    //Loop over every template for a given moduleName
    moduleTemplates
    |> Js.Dict.entries
    |> Js.Array.forEach(tuple => {
      let (template: string, jsonData) = tuple

      //construct data
      let data = constructData(json["moduleBase"], moduleName, template, jsonData)

      //Generate the module for a given moduleName and template
      generateModule(json["generateInto"], json["templatesFrom"], data)
    })
  })
} catch {
| Js.Exn.Error(err) => Js.Console.error(err)
}
