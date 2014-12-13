# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alfredpi/version'

Gem::Specification.new do |spec|
  spec.name          = "alfredpi"
  spec.version       = Alfredpi::VERSION
  spec.authors       = ["Luc"]
  spec.email         = ["luc@boissaye.fr"]
  spec.summary       = %q{AlfredPi controls hue lamp from a raspberryPi}
  spec.description   = %q{AlfredPi controls hue lamp from a raspberryPi}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'eventmachine', '~> 1.0'
  spec.add_runtime_dependency 'hue', '~> 0.1'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
