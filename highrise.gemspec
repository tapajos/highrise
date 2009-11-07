# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{highrise}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Tapaj\303\263s", "Ken Mayer"]
  s.date = %q{2009-10-17}
  s.description = %q{
Based on the original API module from DHH, http://developer.37signals.com/highrise/, this
gem is a cleaned up, tested version of the same. Contributors have added support for tags 
which are not supported by the API directly

Configure by adding the following:

require 'highrise'
Highrise::Base.site = 'http://your_site.highrisehq.com/'
Highrise::Base.user = 'your_api_auth_token'
                          }
  s.email = %q{marcos@tapajos.me, kmayer@bitwrangler.com}
  s.files = ["README.mkdn", "VERSION.yml", "lib/cachable.rb", "lib/highrise", "lib/highrise/base.rb", "lib/highrise/comment.rb", "lib/highrise/company.rb", "lib/highrise/email.rb", "lib/highrise/group.rb", "lib/highrise/kase.rb", "lib/highrise/membership.rb", "lib/highrise/note.rb", "lib/highrise/pagination.rb", "lib/highrise/person.rb", "lib/highrise/subject.rb", "lib/highrise/tag.rb", "lib/highrise/taggable.rb", "lib/highrise/task.rb", "lib/highrise/user.rb", "lib/highrise.rb", "spec/cachable_spec.rb", "spec/highrise", "spec/highrise/base_spec.rb", "spec/highrise/comment_spec.rb", "spec/highrise/company_spec.rb", "spec/highrise/email_spec.rb", "spec/highrise/group_spec.rb", "spec/highrise/kase_spec.rb", "spec/highrise/membership_spec.rb", "spec/highrise/note_spec.rb", "spec/highrise/pagination_spec.rb", "spec/highrise/person_spec.rb", "spec/highrise/subject_spec.rb", "spec/highrise/tag_spec.rb", "spec/highrise/task_spec.rb", "spec/highrise/user_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/tapajos/highrise}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Ruby wrapper around Highrise API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activeresource>, [">= 2.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.1"])
    else
      s.add_dependency(%q<activeresource>, [">= 2.1"])
      s.add_dependency(%q<activesupport>, [">= 2.1"])
    end
  else
    s.add_dependency(%q<activeresource>, [">= 2.1"])
    s.add_dependency(%q<activesupport>, [">= 2.1"])
  end
end
