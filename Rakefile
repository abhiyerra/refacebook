# -*- ruby -*-

require 'rubygems'
require 'rake/rdoctask'

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

    # Should use json-jruby if using JRuby
    gemspec.add_dependency("json-jruby", [">= 1.1.3"])
    gemspec.add_dependency("json", [">= 1.1.4"])
    gemspec.add_dependency("memcache-client", [">= 1.7.1"])
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

desc 'Generate documentation.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'ReFacebook'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.*')
  rdoc.rdoc_files.include('lib/**/*.rb')
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
        remote_dir = "/var/www/gforge-projects/refacebook/"
        local_dir = 'doc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end

begin
  require 'spec/rake/spectask'
rescue LoadError
  puts 'To use rspec for testing you must install rspec gem:'
  puts '$ sudo gem install rspec'
  exit
end

desc "Runnings the specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :default => :spec
# vim: syntax=Ruby
