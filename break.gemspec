lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "break/version"

Gem::Specification.new do |spec|
  spec.name          = "break"
  spec.version       = Break::VERSION
  spec.authors       = ["Genadi Samokovarov"]
  spec.email         = ["gsamokovarov@gmail.com"]

  spec.summary       = "Experimental debugger in plain Ruby"
  spec.description   = "Experimental debugger in plain Ruby using the TracePoint API"
  spec.homepage      = "https://github.com/gsamokovarov/break"
  spec.license       = "MIT"

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
