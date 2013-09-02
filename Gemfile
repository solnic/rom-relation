# encoding: utf-8

source 'https://rubygems.org'

gemspec

gem 'rom-relation', path: '.'

gem 'axiom',      git: 'https://github.com/dkubb/axiom.git', branch: 'master'
gem 'rom-mapper', git: 'https://github.com/rom-rb/rom-mapper.git'

group :test do
  gem 'bogus', '~> 0.1'
  gem 'randexp'
  gem 'ruby-graphviz'
  gem 'axiom-memory-adapter', git: 'https://github.com/dkubb/axiom-memory-adapter.git', branch: 'master'
end

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
end

# added by devtools
eval_gemfile 'Gemfile.devtools'
