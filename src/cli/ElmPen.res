type child_process = {exec: (. string) => unit}
@module external spawn: child_process = "child_process"

@new @module external newAjv: unit => 'whatever = "ajv"
exception Default(string)

// bind to JS' JSON.parse
type config<'a, 'b> = {
  schema: option<'a>,
  errors: 'b,
}
@scope("JSON") @val
external parseConfig: string => 'whatever = "parse"

let run = () => {
  let elmGen = "elm-pen"

  let copyAndRead: (string, string, string) => option<string> = (readFrom, copyFrom, file) => {
    switch FileSystem.read(`${readFrom}/${file}`) {
    | Some(data) => Some(data)
    | None => {
        FileSystem.createFolder(readFrom)
        if FileSystem.copyFile(`${readFrom}/${file}`, `${copyFrom}/${file}`) {
          FileSystem.read(`${readFrom}/${file}`)
        } else {
          None
        }
      }
    }
  }

  let getTemplateData: (string, string) => option<string> = (templatesFrom, template) => {
    let readFrom = `${templatesFrom}/${template}`
    let copyFrom = `templates/${template}`
    let file = "Template.elm"
    copyAndRead(readFrom, copyFrom, file)
  }

  let getConfigData: (string, string) => option<string> = (schemasFrom, schema) => {
    let readFrom = `${schemasFrom}/${schema}`
    let copyFrom = `templates/${schema}`
    let file = "Config.json"
    copyAndRead(readFrom, copyFrom, file)
  }

  Handlebars.init()
  let ajv = newAjv()
  /**
   * Generate the actual module based on module name, template and the json data
   */
  let generateModule = (generateInto, templatesFrom, data) => {
    let moduleBase = data["moduleBase"]
    let moduleName = data["moduleName"]
    let template = data["template"]

    try {
      //read template
      let templateData = switch getTemplateData(templatesFrom, template) {
      | Some(data) => data
      | None => {
          Js.Console.log(`❌ Error while generating ${moduleName} ${template}:`)
          Js.Exn.raiseError(`Could not find the template inside ${templatesFrom}/${template}`)
        }
      }

      //read config
      let configData = switch getConfigData(templatesFrom, template) {
      | Some(data) => parseConfig(data)
      | None => {
          Js.Console.log(`❌ Error while generating ${moduleName} ${template}:`)
          Js.Exn.raiseError(`Could not find the config inside ${templatesFrom}/${template}`)
        }
      }

      //validate
      switch configData.schema {
      | Some(schema) =>
        try {
          let _ = ajv["compile"](. schema)
        } catch {
        | Js.Exn.Error(err) => {
            Js.Console.log(`❌ The ${template} json schema is is illformed:`)
            Js.Console.error(err)
            Js.Exn.raiseError(`Could not generate ${moduleName} ${template}`)
          }
        }
        let validate = ajv["compile"](. schema)
        let valid = validate(. data)
        if !valid {
          Js.Console.log(`❌ Error in ${template} ${moduleName}:`)
          validate["errors"] |> Js.Array.forEach(err =>
            Js.Console.error("    " ++ err["instancePath"] ++ " " ++ err["message"])
          )
          raise_notrace(Default(`Could not generate ${moduleName} ${template}`))
        }

      | None => {
          Js.Console.log(`❌ Error in ${template} ${moduleName} :`)
          raise_notrace(Default(`Could not find schema in config file`))
        }
      }

      //compile files
      let namespace = Js.String.replace(".", "/", moduleBase)
      data
      ->Handlebars.compile(templateData)
      ->FileSystem.write({
        "path": `${generateInto}/${namespace}/${template}`,
        "file": `${moduleName}.elm`,
      })
      Js.Console.log(`⭐ Generated ${template} ${moduleName}`)
    } catch {
    | Js.Exn.Error(err) => Js.Console.error(err)
    }
  }

  let generate = (json, templatesFrom) => {
    let errorMessage = string => `❌ field ${string} is missing in ${elmGen}.json`
    let generateInto = json["generateInto"]->Util.getOrThrow(errorMessage("generateInto"))
    let moduleBase = json["moduleBase"]->Util.getOrThrow(errorMessage("moduleBase"))

    FileSystem.remove(generateInto)

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
        let data = Util.constructData(moduleBase, moduleName, template, jsonData)

        //Generate the module for a given moduleName and template
        generateModule(generateInto, templatesFrom, data)
      })
    })

    switch json["pathToElmFormat"] {
    | Some(path) => spawn.exec(. path ++ " " ++ generateInto ++ " --yes")
    | None => ()
    }
  }

  try {
    FileSystem.installAndThen(`${elmGen}.json`, generate)
  } catch {
  | Js.Exn.Error(err) => Js.Console.error(err)
  | Default(string) => Js.Console.error(string)
  }
}
