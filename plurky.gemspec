# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plurky/version'

Gem::Specification.new do |gem|
  gem.name          = "plurky"
  gem.version       = Plurky::VERSION
  gem.authors       = ["Chun-wei Kuo"]
  gem.email         = ["Dendoh@gmail.com"]
  gem.description   = %q{Yet another Plurk API}
  gem.summary       = %q{Yet another Plurk API}
  gem.homepage      = "https://github.com/Domon/plurky"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
end
