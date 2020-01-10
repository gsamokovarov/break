# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "break/version"

Gem::Specification.new do |spec|
  spec.name          = "break"
  spec.version       = Break::VERSION
  spec.authors       = ["Genadi Samokovarov"]
  spec.email         = ["gsamokovarov@gmail.com"]

  spec.summary       = "Lightweight Ruby debugger"
  spec.description   = "Lightweight Ruby debugger written in plain Ruby using the TracePoint API"
  spec.homepage      = "https://github.com/gsamokovarov/break"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"]

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "minitest", "~> 5.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
