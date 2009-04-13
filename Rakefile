# -*- ruby -*-

require 'rubygems'
require './lib/refacebook.rb'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "refacebook"
    gemspec.summary = "ReFacebook is a facebook library and Sinatra extension."
    gemspec.email = "abhi@traytwo.com"
    gemspec.homepage = "http://github.com/abhiyerra/refacebook"
    gemspec.description = "ReFacebook is a facebook library and Sinatra extension."
    gemspec.authors = ["Abhi Yerra"]
    gemspec.rubyforge_project = "refacebook"

    if defined?(JRUBY_VERSION)
      gemspec.add_dependency("json-jruby", [">= 1.1.3"])
    else
      gemspec.add_dependency("json", [">= 1.1.4"])
    end

    gemspec.add_dependency("memcache-client", [">= 1.7.1"])
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do

    desc "Release gem and RDoc documentation to RubyForge"
    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]

    namespace :release do
      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = "/var/www/gforge-projects/the-perfect-gem/"
        local_dir = 'rdoc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end

# vim: syntax=Ruby
