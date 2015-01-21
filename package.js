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
    'stylus':     '0.49.3',
    'nib':        '1.0.3'
  }
});


Package.onTest(function(api){
  api.use(['mike:mocha-package@0.4.7', 'coffeescript']);  

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('tests/shared/sample.coffee', ['client', 'server']);

});
