# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = "refacebook"
  s.version = "0.3.2"

  s.authors = ["Abhi Yerra"]
  s.description = %q{ReFacebook is a facebook library and Sinatra extension.}
  s.email = "abhi@traytwo.com"
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*', 'examples/**/*'].to_a
  s.has_rdoc = true
  s.homepage = "http://github.com/abhiyerra/refacebook"
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "refacebook"
  s.summary = "ReFacebook is a facebook library and Sinatra extension."

  if defined?(JRUBY_VERSION)
    s.add_dependency("json-jruby", [">= 1.1.3"])
  else
    s.add_dependency("json", [">= 1.1.4"])
  end
  s.add_dependency("memcache-client", [">= 1.7.1"])
end
