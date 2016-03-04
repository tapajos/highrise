# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "highrise/version"

Gem::Specification.new do |s|
  s.name        = "highrise"
  s.version     = Highrise::VERSION
  s.platform    = Gem::Platform::RUBY

  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency "activeresource", ">= 3.2.13"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  s.files         = [".gitignore", ".ruby-version", ".travis.yml", "Gemfile", "Gemfile.lock", "MIT-LICENSE", "README.md", "Rakefile", "autotest/discover.rb", "certs/gem-public_cert.pem", "examples/config_initializers_highrise.rb", "examples/extending.rb", "examples/sample.rb", "highrise.gemspec", "highrise.gemspec.erb", "lib/highrise.rb", "lib/highrise/account.rb", "lib/highrise/base.rb", "lib/highrise/comment.rb", "lib/highrise/company.rb", "lib/highrise/custom_fields", "lib/highrise/deal.rb", "lib/highrise/deal_category.rb", "lib/highrise/email.rb", "lib/highrise/group.rb", "lib/highrise/kase.rb", "lib/highrise/membership.rb", "lib/highrise/note.rb", "lib/highrise/pagination.rb", "lib/highrise/party.rb", "lib/highrise/person.rb", "lib/highrise/recording.rb", "lib/highrise/searchable.rb", "lib/highrise/subject.rb", "lib/highrise/subject_data.rb", "lib/highrise/subject_field.rb", "lib/highrise/tag.rb", "lib/highrise/taggable.rb", "lib/highrise/task.rb", "lib/highrise/task_category.rb", "lib/highrise/user.rb", "lib/highrise/version.rb", "spec/highrise/account_spec.rb", "spec/highrise/base_spec.rb", "spec/highrise/comment_spec.rb", "spec/highrise/company_spec.rb", "spec/highrise/deal_category_spec.rb", "spec/highrise/deal_spec.rb", "spec/highrise/email_spec.rb", "spec/highrise/group_spec.rb", "spec/highrise/kase_spec.rb", "spec/highrise/membership_spec.rb", "spec/highrise/note_spec.rb", "spec/highrise/pagination_behavior.rb", "spec/highrise/pagination_spec.rb", "spec/highrise/party_spec.rb", "spec/highrise/person_spec.rb", "spec/highrise/recording_spec.rb", "spec/highrise/searchable_behavior.rb", "spec/highrise/searchable_spec.rb", "spec/highrise/subject_data_spec.rb", "spec/highrise/subject_field_spec.rb", "spec/highrise/subject_spec.rb", "spec/highrise/tag_spec.rb", "spec/highrise/taggable_behavior.rb", "spec/highrise/taggable_spec.rb", "spec/highrise/task_category_spec.rb", "spec/highrise/task_spec.rb", "spec/highrise/user_spec.rb", "spec/spec_helper.rb"]
  s.test_files    = ["examples/config_initializers_highrise.rb", "examples/extending.rb", "examples/sample.rb", "spec/highrise/account_spec.rb", "spec/highrise/base_spec.rb", "spec/highrise/comment_spec.rb", "spec/highrise/company_spec.rb", "spec/highrise/deal_category_spec.rb", "spec/highrise/deal_spec.rb", "spec/highrise/email_spec.rb", "spec/highrise/group_spec.rb", "spec/highrise/kase_spec.rb", "spec/highrise/membership_spec.rb", "spec/highrise/note_spec.rb", "spec/highrise/pagination_behavior.rb", "spec/highrise/pagination_spec.rb", "spec/highrise/party_spec.rb", "spec/highrise/person_spec.rb", "spec/highrise/recording_spec.rb", "spec/highrise/searchable_behavior.rb", "spec/highrise/searchable_spec.rb", "spec/highrise/subject_data_spec.rb", "spec/highrise/subject_field_spec.rb", "spec/highrise/subject_spec.rb", "spec/highrise/tag_spec.rb", "spec/highrise/taggable_behavior.rb", "spec/highrise/taggable_spec.rb", "spec/highrise/task_category_spec.rb", "spec/highrise/task_spec.rb", "spec/highrise/user_spec.rb", "spec/spec_helper.rb"]
  s.require_paths = ["lib"]

  s.authors       = ["Marcos Tapaj\303\263s", "Ken Mayer"]
  s.email         = ["marcos@tapajos.me", "kmayer@bitwrangler.com"]
  s.homepage      = "http://github.com/tapajos/highrise"
  s.summary       = "Ruby wrapper around Highrise API"
  s.description   = <<-EOT
    Based on the original API module from DHH, http://developer.37signals.com/highrise/, this
    gem is a cleaned up, tested version of the same. 

    Configure by adding the following:

    require 'highrise'
    Highrise::Base.site = 'http://your_site.highrisehq.com/'
    Highrise::Base.user = 'your_api_auth_token'
  EOT

end