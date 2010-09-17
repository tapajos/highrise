lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler'
require 'highrise/version'

Gem::Specification.new do |s|
  s.add_bundler_dependencies
  s.name = %q{highrise}
  s.version = Highrise::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Marcos Tapaj\303\263s", "Ken Mayer"]
  s.email = ["marcos@tapajos.me", "kmayer@bitwrangler.com"]
  s.homepage = %q{http://github.com/tapajos/highrise}
  s.summary = %q{Ruby wrapper around Highrise API}
  s.description = %q{
Based on the original API module from DHH, http://developer.37signals.com/highrise/, this
gem is a cleaned up, tested version of the same. Contributors have added support for tags 
which are not supported by the API directly

Configure by adding the following:

require 'highrise'
Highrise::Base.site = 'http://your_site.highrisehq.com/'
Highrise::Base.user = 'your_api_auth_token'
}
  s.required_rubygems_version = ">= 1.3.6"
  s.add_development_dependency "rspec"

  s.files=  `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features,examples}/*`.split("\n")
  s.require_paths = ["lib"]
end

