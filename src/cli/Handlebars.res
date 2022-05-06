//Import Handlebars.js
type t<'a, 'whatever> = {
  registerHelper: (. string, 'whatever) => unit,
  compile: (. string, {"strict": bool, "noEscape": bool}, . 'a) => string,
}
@module external handlebars: t<'whatever, 'whatever> = "handlebars"

@val external isEmpty: 'whatever => bool = "Handlebars.Utils.isEmpty"
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
  handlebars.registerHelper(."eq", (. optionI: option<int>, optionJ: option<int>) => {
    switch (optionI, optionJ) {
    | (None, _) => Js.Exn.raiseError("first argument of eq is null")
    | (Some(_), None) => Js.Exn.raiseError("second argument of eq is null")
    | (Some(i), Some(j)) => Js.Int.equal(i, j)
    }
  })
  handlebars.registerHelper(."or", (. a: 'whatever, b: 'whatever) => {
    !isEmpty(a) || !isEmpty(b)
  })
  handlebars.registerHelper(."and", (. a: 'whatever, b: 'whatever) => {
    !isEmpty(a) && !isEmpty(b)
  })
}

/**
 * Compile the template for the given data.
 */
let compile = (data, template) => {
  let moduleTemplate = handlebars.compile(. template, {"strict": true, "noEscape": true})
  moduleTemplate(. data)
}
