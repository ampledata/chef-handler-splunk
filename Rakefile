# -*- encoding: utf-8 -*-
# Rakefile for chef-handler-splunk.
#
# Source:: https://github.com/ampledata/chef-handler-splunk
# Author:: Greg Albrecht (<mailto:gba@splunk.com>)
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


$:.push File.expand_path('../lib/chef/handler', __FILE__)

require 'splunk'


task :build do
  system 'gem build chef-handler-splunk.gemspec'
end

task :release do
  system "gem push chef-handler-splunk-#{Chef::Handler::Splunk::VERSION}.gem"
end

task :test do
  system "chef-solo -c test/chef.rb -j test/chef.json -l info -L chef-solo.log"
end

task :default => :build
