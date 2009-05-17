# Caching is a way to speed up slow ActiveResource queries by keeping the result of
# a request around to be reused by subsequent requests. 
# 
# Caching is turned OFF by default.
#
# == Usage
# 
#   require 'cachable'
# 
#   module CachedResource
#     class Base < ActiveResource::Base
#     end
#     class ActiveResource::Connection
#       include Cachable
#     end
#   end
#
#
# == Caching stores
#
# All the caching stores from ActiveSupport::Cache are available
# as backends for caching. See the Rails rdoc for more information on
# these stores
#
# Configuration examples ('off' is the default):
#
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :memory_store
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :file_store, "/path/to/cache/directory"
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :drb_store, "druby://localhost:9192"
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :mem_cache_store, "localhost"
#   CachedResource.connection.cache_store = MyOwnStore.new("parameter")
#
# Note: To ensure that caching is turned off, set CachedResource.connection.cache_store = nil
#
# FYI: You can use this with *any* active resource interface, not just Highrise.

module Cachable
  def self.included(base)
    base.class_eval do
      include InstanceMethods
      alias_method_chain :get, :cache
    end
  end

  module InstanceMethods
    def cache_store
      @cache_store ||= nil
    end

    def cache_store=(store_option)
      @cache_store = store_option
    end

    def is_caching?
      !@cache_store.nil?
    end

  private

    def get_with_cache(path, headers = {})
      return get_without_cache(path, headers) unless is_caching?
      fetch(path) { get_without_cache(path, headers) }
    end

    def cache_key(*args)
      args.to_s
    end

    def fetch(args, &block)
      cache_store.fetch(cache_key(args), &block).dup
    end
  end
end
