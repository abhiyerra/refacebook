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

# vim: syntax=Ruby
