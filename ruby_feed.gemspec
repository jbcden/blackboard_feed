# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_feed/version'

Gem::Specification.new do |spec|
  spec.name          = "blackboard_feed"
  spec.version       = RubyFeed::VERSION
  spec.authors       = ["Jacob Chae"]
  spec.email         = ["jbcden@gmail.com"]

  spec.summary       = "A feed file parser"
  spec.description   = "This parses feed files for the Oberlin CIT office and loads them into a mysql db"
  spec.homepage      = "https://github.com/jbcden/blackboard_feed"
  spec.required_ruby_version = ">=1.9.3"
  spec.license = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables = ["feed_update", "feed_setup"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
