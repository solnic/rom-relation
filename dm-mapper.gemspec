# -*- encoding: utf-8 -*-
require File.expand_path('../lib/data_mapper/mapper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "dm-mapper"
  gem.description   = "dm-mapper"
  gem.summary       = "dm-mapper"
  gem.authors       = 'Piotr Solnica'
  gem.email         = 'piotr.solnica@gmail.com'
  gem.homepage      = 'http://datamapper.org'
  gem.require_paths = [ "lib" ]
  gem.version       = DataMapper::Mapper::VERSION
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")

  gem.add_dependency 'addressable',         '~> 2.3'
  gem.add_dependency 'equalizer',           '~> 0.0.1'
  gem.add_dependency 'descendants_tracker', '~> 0.0.1'
  gem.add_dependency 'abstract_type',       '~> 0.0.2'
  gem.add_dependency 'inflecto',            '~> 0.0.2'
  gem.add_dependency 'adamantium',          '~> 0.0.4'
end
