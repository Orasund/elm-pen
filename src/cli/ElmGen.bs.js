// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Fs = require("fs");
var Js_exn = require("rescript/lib/js/js_exn.js");
var Js_dict = require("rescript/lib/js/js_dict.js");
var Handlebars = require("handlebars");
var Caml_js_exceptions = require("rescript/lib/js/caml_js_exceptions.js");

var elmGen = "elm-gen";

Handlebars.registerHelper("capitalize", (function (aString) {
        if (aString !== undefined) {
          if (aString === "") {
            return Js_exn.raiseError("can't capitalize an empty argument");
          } else {
            return aString.charAt(0).toUpperCase() + aString.substring(1);
          }
        } else {
          return Js_exn.raiseError("can't capitalize an undefined argument");
        }
      }));

Handlebars.registerHelper("decapitalize", (function (aString) {
        if (aString !== undefined) {
          if (aString === "") {
            return Js_exn.raiseError("can't decapitalize an empty argument");
          } else {
            return aString.charAt(0).toLowerCase() + aString.substring(1);
          }
        } else {
          return Js_exn.raiseError("can't decapitalize an undefined argument");
        }
      }));

function constructData(moduleBase, moduleName, template, baseData) {
  baseData.moduleBase = moduleBase;
  baseData.template = template;
  baseData.moduleName = moduleName;
  return baseData;
}

function generateModule(generateInto, templatesFrom, data) {
  var moduleBase = data.moduleBase;
  var moduleName = data.moduleName;
  var template = data.template;
  try {
    var templateData = Fs.readFileSync(templatesFrom + "/" + template + ".elm", "utf8");
    var moduleTemplate = Handlebars.compile(templateData, {
          strict: true,
          noEscape: true
        });
    var output = moduleTemplate(data);
    var namespace = moduleBase.replace(".", "/");
    var dir = generateInto + "/" + namespace + "/" + template;
    var generatedPath = dir + "/" + moduleName + ".elm";
    if (!Fs.existsSync(dir)) {
      Fs.mkdirSync(dir, {
            recursive: true
          });
    }
    Fs.writeFileSync(generatedPath, output, {
          flag: "w+"
        });
    console.log("⭐ Generated " + template + " " + moduleName);
    return ;
  }
  catch (raw_err){
    var err = Caml_js_exceptions.internalToOCamlException(raw_err);
    if (err.RE_EXN_ID === Js_exn.$$Error) {
      console.error(err._1);
      return ;
    }
    throw err;
  }
}

try {
  var json = JSON.parse(Fs.readFileSync(elmGen + ".json", "utf8"));
  if (Fs.existsSync(json.generateInto)) {
    Fs.rmSync(json.generateInto, {
          recursive: true
        });
  }
  Js_dict.entries(json.modules).forEach(function (tup) {
        var moduleName = tup[0];
        Js_dict.entries(tup[1]).forEach(function (tuple) {
              var data = constructData(json.moduleBase, moduleName, tuple[0], tuple[1]);
              return generateModule(json.generateInto, json.templatesFrom, data);
            });
        
      });
}
catch (raw_err){
  var err = Caml_js_exceptions.internalToOCamlException(raw_err);
  if (err.RE_EXN_ID === Js_exn.$$Error) {
    console.error(err._1);
  } else {
    throw err;
  }
}

exports.elmGen = elmGen;
exports.constructData = constructData;
exports.generateModule = generateModule;
/*  Not a pure module */