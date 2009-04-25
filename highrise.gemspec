# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{highrise}
  s.version = "0.6.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Tapaj\303\263s"]
  s.autorequire = %q{highrise}
  s.date = %q{2009-01-14}
  s.description = %q{Find awesome stuff}
  s.email = %q{tapajos@improveit.com.br}
  s.extra_rdoc_files = ["README.mkdn"]
  s.files = ["README.mkdn", "Rakefile", "lib/highrise", "lib/highrise/base.rb", "lib/highrise/comment.rb", "lib/highrise/company.rb", "lib/highrise/curlhelper.rb", "lib/highrise/curly.rb", "lib/highrise/email.rb", "lib/highrise/group.rb", "lib/highrise/kase.rb", "lib/highrise/membership.rb", "lib/highrise/note.rb", "lib/highrise/pagination.rb", "lib/highrise/person.rb", "lib/highrise/subject.rb", "lib/highrise/tag.rb", "lib/highrise/taggable.rb", "lib/highrise/task.rb", "lib/highrise/user.rb", "lib/highrise.rb", "spec/highrise", "spec/highrise/base_spec.rb", "spec/highrise/comment_spec.rb", "spec/highrise/companies/16883216.html", "spec/highrise/company_spec.rb", "spec/highrise/curlhelper_spec.rb", "spec/highrise/curly_spec.rb", "spec/highrise/email_spec.rb", "spec/highrise/group_spec.rb", "spec/highrise/kase_spec.rb", "spec/highrise/membership_spec.rb", "spec/highrise/note_spec.rb", "spec/highrise/pagination_spec.rb", "spec/highrise/people/16887003.html", "spec/highrise/person_spec.rb", "spec/highrise/subject_spec.rb", "spec/highrise/task_spec.rb", "spec/highrise/user_spec.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://www.improveit.com.br/en/company/tapajos}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Find awesome stuff}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
