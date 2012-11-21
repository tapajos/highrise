require 'bundler'
Bundler.setup

require File.join(File.dirname(__FILE__), '/../lib/highrise')

Highrise::Base.user        = ENV['HIGHRISE_USER']    || 'x'
Highrise::Base.oauth_token = ENV['HIGHRISE_TOKEN']   || 'TOKEN'
Highrise::Base.site        = ENV['HIGHRISE_SITE']    || 'https://www.example.com'

require 'highrise/pagination_behavior'
require 'highrise/searchable_behavior'
require 'highrise/taggable_behavior'
