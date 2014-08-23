Package.describe({
  summary: 'Meteor Stylus package extended to support Mixins.'
});




Package._transitional_registerBuildPlugin({
  name: 'compileStylus',
  use: ['coffeescript', 'sugar'],
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
  api.add_files('shared/_reset/html5-reset.css', 'client');
  api.add_files('shared/_reset/html5-reset.css', 'server', { isAsset:true });
  api.add_files('shared/css-mixins/alert.import.styl', 'client');
  api.add_files('shared/css-mixins/alert.import.styl', 'server', { isAsset:true });
  api.add_files('shared/css-mixins/core.import.styl', 'client');
  api.add_files('shared/css-mixins/core.import.styl', 'server', { isAsset:true });

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai', 'test-helpers', 'templating']);
  api.use('css-stylus');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/client/sample/sample.html', 'client');
  api.add_files('tests/client/sample/sample.import.styl', 'client');
  api.add_files('tests/client/sample/sample.styl', 'client');
  api.add_files('tests/client/tests.coffee', 'client');

});
