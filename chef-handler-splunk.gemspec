# -*- encoding: utf-8 -*-
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
  s.homepage = 'http://ampledata.org/splunk_chef_handler.html'
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md) + Dir.glob('lib/**/*')
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'rest-client'
end
