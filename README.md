Description
===========

A Chef Exception & Reporting Handler for [Splunk](http://www.splunk.com).

Usage
=====

1. Download and Install [Splunk](http://www.splunk.com/download).
2. Download the [chef_handler](http://community.opscode.com/cookbooks/chef_handler)
Cookbook.
3. Given your Splunk username as USER, Splunk password as PASS, and
   Splunk host as HOST, create a Recipe similar to the one below:

```ruby
include_recipe 'chef_handler'

gem_package('chef-handler-splunk'){action :nothing}.run_action(:install)

chef_handler 'Chef::Handler::Splunk' do
  action :enable
  arguments ['username', 'password', 'host']
  source File.join(Gem.all_load_paths.grep(/chef-handler-splunk/).first,
                   'chef', 'handler', 'splunk.rb')
end
```

See also: [Enable Chef Handler with LWRP](http://wiki.opscode.com/display/chef/Distributing+Chef+Handlers#DistributingChefHandlers-EnabletheChefHandlerwiththe%7B%7Bchefhandler%7D%7DLWRP)

Author
======
Greg Albrecht <gba@splunk.com>


Copyright
=========
Copyright 2012 Splunk Inc.

License
=======
Apache License 2.0. Please see LICENSE.
