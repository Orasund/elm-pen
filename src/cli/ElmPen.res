type child_process = {exec: (. string) => unit}
@module external spawn: child_process = "child_process"

let run = () => {
  let elmGen = "elm-pen"

  let copyAndRead: (string, string) => option<string> = (file, copyFrom) => {
    switch FileSystem.read(file) {
    | Some(data) => Some(data)
    | None =>
      if FileSystem.copyFile(file, copyFrom) {
        FileSystem.read(file)
      } else {
        None
      }
    }
  }

  let getTemplateData: (string, string) => option<string> = (templatesFrom, template) => {
    let file = `${templatesFrom}/${template}.elm`
    let copyFrom = `templates/${template}.elm`
    copyAndRead(file, copyFrom)
  }

  Handlebars.init()

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
      | None => Js.Exn.raiseError(`❌ Could not find ${template}.elm inside ${templatesFrom}`)
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
  }
}
