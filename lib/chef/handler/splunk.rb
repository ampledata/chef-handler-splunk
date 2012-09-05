#!/usr/bin/env ruby
# Chef Exception & Reporting Handler for Splunk.
#
# Source:: https://github.com/ampledata/chef-handler-splunk
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0.
#


require 'rubygems'
require 'chef/handler'
require 'json'
require 'rest-client'


class Chef
  class Handler
    class SplunkHandler < Chef::Handler
      VERSION = '2.0.0'
      API_ENDPOINT = 'services/receivers/simple'

      # * *Args*:
      #   - +username+ -> Splunk Username.
      #   - +password+ -> Splunk Password.
      #   - +host+ -> Splunk Host.
      #   - +port+ -> Splunk's splunkd port. Default: '8089'.
      #   - +index+ -> Splunk index. Default: 'main'.
      #   - +scheme+ -> Splunk's splunkd protocol scheme. Default: 'https'.
      #
      def initialize(username, password, host, port='8089', index='main',
                     scheme='https')
        @username = username
        @password = password
        @splunk_url = URI::HTTP.new(
          scheme, nil, host, port, nil, nil, nil, nil, nil).to_s
        @index = index
      end

      # Reports metrics to Splunk.
      def report_metrics
        metadata = {
          :sourcetype => 'json',
          :source => 'chef-handler',
          :host => node.hostname,
          :index => @index
        }

        # We're creating a new Hash b/c 'node' and 'all_resources' in run_status
        # are just TOO large.
        event = {
          :failed => run_status.failed?,
          :start_time => run_status.start_time,
          :end_time => run_status.end_time,
          :elapsed_time => run_status.elapsed_time,
          :exception => run_status.formatted_exception
        }.to_json

        splunk_post(event, metadata)
      end

      # Reports metrics to Splunk.
      def report_resources
        metadata = {
          :sourcetype => 'json_chef-resources',
          :source => 'chef-handler',
          :host => node.hostname,
          :index => @index
        }
        event = run_status.updated_resources.to_json

        splunk_post(event, metadata)
      end

      # Report Exception backtraces to Splunk.
      def report_backtrace
        metadata = {
          :sourcetype => 'chef-handler-backtrace',
          :source => 'chef-handler',
          :host => node.hostname,
          :index => @index
        }
        event = Array(run_status.backtrace).join("\n")

        splunk_post(event, metadata)
      end

      # Wrapper for metrics and backtrace.
      def report
        report_metrics
        report_resources
        if run_status.failed?
          report_backtrace
        end
      end

      # * *Args*:
      #   - +event+ -> Event to send to Splunk.
      #   - +metadata+ -> Metadata associated with Event, also sent to Splunk.
      #
      private
      def splunk_post(event, metadata)
        api_params = metadata.collect{ |k,v| [k, v].join('=') }.join('&')
        url_params = URI.escape(api_params)
        endpoint_path = [API_ENDPOINT, url_params].join('?')

        request = RestClient::Resource.new(
          @splunk_url, :user => @username, :password => @password)

        request[endpoint_path].post(event)
      end
    end
  end
end
