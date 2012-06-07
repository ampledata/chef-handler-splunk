# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib/chef/handler', __FILE__)

require 'splunk'


task :build do
  system 'gem build chef-handler-splunk.gemspec'
end

task :release do
  system "gem push chef-handler-splunk-#{Chef::Handler::Splunk::VERSION}.gem"
end

task :default => :build
