# Test Recipe for chef-handler-splunk.
#
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


include_recipe 'chef_handler'


gem_wc = File.join(File.dirname(__FILE__), '..', '..', '..', '*.gem')
gem = Dir.glob(File.expand_path(gem_wc)).last

Chef::Log.info("gem=#{gem}")


gem_package 'chef-handler-splunk' do
  action :nothing
  source gem
end.run_action(:upgrade)


chef_handler 'Chef::Handler::Splunk' do
  action :enable
  arguments ['admin', 'xxx', 'splunk.example.com']
  source File.join(Gem.all_load_paths.grep(/chef-handler-splunk/).first,
                   'chef', 'handler', 'splunk.rb')
end


# Enable to fail.
#directory '/good_luck' do
#  owner 'root'
#end
