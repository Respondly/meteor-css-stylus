Package.describe({
  summary: 'Meteor Stylus package extended to support Mixins.'
});




Package._transitional_registerBuildPlugin({
  name: 'compileStylus',
  use: ['coffeescript'],
  sources: [
    'plugin/compile-stylus.js',
    'plugin/stylus-plugin.coffee'
  ],
  npmDependencies: {
    stylus: '0.47.1',
    nib:    '1.0.3'
  }
});


Package.on_use(function (api) {

  // Generated with: github.com/philcockfield/meteor-package-paths
  

});


