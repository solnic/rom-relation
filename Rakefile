# encoding: utf-8

require 'devtools'

Devtools.init

require 'rspec/core/rake_task'

namespace :spec do
  %w(in_memory veritas arel mongo).each do |engine|
    RSpec::Core::RakeTask.new(engine) do |t|
      ENV['ENGINE'] = engine
      t.pattern = "spec/integration/#{engine}/*_spec.rb"
    end
  end

  desc "Run integration specs for all engines"
  task :engines => %w(spec:in_memory spec:arel spec:veritas spec:mongo)

  desc "Run isolation specs"
  RSpec::Core::RakeTask.new(:isolation) do |t|
    ENV['ENGINE'] = 'veritas'
    t.pattern = 'spec/isolation/**/*_spec.rb'
  end

  desc "Run specs on travis"
  task :travis => %w(spec:unit spec:engines spec:isolation)
end
