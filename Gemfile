source :rubygems

gemspec

gem 'dm-mapper', :path => '.'

gem 'rake'
gem 'inflector',             :github => 'mbj/inflector'

gem 'veritas',               :github => 'dkubb/veritas'
gem 'veritas-sql-generator', :github => 'dkubb/veritas-sql-generator'
gem 'veritas-do-adapter',    :github => 'dkubb/veritas-do-adapter'
gem 'virtus'

group :arel_engine do
  gem 'activerecord'
  gem 'pg', :platforms => :ruby

  platforms :jruby do
    gem 'activerecord-jdbcpostgresql-adapter', '>= 1.2.0'
  end
end

group :test do
  gem 'backports'
  gem 'do_postgres'
  gem 'do_mysql'
  gem 'do_sqlite3'
  gem 'randexp'
  gem 'rspec', '1.3.2'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'ruby-graphviz'
end

group :metrics do
  gem 'fattr',       '~> 2.2.0'
  gem 'arrayfields', '~> 4.7.4'
  gem 'flay',        '~> 1.4.2'
  gem 'flog',        '~> 2.5.1'
  gem 'map',         '~> 5.2.0'
  gem 'reek',        '~> 1.2.8', :github => 'dkubb/reek'
  gem 'roodi',       '~> 2.1.0'
  gem 'yardstick',   '~> 0.7.0'

  # Needed for yard
  gem 'redcarpet'

  platforms :mri_18 do
    gem 'heckle',    '~> 1.4.3'
    gem 'json',      '~> 1.7'
    gem 'metric_fu', '~> 2.1.1'
    gem 'mspec',     '~> 1.5.17'
    gem 'rcov',      '~> 1.0'
    gem 'ruby2ruby', '=  1.2.2'
  end

  platforms :rbx do
    gem 'pelusa', :github => 'codegram/pelusa'
  end
end
