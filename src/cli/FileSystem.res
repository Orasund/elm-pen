//Path to the directory of this package
@val external dirName: string = "__dirname"

//Import File Service
type fs = {
  readFileSync: (. string, string) => string,
  existsSync: (. string) => bool,
  mkdirSync: (. string, {"recursive": bool}) => unit,
  writeFileSync: (. string, string, {"flag": string}) => unit,
  rmSync: (. string, {"recursive": bool}) => unit,
  copyFile: (. string, string, Js.Nullable.t<string> => unit) => unit,
}
@module external fs: fs = "fs"

type fsExtra = {copy: (. string, string, Js.Nullable.t<string> => unit) => unit}
@module external fsExtra: fsExtra = "fs-extra"

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

type path = {
  join: (. string, string) => string,
  normalize: (. string) => string,
}
@module external path: path = "path"

let copyIfNotExist = (fileName: string, fun: unit => 'b) => {
  if !fs.existsSync(. fileName) {
    fs.copyFile(.path.normalize(. `${dirName}/${fileName}`), fileName, nullable => {
      switch Js.Nullable.toOption(nullable) {
      | Some(err) => Js.Exn.raiseError(err)
      | None => fun()
      }
    })
  } else {
    fun()
  }
}

let copyFolderIfNotExist = (fileName: string, origin: string, fun: unit => 'b) => {
  if !fs.existsSync(. fileName) {
    fsExtra.copy(.path.normalize(. `${dirName}/${origin}`), fileName, nullable => {
      switch Js.Nullable.toOption(nullable) {
      | Some(err) => Js.Exn.raiseError(err)
      | None => fun()
      }
    })
  } else {
    fun()
  }
}

/**
 * Read the file or throw an error if it does not exist
 */
let readOrThrow = (file: string, string: string) => {
  try {
    fs.readFileSync(. path.normalize(. file), "utf8")
  } catch {
  | Js.Exn.Error(_) => Js.Exn.raiseError(string)
  }
}

let readOrCopy = (fileName: string, fun: string => 'b) =>
  copyIfNotExist(fileName, () => fileName->readOrThrow(`❌ Could not find ${fileName}`)->fun)

/**
 * Check if elm-gen.json exists and if not install it. Then call the specified function.
 */
let installAndThen = (fileName, fun) =>
  readOrCopy(fileName, jsonString => {
    let json: json<'whatever> = parseJson(jsonString)
    let templatesFrom = Util.getOrThrow(
      json["templatesFrom"],
      "❌ field \"templatesFrom\" is missing in elm-gen.json",
    )
    templatesFrom->copyFolderIfNotExist("templates/", () => fun(json, templatesFrom))
  })

/**
 * Write the source into the file
 */
let write = (source, args: {"path": string, "file": string}) => {
  let dir = args["path"]
  let generatedPath = `${dir}/${args["file"]}`
  //create folder structure
  if !fs.existsSync(. path.normalize(. dir)) {
    fs.mkdirSync(. path.normalize(. dir), {"recursive": true})
  }

  //create file
  fs.writeFileSync(. path.normalize(. generatedPath), source, {"flag": "w+"})
}

/**
 * Remove the folder
 */
let remove = folder =>
  if fs.existsSync(. path.normalize(. folder)) {
    fs.rmSync(. path.normalize(. folder), {"recursive": true})
  }
