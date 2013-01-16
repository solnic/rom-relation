source :rubygems

gemspec

gem 'dm-mapper', :path => '.'

gem 'adamantium', :github => 'dkubb/adamantium'

group :veritas do
  gem 'veritas',               :github => 'dkubb/veritas'
  gem 'veritas-sql-generator', :github => 'dkubb/veritas-sql-generator'
  gem 'veritas-do-adapter',    :github => 'dkubb/veritas-do-adapter'
end

group :mongo do
  gem 'mongo'
  gem 'bson_ext', :platforms => [ :mri ]
end

group :arel_engine do
  gem 'activerecord'
  gem 'arel', :github => 'rails/arel'
  gem 'pg', :platforms => :ruby

  platforms :jruby do
    gem 'activerecord-jdbcpostgresql-adapter', '>= 1.2.0'
  end
end

group :test do
  gem 'do_postgres'
  gem 'randexp'
  gem 'ruby-graphviz'
  gem 'virtus'
end

group :development do
  gem 'devtools', :github => 'datamapper/devtools'
  eval File.read('Gemfile.devtools')
end
