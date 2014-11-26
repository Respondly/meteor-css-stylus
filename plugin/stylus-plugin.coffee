fs      = Npm.require 'fs'
fsPath  = Npm.require 'path'

PLUGIN_DIRS = ['css_mixins', 'css-mixins', 'stylus-plugin']




###
A Stylus plugin that registers mixins within all packages.
###
@packageStylusPlugins = ->
  return (style) ->
      for rootDir in packageDirs()
        for dir in findPluginDirs(rootDir)
          style.include(dir)



# PRIVATE ----------------------------------------------------------------------



packageDirs = ->
  dirs = []
  dirs.push('packages') # Within the app.

  if PACKAGE_DIRS = process.env.PACKAGE_DIRS
    for path in PACKAGE_DIRS.split(':')
      dirs.push(path)

  dirs = dirs.map (path) -> fsPath.resolve(path)
  dirs = dirs.map (path) -> path if fs.existsSync(path)
  unique(dirs)




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

