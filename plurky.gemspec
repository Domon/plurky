# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plurky/version'

Gem::Specification.new do |gem|
  gem.name          = "plurky"
  gem.version       = Plurky::VERSION
  gem.authors       = ["Chun-wei Kuo"]
  gem.email         = ["Dendoh@gmail.com"]
  gem.description   = %q{Yet another Plurk API wrapper}
  gem.summary       = %q{Yet another Plurk API wrapper}
  gem.homepage      = "https://github.com/Domon/plurky"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'faraday',      '~> 0.8.4'
  gem.add_dependency 'simple_oauth', '~> 0.1.9'
  gem.add_dependency 'multi_json',   '~> 1.3.7'
  gem.add_dependency 'hashie',       '~> 2.0.5'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'pry-nav'
end
