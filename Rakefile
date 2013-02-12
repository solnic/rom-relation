# encoding: utf-8

require 'devtools'

Devtools.init

require 'rspec/core/rake_task'

namespace :spec do

  desc "Run isolation specs"
  RSpec::Core::RakeTask.new(:isolation) do |t|
    t.pattern = 'spec/isolation/**/*_spec.rb'
  end

  desc "Run all specs on travis"
  task :travis => %w(spec:unit spec:integration spec:isolation)
end
