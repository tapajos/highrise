# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "highrise/version"

Gem::Specification.new do |s|
  s.name        = "highrise"
  s.version     = Highrise::VERSION
  s.platform    = Gem::Platform::RUBY

  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency "activeresource", "~>3.0.0"
  s.add_development_dependency "rspec", "~>2.0.1"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features,examples}/*`.split("\n")
  s.require_paths = ["lib"]

  s.authors       = ["Marcos Tapaj\303\263s", "Ken Mayer"]
  s.email         = ["marcos@tapajos.me", "kmayer@bitwrangler.com"]
  s.homepage      = "http://github.com/tapajos/highrise"
  s.summary       = %q{Ruby wrapper around Highrise API}
  s.description   = <<-EOT
    Based on the original API module from DHH, http://developer.37signals.com/highrise/, this
    gem is a cleaned up, tested version of the same. 

    Configure by adding the following:

    require 'highrise'
    Highrise::Base.site = 'http://your_site.highrisehq.com/'
    Highrise::Base.user = 'your_api_auth_token'
  EOT
end
