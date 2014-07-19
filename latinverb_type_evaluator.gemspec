# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'latinverb_type_evaluator/version'

Gem::Specification.new do |spec|
  spec.name          = "latinverb_type_evaluator"
  spec.version       = TypeEvaluator::VERSION
  spec.authors       = ["Steven G. Harms"]
  spec.email         = ["sgharms@stevengharms.com"]
  spec.summary       = %q{Based on a Latin Verb description string, return the associated verb type}
  spec.description   = %q{
    "Type" is key stem associated with the verb versus the
    classification.  i.e. a verb might be "classified" as "Deponent"
    but has a "type" of first conjugation e.g. miror / mirari
  }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency("linguistics_latin", "~> 1.0")
  spec.add_runtime_dependency "latinverb_deponent_string_deriver", "~> 1.0"
end
