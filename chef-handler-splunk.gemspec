# -*- encoding: utf-8 -*-
# Gemspec for chef-handler-splunk.
#
# Source:: https://github.com/ampledata/chef-handler-splunk
# Author:: Greg Albrecht (<mailto:gba@splunk.com>)
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


$:.push File.expand_path('../lib/chef/handler', __FILE__)


require 'splunk'


Gem::Specification.new do |s|
  s.name = 'chef-handler-splunk'
  s.version = Chef::Handler::Splunk::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = 'Chef Exception & Reporting Handler for Splunk.'
  s.description = [
    'Allows searching and reporting of Chef run',
    'metrics from Splunk.'].join(' ')
  s.author = 'Greg Albrecht'
  s.email = 'gba@splunk.com'
  s.homepage = 'https://github.com/ampledata/chef-handler-splunk'
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md) + Dir.glob('lib/**/*')
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'rest-client'
end
