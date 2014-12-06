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
      for rootDir in packageDirs(currentPackageDir)
        for dir in findPluginDirs(rootDir)
          if fs.existsSync(dir)
            style.include(dir)



# PRIVATE ----------------------------------------------------------------------



packageDirs = (currentPackageDir) ->
  dirs = []
  dirs.push('packages') # Within the app.
  dirs.push(currentPackageDir)

  if PACKAGE_DIRS = process.env.PACKAGE_DIRS
    for path in PACKAGE_DIRS.split(':')
      dirs.push(path)

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

