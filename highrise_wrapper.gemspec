# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'highrise_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "highrise_wrapper"
  spec.version       = HighriseWrapper::VERSION
  spec.authors       = ["rhlobo"]
  spec.email         = ["rhlobo+github@gmail.com"]
  spec.summary       = "Gem to provide easy usage of Highrise API"
  spec.description   = 'Gem to provide easy usage of Highrise API.
                        Built wrapping the highrise gem, it is a POC
                        created by me in order to study rubys platform'
  spec.homepage      = "http://github.com/rhlobo/highrise_wrapper"
  spec.license       = "MIT"

  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = ">= 1.9.3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "highrise", "~> 3.1"
  spec.add_dependency "simple_attribute_mapper", "~> 0.0.3"
  spec.add_dependency "virtus", "~> 1.0.2"
end
