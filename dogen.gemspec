# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dogen/version'

Gem::Specification.new do |spec|
  spec.name          = 'dogen'
  spec.version       = Dogen::VERSION
  spec.authors       = ['Pawel Niemczyk']
  spec.email         = ['pniemczyk@o2.pl']
  spec.summary       = %q{Documents generator for bash}
  spec.description   = %q{Documents generator for bash}
  spec.homepage      = 'https://github.com/pniemczyk/dogen'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'awesome_print', '~> 1.2'
  spec.add_dependency 'hashie', '~> 2.1'
  spec.add_dependency 'commander', '~> 4.2'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'guard-rspec', '~> 0'
  spec.add_development_dependency 'coveralls', '~> 0'
end
