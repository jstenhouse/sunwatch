$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

require 'sunwatch/version'

Gem::Specification.new do |spec|
  spec.name        = 'sunwatch'
  spec.version     = Sunwatch::VERSION
  spec.summary     = 'Provides EPA UV index information for the US'
  spec.description = 'Provides EPA UV index information for the US'
  spec.authors     = ['jstenhouse']
  spec.email       = 'jason.stenhouse@gmail.com'
  spec.homepage    = 'https://github.com/jstenhouse/sunwatch'
  spec.licenses    = ['MIT']

  spec.files       = `git ls-files`.split("\n")
  spec.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
