source 'https://rubygems.org'

gemspec

gem 'dm-mapper', :path => '.'

gem 'adamantium',            :git => 'https://github.com/dkubb/adamantium.git'
gem 'abstract_type',         :git => 'https://github.com/dkubb/abstract_type.git'
gem 'descendants_tracker',   :git => 'https://github.com/dkubb/descendants_tracker.git'
gem 'equalizer',             :git => 'https://github.com/dkubb/equalizer.git'
gem 'veritas',               :git => 'https://github.com/dkubb/veritas.git'
gem 'veritas-sql-generator', :git => 'https://github.com/dkubb/veritas-sql-generator.git'
gem 'veritas-do-adapter',    :git => 'https://github.com/dkubb/veritas-do-adapter.git'

group :test do
  gem 'do_postgres', '~> 0.10.12'
  gem 'randexp'
  gem 'ruby-graphviz'
  gem 'virtus'
end

group :development do
  gem 'devtools', :git => 'https://github.com/datamapper/devtools.git'
  eval File.read('Gemfile.devtools')
end
