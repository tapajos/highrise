# encoding: utf-8

require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
end
