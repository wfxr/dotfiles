"use strict";
exports.__esModule = true;
exports.activate   = function(oni) {
    console.log("config activated");
    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", function() { return console.log("Control+Enter was pressed"); });
    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
};
exports.deactivate    = function(oni) { console.log("config deactivated"); };
exports.configuration = {
    "sidebar.enabled" : false,
    "ui.colorscheme" : "gruvbox",
    "ui.fontSize" : "16px",
    "oni.hideMenu" : true,
    "wildmenu.mode" : false,
    "commandline.mode" : false,
    "oni.useDefaultConfig" : true,
    "browser.defaultUrl" : "https://github.com",
    "oni.loadInitVim" : true,
    "editor.fontSize" : "16px",
    "editor.completions.mode" : "native", // [native, oni, hidden]
    "tabs.mode" : "hidden",
    //"editor.fontFamily": "DejaVu Sans Mono",
    // UI customizations
    "ui.animations.enabled" : true,
    "ui.fontSmoothing" : "auto"
};
