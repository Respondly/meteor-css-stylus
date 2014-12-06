fs      = Npm.require 'fs'
fsPath  = Npm.require 'path'

PLUGIN_DIRS = ['css_mixins', 'css-mixins', 'stylus-plugin']




###
A Stylus plugin that registers mixins within all packages.
###
@packageStylusPlugins = (compileStep) ->
  # Derive paths.
  fullPath = compileStep.fullInputPath
  relativePath = compileStep.inputPath
  currentPackageDir = fullPath.substring(0, (fullPath.length - relativePath.length))

  # Return a function that adds "mix-in" directories to
  # the style compiler.
  return (style) ->
      # Look in the current package, and the "/packages" folder within an app.
      for rootDir in processDirs(['packages', currentPackageDir])
        for dir in findPluginDirs(rootDir)
          style.include(dir)

      # Look for 'css-mixins' (et al) folders within known locations
      # with any folder specified within PACKAGE_DIRS.
      #   -  /<package>/css-mixins
      #   -  /<package>/client/css-mixins
      #   -  /<package>/shared/css-mixins
      for dir in sharedPackageDirs()
        style.include(dir)



# PRIVATE ----------------------------------------------------------------------



sharedPackageDirs = ->
  dirs = []
  if PACKAGE_DIRS = process.env.PACKAGE_DIRS
    for path in PACKAGE_DIRS.split(':')
      for packageDir in fs.readdirSync(path)
        continue if packageDir[0] is '.' # Exclude .DS_Store, .git etc.
        packageDir = fsPath.join(path, packageDir)
        for domain in ['client', 'shared', '.']
          for pluginDir in PLUGIN_DIRS
            pluginDir = fsPath.join(fsPath.join(packageDir, domain), pluginDir)
            if fs.existsSync(pluginDir)
              dirs.push(pluginDir)

  processDirs(dirs)




processDirs = (dirs) ->
  dirs = compact(dirs)
  dirs = dirs.map (path) -> fsPath.resolve(path)
  dirs = dirs.map (path) -> path if fs.existsSync(path)
  dirs = unique(dirs)
  dirs




findPluginDirs = (rootDir) ->
  dirs = []
  walkDirs rootDir, (dir) ->
      for pluginDir in PLUGIN_DIRS
        dirs.push(dir) if endsWith(dir, pluginDir)
  dirs




walkDirs = (rootDir, func) ->
  rootDir = fsPath.resolve(rootDir)

  for dir in fs.readdirSync(rootDir)
    # Prepare the path.
    continue if dir[0] is '.'

    # Ignore sym-links and non directories.
    dir = fsPath.join(rootDir, dir)
    stats = fs.lstatSync(dir)
    continue if stats.isSymbolicLink()
    continue unless stats.isDirectory()

    # Invoke function.
    func?(dir)

    # Walk children.
    walkDirs(dir, func)




# UTIL ----------------------------------------------------------------------



endsWith = (string, match) ->
  index = string.indexOf(match)
  return false if index < 0
  index is string.length - match.length



unique = (array) ->
  result = []
  for item in array
    if item?
      result.push(item) if result.indexOf(item) < 0
  result


compact = (array) ->
  result = []
  for item in array
    result.push(item) if item?
  result
