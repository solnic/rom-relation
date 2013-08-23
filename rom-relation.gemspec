# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rom/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'rom-relation'
  gem.summary       = 'Relation schema with mapping for ROM'
  gem.description   = gem.summary
  gem.authors       = 'Piotr Solnica'
  gem.email         = 'piotr.solnica@gmail.com'
  gem.homepage      = 'http://rom-rb.org'
  gem.require_paths = ['lib']
  gem.version       = ROM::Relation::VERSION
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.license       = 'MIT'

  gem.add_dependency 'addressable',         '~> 2.3', '>= 2.3.3'
  gem.add_dependency 'concord',             '~> 0.1.4'
  gem.add_dependency 'equalizer',           '~> 0.0.7'
  gem.add_dependency 'descendants_tracker', '~> 0.0.1'
  gem.add_dependency 'abstract_type',       '~> 0.0.6'
  gem.add_dependency 'adamantium',          '~> 0.1'
  gem.add_dependency 'axiom',               '~> 0.1.1'
  gem.add_dependency 'axiom-optimizer',     '~> 0.1.0'
end
