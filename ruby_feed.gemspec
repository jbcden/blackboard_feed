# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_feed/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_feed"
  spec.version       = RubyFeed::VERSION
  spec.authors       = ["Jacob Chae"]
  spec.email         = ["jbcden@gmail.com"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.required_ruby_version = ">=1.9.3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables = ["feed_update", "feed_setup"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
