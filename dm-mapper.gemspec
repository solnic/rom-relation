# -*- encoding: utf-8 -*-
require File.expand_path('../lib/version', __FILE__)

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
end
