require 'rake'
require 'rubygems'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'
require "date"
require "fileutils"
require "rubygems"
require "rake/gempackagetask"

VERSION = "0.6.3"

highrise_gemspec = Gem::Specification.new do |s|
  s.name             = "highrise"
  s.version          = VERSION
  s.platform         = Gem::Platform::RUBY
  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.mkdn"]
  s.summary          = "Find awesome stuff"
  s.description      = s.summary
  s.authors          = ["Marcos Tapajós"]
  s.email            = "tapajos@improveit.com.br"
  s.homepage         = "http://www.improveit.com.br/en/company/tapajos"
  s.require_path     = "lib"
  s.autorequire      = "highrise"
  s.files            = %w(README.mkdn Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
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
