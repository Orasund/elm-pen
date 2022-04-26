type handlebars<'a> = {
  registerHelper: (. string, string => string) => unit,
  compile: (. string, {"strict": bool}, . 'a) => string,
}
type fs = {
  readFileSync: (. string, string) => string,
  existsSync: (. string) => bool,
  mkdirSync: (. string, {"recursive": bool}) => unit,
  writeFileSync: (. string, string, {"flag": string}) => unit,
}

@module external handlebars: handlebars<'whatever> = "handlebars"
@module external fs: fs = "fs"
// bind to JS' JSON.parse
@scope("JSON") @val
external parseJson: string => 'whatever = "parse"

let elmGen = "elm-gen"

//Register additional functions
handlebars.registerHelper(."capitalize", (aString: string) =>
  Js.String.charAt(0, aString)->Js.String.toUpperCase ++ Js.String.substringToEnd(~from=1, aString)
)
handlebars.registerHelper(."decapitalize", aString =>
  Js.String.charAt(0, aString)->Js.String.toLowerCase ++ Js.String.substringToEnd(~from=1, aString)
)

let constructData = (moduleBase, moduleName, template, baseData) => {
  let data = baseData
  data["moduleBase"] = moduleBase
  data["moduleName"] = moduleName
  data["template"] = template
  data
}

let generateModule = (moduleBase, moduleName, template, baseData) => {
  //construct data
  let data = constructData(moduleBase, moduleName, template, baseData)
  Js.Console.log(data)

  try {
    //read template
    let templateData = fs.readFileSync(.
      "." ++ elmGen ++ "/templates/" ++ data["template"] ++ ".elm",
      "utf8",
    )

    //compile files
    let template = handlebars.compile(. templateData, {"strict": true})
    let output = template(. data)
    let dir =
      "." ++
      elmGen ++
      "/generated/" ++
      Js.String.replace(".", "/", data["moduleBase"]) ++
      ("/" ++
      data["template"])
    let generatedPath = dir ++ "/" ++ data["moduleName"] ++ ".elm"

    //create folder structure
    if !fs.existsSync(. dir) {
      fs.mkdirSync(. dir, {"recursive": true})
    }

    //create file
    fs.writeFileSync(. generatedPath, output, {"flag": "w+"})
  } catch {
  | Js.Exn.Error(err) => Js.Console.error(err)
  }
}

try {
  //Read json structure
  let json = parseJson(fs.readFileSync(. elmGen ++ ".json", "utf8"))
  json["modules"]
  |> Js.Dict.entries
  |> Js.Array.forEach(tup => {
    let (moduleName, moduleTemplates: Js.Dict.t<'whatever>) = tup
    let moduleBase = json["moduleBase"]
    moduleTemplates
    |> Js.Dict.entries
    |> Js.Array.forEach(tuple => {
      let (template: string, data) = tuple
      generateModule(moduleBase, moduleName, template, data)
    })
  })
} catch {
| Js.Exn.Error(err) => Js.Console.error(err)
}
