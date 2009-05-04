require 'digest/sha1'

# Caching is a way to speed up slow ActiveResource queries by keeping the result of
# an ActiveResource request around to be reused by subequest requests. Caching is
# turned off by default.
#
# == Usage
# 
#   require 'cachable'
# 
#   module CachedResource
#     class Base < ActiveResource::Base
#     end
#     include Cachable
#   end
#
# == Caching stores
#
# All the caching stores from ActiveSupport::Cache are available
# as backends for caching. See the Rails rdoc for more information on
# these stores
#
# Configuration examples ('off' is the default):
#
#   CachedResource.connection.cache_store = :memory_store
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :file_store, "/path/to/cache/directory"
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :drb_store, "druby://localhost:9192"
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :mem_cache_store, "localhost"
#   CachedResource.connection.cache_store = MyOwnStore.new("parameter")
#
# Note: To ensure that caching is turned off, set CachedResource.connection.cache_store = :none
#
# FYI: You can use this with *any* active resource interface, not just Highrise.

module Cachable
  def self.included(base)
    ActiveResource::Connection.alias_method_chain :get, :cache
  end
  ActiveResource::Connection.class_eval do
    def cache_store
      @cache_store ||= nil
    end

    # Wrapper for lookup_store, with a couple of special options:
    #   Passing +:none+ will turn off caching
    #   Passing +:rails+ will use the default Rails/AS cache (whatever it happens to be)
    #   Passing +nil+ will use the default cache from AS
    def cache_store=(store_option)
      @cache_store = case store_option
      when :none
        nil
      when :rails
        Rails.cache rescue ActiveSupport::Cache.lookup_store
      else
        ActiveSupport::Cache.lookup_store(store_option)
      end
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
      Digest::SHA1.hexdigest args.to_s
    end

    def fetch(args, &block)
      cache_store.fetch(cache_key(args), &block).dup
    end
  end
end
