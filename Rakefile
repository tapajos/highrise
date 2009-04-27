require 'rake'
require 'rubygems'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'
require "date"
require "fileutils"
require "rubygems"
require "rake/gempackagetask"

require File.join(File.dirname(__FILE__), 'lib', 'highrise', 'version')

VERSION=Highrise::VERSION::STRING

highrise_gemspec = Gem::Specification.new do |s|
  s.name             = "kmayer-highrise"
  s.version          = VERSION
  s.platform         = Gem::Platform::RUBY
  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.mkdn"]
  s.summary          = "Ruby wrapper around Highrise API"
  s.description      = %{
                        Based on the original API module from DHH, http://developer.37signals.com/highrise/, this
                        gem is a cleaned up, tested version of the same. Contributors have added support for tags 
                        which are not supported by the API directly
                        
                        Configure by adding the following:
                        
                        require 'rubygems'
                        require 'highrise'
                        Highrise::Base.site = 'http://your_api:login@your_site.highrisehq.com/'
                        }
  s.authors          = ["Marcos Tapajós", "Ken Mayer"]
  s.email            = "kmayer@bitwrangler.com"
  s.homepage         = "http://github.com/kmayer/highrise"
  s.require_path     = "lib"
  s.autorequire      = "highrise"
  s.files            = %w(README.mkdn Rakefile MIT-LICENSE spec.opts spec_helper.rb) + Dir.glob("{bin,lib,spec}/**/*")
end

Rake::GemPackageTask.new(highrise_gemspec) do |pkg|
  pkg.gem_spec = highrise_gemspec
end

namespace :gem do
  namespace :spec do
    desc "Update highrise.gemspec"
    task :generate do
      File.open("highrise.gemspec", "w") do |f|
        f.puts(highrise_gemspec.to_ruby)
      end
    end
  end
end

desc "Instal gem"
task :install => :package do
  sh %{sudo gem install --local pkg/highrise-#{VERSION}}
end

desc 'Default: run unit tests.'
task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec.opts']
end
