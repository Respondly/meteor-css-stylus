Package.describe({
  name: 'respondly:css-stylus',
  summary: 'Meteor Stylus package extended to support Mixins.',
  version: '1.0.3',
  git: 'https://github.com/Respondly/meteor-css-stylus.git'
});




Package.onUse(function (api) {
  // api.versionsFrom('1.0');

  // Generated with: github.com/philcockfield/meteor-package-paths


});




Package._transitional_registerBuildPlugin({
  name: 'compileStylus',
  use: ['coffeescript'],
  sources: [
    'plugin/compile-stylus.js',
    'plugin/stylus-plugin.coffee'
  ],
  npmDependencies: {
    'stylus':     '0.47.1',
    'nib':        '1.0.3',
    'css-common': '1.0.24'
  }
});


