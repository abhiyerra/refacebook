# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{refacebook}
  s.version = "0.4.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kesava Abhinav Yerra"]
  s.date = %q{2009-07-13}
  s.description = %q{ReFacebook is a facebook library and Sinatra extension.}
  s.email = %q{abhi@traytwo.com}
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "examples/example.rb", "lib/refacebook.rb", "lib/refacebook/sinatra.rb", "spec/api_spec.rb"]
  s.homepage = %q{http://refacebook.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{refacebook}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{ReFacebook simplifies the creation of facebook apps with the use of Sinatra.}
  s.test_files = ["spec/api_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.2"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.2"])
  end
end
