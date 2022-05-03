//Path to the directory of this package
@val external dirName: string = "__dirname"

//Import File Service
type fs = {
  readFileSync: (. string, string) => string,
  existsSync: (. string) => bool,
  mkdirSync: (. string, {"recursive": bool}) => unit,
  writeFileSync: (. string, string, {"flag": string}) => unit,
  rmSync: (. string, {"recursive": bool}) => unit,
  copyFileSync: (. string, string) => unit,
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

let createFolder: string => unit = dir => {
  if !fs.existsSync(. path.normalize(. dir)) {
    fs.mkdirSync(. path.normalize(. dir), {"recursive": true})
  }
}

/**
 * copies a file and then executes the provided function
 */
let copyFile: (string, string) => bool = (fileName: string, origin: string) => {
  try {
    fs.copyFileSync(. path.normalize(. `${dirName}/${origin}`), fileName)
    true
  } catch {
  | Js.Exn.Error(_) => false
  }
}

/**
 * Read the file and returns null if it does not exist
 */
let read: string => option<string> = file => {
  try {
    fs.readFileSync(. path.normalize(. file), "utf8")->Some
  } catch {
  | Js.Exn.Error(_) => None
  }
}

/**
 * Remove the folder
 */
let remove: string => unit = folder =>
  if fs.existsSync(. path.normalize(. folder)) {
    fs.rmSync(. path.normalize(. folder), {"recursive": true})
  }

/**
 * Write the source into the file
 */
let write = (source, args: {"path": string, "file": string}) => {
  let dir = args["path"]
  let generatedPath = `${dir}/${args["file"]}`

  createFolder(dir)
  fs.writeFileSync(. path.normalize(. generatedPath), source, {"flag": "w+"})
}

/**
 * Check if elm-gen.json exists and if not install it. Then call the specified function.
 */
let installAndThen = (fileName, fun) => {
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

  if !fs.existsSync(. fileName) {
    if !copyFile(fileName, fileName) {
      Js.Exn.raiseError(`❌ Could not copy ${path.normalize(. fileName)} into ${fileName}`)
    }
  }
  let json: json<'whatever> = switch read(fileName) {
  | Some(string) => parseJson(string)
  | None => Js.Exn.raiseError(`❌ Could not find ${fileName}`)
  }
  let templatesFrom = Util.getOrThrow(
    json["templatesFrom"],
    "❌ field \"templatesFrom\" is missing in elm-gen.json",
  )
  templatesFrom->copyFolderIfNotExist("templates/", () => fun(json, templatesFrom))
}
