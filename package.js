Package.describe({
  summary: 'Meteor Stylus package extended to support Mixins.'
});


Package._transitional_registerBuildPlugin({
  name: "compileStylus",
  use: ['coffeescript'],
  sources: [
    'plugin/compile-stylus.js',
    'plugin/package-mixins.coffee'
  ],
  npmDependencies: { stylus: "0.47.1", nib: "1.0.3" }
});




Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai', 'test-helpers', 'templating']);
  api.use('stylus-compiler');

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('tests/client/sample/sample.html', 'client');
  api.add_files('tests/client/sample/sample.import.styl', 'client');
  api.add_files('tests/client/sample/sample.styl', 'client');
  api.add_files('tests/client/base-tests.coffee', 'client');

});
