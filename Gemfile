# encoding: utf-8

source 'https://rubygems.org'

gemspec

gem 'adamantium',      git: 'https://github.com/dkubb/adamantium.git', branch: 'master'
gem 'axiom',           git: 'https://github.com/dkubb/axiom.git', branch: 'master'
gem 'axiom-optimizer', git: 'https://github.com/dkubb/axiom-optimizer.git', branch: 'master'
gem 'rom-mapper',      git: 'https://github.com/rom-rb/rom-mapper.git', branch: 'master'

group :test do
  gem 'bogus', '~> 0.1'
  gem 'axiom-memory-adapter', git: 'https://github.com/dkubb/axiom-memory-adapter.git', branch: 'master'
  gem 'rubysl-bigdecimal', platforms: :rbx
end

group :development do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git', branch: 'master'
end

# added by devtools
eval_gemfile 'Gemfile.devtools'
