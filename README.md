Description
===========

A Chef Exception & Reporting Handler for [Splunk](http://www.splunk.com).

Usage
=====

Via Cookbook (preferred)
------------------------
See the [splunk_handler](https://github.com/ampledata/cookbook-splunk_handler)
Cookbook.

Via Recipe (old, non-preferred)
-------------------------------
1. Add the [chef_handler](http://community.opscode.com/cookbooks/chef_handler)
Cookbook to a Node's Run List.
2. Given a Splunk username as USER, password as PASS, and
   host name as HOST, create a Recipe similar to the one below:

```ruby
include_recipe 'chef_handler'

gem_package('chef-handler-splunk'){action :nothing}.run_action(:install)

chef_handler 'Chef::Handler::SplunkHandler' do
  action :enable
  arguments ['username', 'password', 'host']
  source File.join(Gem.all_load_paths.grep(/chef-handler-splunk/).first,
                   'chef', 'handler', 'splunk.rb')
end
```

Source
======
* [chef-handler-splunk gem](https://github.com/ampledata/chef-handler-splunk)
* [handler_splunk Cookbook](https://github.com/ampledata/handler_splunk)

Author
======
Greg Albrecht <mailto:gba@splunk.com>

Copyright
=========
Copyright 2012 Splunk Inc.

License
=======
Apache License 2.0. See LICENSE.txt
