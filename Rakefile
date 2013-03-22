# encoding: utf-8

require 'devtools'

Devtools.init_rake_tasks

require 'rspec/core/rake_task'

namespace :spec do

  desc 'Run isolation specs'
  RSpec::Core::RakeTask.new(:isolation) do |t|
    t.pattern = 'spec/isolation/**/*_spec.rb'
  end

  task :integration => 'spec:isolation'
end
