# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "toy_robot/version"

Gem::Specification.new do |spec|
  spec.name          = "toy-robot"
  spec.version       = ToyRobot::VERSION
  spec.authors       = ["Anonymous"]
  spec.email         = ["no-name@example.com"]

  spec.summary       = "An implementation of the Toy Robot specification coding test"
  spec.description   = '
    This is a personal attempt at implementing the Toy Robot specification brief
    as a part of expected coding tests in the future for Ruby Developer
    positions within Melbourne. It should demonstrate good coding practices,
    some coding patterns and overall my relevant skill as a developer.
  '
  spec.homepage = "https://github.com/sonna/toy-robot"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
