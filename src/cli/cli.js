#!/usr/bin/env node

var processTitle = "elm-gen";

process.title = processTitle;

var elmGen = require("./ElmGen.js");

elmGen.run()