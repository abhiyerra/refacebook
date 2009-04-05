# -*- encoding: utf-8 -*-

require 'rake'

Gem::Specification.new do |s|
  s.name = "refacebook"
  s.version = "0.2.1"

  s.authors = ["Abhi Yerra"]
  s.description = %q{ReFacebook is a small facebook library tailored toward usage with Sinatra.}
  s.email = "abhi@traytwo.com"
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*', 'examples/**/*'].to_a
  s.has_rdoc = true
  s.homepage = "http://github.com/abhiyerra/refacebook"
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  # s.rubyforge_project = %q{refacebook}
  s.summary = "ReFacebook is a small facebook library tailored toward usage with Sinatra."

  s.add_dependency("json", [">= 1.1.4"])
end
