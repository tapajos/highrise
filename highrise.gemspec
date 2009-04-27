# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kmayer-highrise}
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Tapaj\303\263s", "Ken Mayer"]
  s.autorequire = %q{highrise}
  s.date = %q{2009-04-27}
  s.description = %q{
                        Based on the original API module from DHH, http://developer.37signals.com/highrise/, this
                        gem is a cleaned up, tested version of the same. Contributors have added support for tags 
                        which are not supported by the API directly
                        
                        Configure by adding the following:
                        
                        require 'rubygems'
                        require 'highrise'
                        Highrise::Base.site = 'http://your_api:login@your_site.highrisehq.com/'
                        }
  s.email = %q{kmayer@bitwrangler.com}
  s.extra_rdoc_files = ["README.mkdn"]
  s.files = ["README.mkdn", "Rakefile", "MIT-LICENSE", "spec.opts", "spec_helper.rb", "lib/highrise", "lib/highrise/base.rb", "lib/highrise/comment.rb", "lib/highrise/company.rb", "lib/highrise/curlhelper.rb", "lib/highrise/curly.rb", "lib/highrise/email.rb", "lib/highrise/group.rb", "lib/highrise/kase.rb", "lib/highrise/membership.rb", "lib/highrise/note.rb", "lib/highrise/pagination.rb", "lib/highrise/person.rb", "lib/highrise/subject.rb", "lib/highrise/tag.rb", "lib/highrise/taggable.rb", "lib/highrise/task.rb", "lib/highrise/user.rb", "lib/highrise/version.rb", "lib/highrise.rb", "spec/highrise", "spec/highrise/base_spec.rb", "spec/highrise/comment_spec.rb", "spec/highrise/companies", "spec/highrise/companies/16883216.html", "spec/highrise/company_spec.rb", "spec/highrise/curlhelper_spec.rb", "spec/highrise/curly_spec.rb", "spec/highrise/email_spec.rb", "spec/highrise/group_spec.rb", "spec/highrise/kase_spec.rb", "spec/highrise/membership_spec.rb", "spec/highrise/note_spec.rb", "spec/highrise/pagination_spec.rb", "spec/highrise/people", "spec/highrise/people/16887003.html", "spec/highrise/person_spec.rb", "spec/highrise/subject_spec.rb", "spec/highrise/tag_spec.rb", "spec/highrise/task_spec.rb", "spec/highrise/user_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/kmayer/highrise}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Ruby wrapper around Highrise API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
