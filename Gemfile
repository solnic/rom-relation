source :rubygems

gem 'dm-mapper', :path => '.'

gem 'rake'
gem 'veritas',               :github => 'dkubb/veritas'
gem 'veritas-sql-generator', :github => 'dkubb/veritas-sql-generator'
gem 'veritas-optimizer',     :github => 'dkubb/veritas-optimizer'
gem 'veritas-do-adapter',    :path => '../veritas-do-adapter'
gem 'virtus'
gem 'descendants_tracker',   :github => 'dkubb/descendants_tracker'
gem 'equalizer',             :github => 'dkubb/equalizer'

group :test do
  gem 'backports'
  gem 'do_postgres'
  gem 'do_mysql'
  gem 'do_sqlite3'
  gem 'randexp'
  gem 'rspec', '1.3.1'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end

group :metrics do
  gem 'fattr',       '~> 2.2.0'
  gem 'arrayfields', '~> 4.7.4'
  gem 'flay',        '~> 1.4.2'
  gem 'flog',        '~> 2.5.1'
  gem 'map',         '~> 5.2.0'
  gem 'reek',        '~> 1.2.8', :git => 'git://github.com/dkubb/reek.git'
  gem 'roodi',       '~> 2.1.0'
  gem 'yardstick',   '~> 0.4.0'

  platforms :mri_18 do
    gem 'heckle',    '~> 1.4.3'
    gem 'json',      '~> 1.7'
    gem 'metric_fu', '~> 2.1.1'
    gem 'mspec',     '~> 1.5.17'
    gem 'rcov',      '~> 1.0'
    gem 'ruby2ruby', '=  1.2.2'
  end

  platforms :rbx do
    gem 'pelusa', :git => 'https://github.com/codegram/pelusa.git'
  end
end
