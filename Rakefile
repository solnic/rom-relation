# encoding: utf-8

require 'devtools'

Devtools.init

require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new(:isolation) do |t|
    t.pattern = 'spec/isolation/**/*_spec.rb'
  end

  RSpec::Core::RakeTask.new(:arel) do |t|
    ENV['ENGINE'] = 'Arel'
    t.pattern = 'spec/arel/**/*_spec.rb'
  end

  desc "Run specs on travis"
  task :travis => %w(spec:unit spec:integration spec:isolation spec:arel)
end
