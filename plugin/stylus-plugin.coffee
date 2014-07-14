fs      = Npm.require 'fs'
fsPath  = Npm.require 'path'



###
A Stylus plugin that registers mixins within all packages.
###

@packageStylusPlugins = ->
  return (style) ->

    pluginDirs = ['css_mixins', 'css-mixins', 'stylus-plugin']

    # Add the package mixin.
    # NOTE: Changes to "mixin" files will not auto-force a restart of the server.
    #       Either restart the server manually, or change another file within the packages.

    includePackageDir = (rootDir, pluginDir) ->
        includeDir(style, packagePath("/#{ rootDir }/client/#{ pluginDir }"))
        includeDir(style, packagePath("/#{ rootDir }/shared/#{ pluginDir }"))

    for rootDir in fs.readdirSync(packagePath())
      for pluginDir in pluginDirs
        includePackageDir(rootDir, pluginDir)


    # Add the application's "plugin/mixins" folder if it exists.
    includeAppDir = (pluginDir) ->
        includeDir(style, fsPath.resolve("./packages/app/client/#{ pluginDir }"))
        includeDir(style, fsPath.resolve("./packages/app/shared/#{ pluginDir }"))

        includeDir(style, fsPath.resolve("./client/#{ pluginDir }"))
        includeDir(style, fsPath.resolve("./shared/#{ pluginDir }"))

    for pluginDir in pluginDirs
      includeAppDir(pluginDir)




# PRIVATE ----------------------------------------------------------------------



packagePath = (path) ->
  path = (process.env.PACKAGE_DIRS || 'packages') + (path || '')
  return fsPath.resolve(path)


includeDir = (style, dir) ->
  if fs.existsSync(dir)
    style.include(dir)



