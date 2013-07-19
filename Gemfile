source 'https://rubygems.org'

gemspec

gem 'rom-relation', :path => '.'

group :test do
  gem 'bogus', '~> 0.1'
  gem 'randexp'
  gem 'ruby-graphviz'
  gem 'rom-mapper',           :git => 'https://github.com/rom-rb/rom-mapper.git'
  gem 'axiom-memory-adapter', :git => 'https://github.com/dkubb/axiom-memory-adapter.git', :branch => 'gateway'
end

group :development do
  gem 'devtools', :git => 'https://github.com/rom-rb/devtools.git'
  eval File.read('Gemfile.devtools')
end
