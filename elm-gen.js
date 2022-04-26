"use strict";

const Handlebars = require("handlebars")
const fs = require("fs")

const ELM_GEN = "elm-gen"

//Register additional functions
Handlebars.registerHelper('capitalize', function (aString) {
    return aString[0].toUpperCase() + aString.substring(1);
})
Handlebars.registerHelper('decapitalize', function (aString) {
    return aString[0].toLowerCase() + aString.substring(1);
})

function generateModule(moduleBase,moduleName) {
    return module => {
        //construct data
        const data = module[1]
        data.moduleBase = moduleBase
        data.moduleName = moduleName
        data.template = module[0]
        console.log(data)

        try {
            //read template
            const templateData = fs.readFileSync("." + ELM_GEN + "/templates/" + data.template + ".elm", "utf8")
        
            //compile files
            const template = Handlebars.compile(templateData,{strict : true})
            const output = template(data)
            const dir = ("." + ELM_GEN + "/generated/") + data.moduleBase.replace(".","/") + ("/" + data.template)
            const generatedPath =  dir + "/" + data.moduleName  + ".elm"

            //create folder structure
            if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
            
            //create file
            fs.writeFileSync(generatedPath, output, {flag : "w+"})
        } catch (err) {
            console.error(err)
        }
    }
}

try { 
    //Read json structure
    const json = JSON.parse(fs.readFileSync(ELM_GEN + ".json", "utf8"))
    Object.entries(json.modules)
        .forEach(modules => {
            const moduleName = modules[0]
            Object.entries(modules[1])
                .forEach(generateModule(json.moduleBase,moduleName))
        });
} catch (err) {
    console.error(err)
}

