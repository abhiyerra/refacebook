require 'rubygems'
require 'fileutils'
begin
    require 'spec/rake/spectask'
rescue LoadError
    puts 'To use rspec for testing you must install rspec gem:'
    puts '$ sudo gem install rspec'
    exit
end
require 'hoe'
require './lib/refacebook'

desc "Runnings the specs"
Spec::Rake::SpecTask.new do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Generate teh Manifest and gemspec"
task :cultivate do
    system "touch Manifest.txt; rake check_manifest | grep -v \"(in \" | patch"
    system "rake debug_gem | grep -v \"(in \" > `basename \\`pwd\\``.gemspec"
end


Hoe.spec('refacebook') do |p|
    p.version = ReFacebook::VERSION
    p.author = "Kesava Abhinav Yerra"
    p.email = "abhi@traytwo.com"
    p.summary = "ReFacebook simplifies the creation of facebook apps with the use of Sinatra."
    p.test_globs = FileList["{spec}/**/*.rb"].to_a
end
