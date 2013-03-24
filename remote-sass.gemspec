# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'remote-sass/version'

Gem::Specification.new do |gem|
  gem.name          = "remote-sass"
  gem.version       = Remote::Sass::VERSION
  gem.authors       = ["Joe Ellis"]
  gem.email         = ["joe@joeellis.la"]
  gem.description   =  "Import remote urls with Sass."
  gem.summary       = "Allows the ability to fetch remote SASS/SCSS stylesheets over http"
  gem.homepage      = "https://github.com/joeellis/remote-sass"

  gem.files         = `git ls-files`.split "\n"
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = ">= 1.9.2"
  gem.add_runtime_dependency "sass", "~> 3.2"
  gem.add_development_dependency "rspec", "~> 2.8"
end
