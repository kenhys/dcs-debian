# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dcs/debian/version'

Gem::Specification.new do |spec|
  spec.name          = "dcs-debian"
  spec.version       = Dcs::Debian::VERSION
  spec.authors       = ["HAYASHI Kentaro"]
  spec.email         = ["kenhys@gmail.com"]
  spec.summary       = %q{Command line tool which uses Debian Code Search to search debian/ files.}
  spec.description   = %q{Search debian/ files which contains specific keyword from Debian Code Search (http://codesearch.debian.net).}
  spec.homepage      = "https://github.com/kenhys/dcs-debian"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.19.1"
  spec.add_runtime_dependency "colored", "~> 1.2"
  spec.add_runtime_dependency "nokogiri", "~> 1.6.4"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
