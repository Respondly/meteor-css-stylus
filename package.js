Package.describe({
  name: 'respondly:css-stylus',
  summary: 'Meteor Stylus package extended to support Mixins.',
  version: '0.0.1',
  git: 'https://github.com/Respondly/meteor-css-stylus.git'
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


