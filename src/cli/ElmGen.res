type child_process = {exec: (. string) => unit}
@module external spawn: child_process = "child_process"

let run = () => {
  let elmGen = "elm-gen"

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
      let templateData =
        `${templatesFrom}/${template}.elm`->FileSystem.readOrThrow(
          `❌ Could not find ${template} inside ${templatesFrom}`,
        )

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
    let errorMessage = string => `❌ field ${string} is missing in elm-gen.json`
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
