# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{refacebook}
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Abhi Yerra"]
  s.date = %q{2009-04-13}
  s.default_executable = %q{refacebook}
  s.description = %q{ReFacebook is a facebook library and Sinatra extension.}
  s.email = %q{abhi@traytwo.com}
  s.executables = ["refacebook"]
  s.extra_rdoc_files = [
    "README.txt"
  ]
  s.files = [
    "History.txt",
    "Manifest.txt",
    "README.txt",
    "Rakefile",
    "VERSION.yml",
    "bin/refacebook",
    "examples/example.rb",
    "lib/refacebook.rb",
    "lib/refacebook/sinatra.rb",
    "test/test_refacebook.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/abhiyerra/refacebook}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{refacebook}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{ReFacebook is a facebook library and Sinatra extension.}
  s.test_files = [
    "test/test_refacebook.rb",
    "examples/example.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json-jruby>, [">= 1.1.3"])
      s.add_runtime_dependency(%q<memcache-client>, [">= 1.7.1"])
    else
      s.add_dependency(%q<json-jruby>, [">= 1.1.3"])
      s.add_dependency(%q<memcache-client>, [">= 1.7.1"])
    end
  else
    s.add_dependency(%q<json-jruby>, [">= 1.1.3"])
    s.add_dependency(%q<memcache-client>, [">= 1.7.1"])
  end
end
