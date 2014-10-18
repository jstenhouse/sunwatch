$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

require 'sunwatch/version'

Gem::Specification.new do |spec|
  spec.name        = 'sunwatch'
  spec.version     = Sunwatch::VERSION
  spec.summary     = 'Provides UV index information'
  spec.description = 'Provides UV index information'
  spec.licenses    = ['MIT']
  spec.authors     = ['jstenhouse']
  spec.email       = 'jason.stenhouse@gmail.com'
  spec.homepage    = 'https://github.com/jstenhouse/sunwatch'

  spec.files       = `git ls-files`.split("\n")
  spec.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rspec'
end
