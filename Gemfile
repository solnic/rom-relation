source 'https://rubygems.org'

gemspec

gem 'rom-relation', :path => '.'

gem 'adamantium',            :git => 'https://github.com/dkubb/adamantium.git'
gem 'abstract_type',         :git => 'https://github.com/dkubb/abstract_type.git'
gem 'descendants_tracker',   :git => 'https://github.com/dkubb/descendants_tracker.git'
gem 'equalizer',             :git => 'https://github.com/dkubb/equalizer.git'
gem 'axiom',                 :git => 'https://github.com/dkubb/axiom.git'
gem 'axiom-sql-generator',   :git => 'https://github.com/dkubb/axiom-sql-generator.git'
gem 'axiom-do-adapter',      :git => 'https://github.com/dkubb/axiom-do-adapter.git'

group :test do
  gem 'do_postgres', '~> 0.10.12'
  gem 'do_sqlite3'
  gem 'randexp'
  gem 'ruby-graphviz'
  gem 'bogus', '~> 0.0.4'
end

group :development do
  gem 'devtools', :git => 'https://github.com/rom-rb/devtools.git'
  eval File.read('Gemfile.devtools')
end
