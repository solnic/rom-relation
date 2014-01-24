# encoding: utf-8

source 'https://rubygems.org'

gemspec

gem 'rom-mapper', git: 'https://github.com/rom-rb/rom-mapper.git', branch: 'master'

group :test do
  gem 'bogus', '~> 0.1'
  gem 'axiom-memory-adapter', '~> 0.2'
  gem 'rubysl-bigdecimal', platforms: :rbx
end

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git', branch: 'master'
end

# added by devtools
eval_gemfile 'Gemfile.devtools'
