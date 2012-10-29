# -*- encoding: utf-8 -*-
require File.expand_path('../lib/discoverer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Xavier Via"]
  gem.email         = ["xavierviacanel@gmail.com"]
  gem.description   = %q{Discoverer functionality with focus in writers and readers}
  gem.summary       = %q{Discoverer functionality with focus in writers and readers}
  gem.homepage      = ""

  gem.add_dependency 'virtus'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "discoverer"
  gem.require_paths = ["lib"]
  gem.version       = Discoverer::VERSION
end
