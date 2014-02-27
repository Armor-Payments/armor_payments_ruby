# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'armor_payments/version'

Gem::Specification.new do |spec|
  spec.name          = "armor_payments"
  spec.version       = ArmorPayments::VERSION
  spec.authors       = ["Matt Wilson"]
  spec.email         = ["mhw@hypomodern.com"]
  spec.description   = 'Ruby gem for interacting with Armor Payments.'
  spec.summary       = 'Ruby gem for interacting with Armor Payments.'
  spec.homepage      = "http://github.com/hypomodern/armor_payments"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.3"
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'timecop'

  spec.add_dependency 'excon'
end
