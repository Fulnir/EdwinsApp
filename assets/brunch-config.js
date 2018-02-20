exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: { joinTo: "js/app.js" },
    // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //   "js/app.js": /^js/,
      //   "js/vendor.js": /^(?!js)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    stylesheets: { joinTo: "css/app.css" },
    templates: { joinTo: "js/app.js" }
  },
  conventions: { 
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/ },
    // Phoenix paths configuration
  paths: {
    watched: ["static", "css", "js", "vendor", "elm"],
    public: "../priv/static"
  },
  // Configure your plugins
  plugins: {// Do not use ES6 compiler in vendor code
    babel: { ignore: [/vendor/] },
    elmBrunch: {
      mainModules: ["elm/Main.elm"],
      makeParameters: ["--debug"],
      outputFile: "elm.js",
      outputFolder: "../assets/js"
    }
  },
  modules: {
    autoRequire: { "js/app.js": ["js/app"] }
  },
  npm: { enabled: true }
};