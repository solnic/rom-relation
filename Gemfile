source :rubygems

gemspec

gem 'dm-mapper', :path => '.'

gem 'adamantium',            :git => 'https://github.com/dkubb/adamantium'
gem 'abstract_type',         :git => 'https://github.com/dkubb/abstract_type'
gem 'descendants_tracker',   :git => 'https://github.com/dkubb/descendants_tracker'
gem 'equalizer',             :git => 'https://github.com/dkubb/equalizer'
gem 'veritas',               :git => 'https://github.com/snusnu/veritas'
gem 'veritas-sql-generator', :git => 'https://github.com/dkubb/veritas-sql-generator'
gem 'veritas-do-adapter',    :git => 'https://github.com/dkubb/veritas-do-adapter'

group :test do
  gem 'do_postgres', '~> 0.10.12'
  gem 'randexp'
  gem 'ruby-graphviz'
  gem 'virtus'
end

group :development do
  gem 'devtools', :git => 'https://github.com/datamapper/devtools'
  eval File.read('Gemfile.devtools')
end
