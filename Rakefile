# encoding: utf-8

require 'rspec/core/rake_task'

desc 'Default: run unit tests.'
task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
end
