//Import Handlebars.js
type t<'a> = {
  registerHelper: (. string, option<string> => string) => unit,
  compile: (. string, {"strict": bool, "noEscape": bool}, . 'a) => string,
}
@module external handlebars: t<'whatever> = "handlebars"

/**
 * Register additional functions to handlebars
 */
let init = () => {
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
}

/**
 * Compile the template for the given data.
 */
let compile = (data, template) => {
  let moduleTemplate = handlebars.compile(. template, {"strict": true, "noEscape": true})
  moduleTemplate(. data)
}
