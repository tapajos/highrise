# encoding: utf-8

gem 'rspec', ">= 1.3.0"
require 'spec/rake/spectask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "highrise"
    gemspec.summary = "Ruby wrapper around Highrise API"
    gemspec.email = ["marcos@tapajos.me", "kmayer@bitwrangler.com"]
    gemspec.homepage = "http://github.com/tapajos/highrise"
    gemspec.description = %{
Based on the original API module from DHH, http://developer.37signals.com/highrise/, this
gem is a cleaned up, tested version of the same. Contributors have added support for tags 
which are not supported by the API directly

Configure by adding the following:

require 'highrise'
Highrise::Base.site = 'http://your_site.highrisehq.com/'
Highrise::Base.user = 'your_api_auth_token'
                          }
    gemspec.authors = ["Marcos Tapajós", "Ken Mayer"]
    gemspec.add_dependency('activeresource', '>= 2.1')
    gemspec.add_dependency('activesupport', '>= 2.1')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler -s http://gems.github.com"
end

desc 'Default: run unit tests.'
task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
end
