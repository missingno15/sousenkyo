# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sousenkyo/version'

Gem::Specification.new do |spec|
  spec.name          = "sousenkyo"
  spec.version       = Sousenkyo::VERSION
  spec.authors       = ["Kenneth Uy"]
  spec.email         = ["missingno15@gmail.com"]

  spec.summary       = %q{CLI app that extracts serial codes from scanned AKB48 Sousenkyo voting tickets and votes for the user}
  spec.homepage      = "https://github.com/missingno15/sousenkyo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "rtesseract"
  spec.add_dependency "rmagick"
  spec.add_dependency "selenium-webdriver"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency "vcr"
end
