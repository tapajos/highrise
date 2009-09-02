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
#       include ::Cachable
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
# === Configuration examples ('off' is the default):
#   CachedResource.cache_store = ActiveSupport::Cache.lookup_store :memory_store
#   CachedResource.cache_store = ActiveSupport::Cache.lookup_store :file_store, "/path/to/cache/directory"
#   CachedResource.cache_store = ActiveSupport::Cache.lookup_store :drb_store, "druby://localhost:9192"
#   CachedResource.cache_store = ActiveSupport::Cache.lookup_store :mem_cache_store, "localhost"
#   CachedResource.cache_store = MyOwnStore.new("parameter")
#
# === If you are using a store that has write options, you can set them
#   CachedResource.store_options = { :expires_in => 60.seconds }
#
# Note: To ensure that caching is turned off, set CachedResource.connection.cache_store = nil
#
# FYI: You can use this with *any* active resource interface, not just Highrise.

module Cachable
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      class << self
        alias_method_chain :find_every, :cache
        alias_method_chain :find_single, :cache
      end
    end
  end

  module ClassMethods
    attr_writer :cache_store, :store_options
    
    def cache_store
      @cache_store ||= nil
    end
    
    def store_options
      @store_options ||= {}
    end
    
    def is_caching?
      !@cache_store.nil?
    end

  private

    # A little hacky -- we need to intercept the finds, but not get too deep inside the connection
    def find_every_with_cache(options)
      return find_every_without_cache(options) unless is_caching?
      prefix_options, query_options = split_options(options[:params])
      path = collection_path(prefix_options, query_options)
      fetch(path) { find_every_without_cache(options)}
    end

    def find_single_with_cache(scope, options)
      return find_single_without_cache(scope, options) unless is_caching?
      prefix_options, query_options = split_options(options[:params])
      path = element_path(scope, prefix_options, query_options)
      fetch(path) { find_single_without_cache(scope, options)}
    end

    def cache_key(*args)
      args.to_s
    end

    def fetch(args, &block)
      cache_store.fetch(cache_key(args), store_options, &block).dup
    end
  end
end
