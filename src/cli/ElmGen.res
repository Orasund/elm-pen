//Import Handlebars.js
type handlebars<'a> = {
  registerHelper: (. string, option<string> => string) => unit,
  compile: (. string, {"strict": bool, "noEscape": bool}, . 'a) => string,
}
@module external handlebars: handlebars<'whatever> = "handlebars"

//Import File Service
type fs = {
  readFileSync: (. string, string) => string,
  existsSync: (. string) => bool,
  mkdirSync: (. string, {"recursive": bool}) => unit,
  writeFileSync: (. string, string, {"flag": string}) => unit,
  rmSync: (. string, {"recursive": bool}) => unit,
}
@module external fs: fs = "fs"

type child_process = {exec: (. string) => unit}
@module external spawn: child_process = "child_process"

// bind to JS' JSON.parse
type json<'a> = {
  "generateInto": option<string>,
  "templatesFrom": option<string>,
  "moduleBase": option<string>,
  "pathToElmFormat": option<string>,
  "modules": Js.Dict.t<Js.Dict.t<'a>>,
}
@scope("JSON") @val
external parseJson: string => json<{..}> = "parse"

let run = () => {
  let elmGen = "elm-gen"

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

  //Register additional functions
  handlebars.registerHelper(."capitalize", (aString: option<string>) => {
    switch aString {
    | None => Js.Exn.raiseError("can't capitalize an undefined argument")
    | Some("") => Js.Exn.raiseError("can't capitalize an empty argument")
    | Some(string) =>
      Js.String.charAt(0, string)->Js.String.toUpperCase ++
        Js.String.substringToEnd(~from=1, string)
    }
  })
  handlebars.registerHelper(."decapitalize", (aString: option<string>) => {
    switch aString {
    | None => Js.Exn.raiseError("can't decapitalize an undefined argument")
    | Some("") => Js.Exn.raiseError("can't decapitalize an empty argument")
    | Some(string) =>
      Js.String.charAt(0, string)->Js.String.toLowerCase ++
        Js.String.substringToEnd(~from=1, string)
    }
  })

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
      let moduleTemplate = handlebars.compile(. templateData, {"strict": true, "noEscape": true})
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

    //remove folder
    switch (json["generateInto"], json["templatesFrom"], json["moduleBase"]) {
    | (Some(generateInto), Some(templatesFrom), Some(moduleBase)) =>
      if fs.existsSync(. generateInto) {
        fs.rmSync(. generateInto, {"recursive": true})

        //Loop over every entry in the json list
        json["modules"]
        |> Js.Dict.entries
        |> Js.Array.forEach(tup => {
          let (moduleName, moduleTemplates: Js.Dict.t<'whatever>) = tup

          //Loop over every template for a given moduleName
          moduleTemplates
          |> Js.Dict.entries
          |> Js.Array.forEach(tuple => {
            let (template: string, jsonData) = tuple

            //construct data
            let data = constructData(moduleBase, moduleName, template, jsonData)

            //Generate the module for a given moduleName and template
            generateModule(generateInto, templatesFrom, data)
          })
        })

        switch json["pathToElmFormat"] {
        | Some(path) => spawn.exec(. path ++ " " ++ generateInto ++ " --yes")
        | None => ()
        }
      }
    | (None, _, _) => Js.Console.error("field \"generateInto\" is missing in elm-gen.json")
    | (Some(_), None, _) => Js.Console.error("field \"templatesFrom\" is missing in elm-gen.json")
    | (Some(_), Some(_), None) =>
      Js.Console.error("field \"moduleBase\" is missing in elm-gen.json")
    }
  } catch {
  | Js.Exn.Error(err) => Js.Console.error(err)
  }
}
