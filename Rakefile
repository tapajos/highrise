# encoding: utf-8
require 'bundler'
Bundler::GemHelper.install_tasks if File.exist? 'highrise.gemspec'

require 'rspec/core/rake_task'
require 'erb'

desc 'Default: run unit tests.'
task :default => :spec

desc "Run all specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ["-c", "-f progress"]
end

desc 'Generate gemspec'
task :gemspec do
	gemspec = 'highrise.gemspec'
	
	#FileUtils.rm gemspec if File.exist? gemspec
	template = ERB.new File.new("#{gemspec}.erb").read
	
	begin
		gemspec_file = File.open(gemspec,'w')
		gemspec_file.write template.result(binding)	
	ensure
		gemspec_file.close
	end
	
	puts "done!"
end