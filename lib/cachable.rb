# Caching is a way to speed up slow ActiveResource queries by keeping the result of
# a request around to be reused by subsequent requests. 
# 
# Caching is turned OFF by default.
#
# == Usage
# 
#   require 'cachable'
# 
#   module CachedResource < ActiveResource::Base
#     include ::Cachable
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
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :memory_store
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :file_store, "/path/to/cache/directory"
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :drb_store, "druby://localhost:9192"
#   CachedResource.connection.cache_store = ActiveSupport::Cache.lookup_store :mem_cache_store, "localhost"
#   CachedResource.connection.cache_store = MyOwnStore.new("parameter")
#
# === If you are using a store that has write options, you can set them
#   CachedResource.connection.cache_options = { :expires_in => 60.seconds }
#
# Note: To ensure that caching is turned off, set CachedResource.connection.cache_store = nil
#
# FYI: You can use this with *any* active resource class, not just Highrise.

module Cachable
  def self.included(base)
    ActiveResource::Connection.class_eval do
      def cache_store
        @cache_store ||= nil
      end

      def cache_store=(store)
        @cache_store = store
      end
      
      def cache_options
        @cache_options ||= {}
      end
      alias :store_options :cache_options
      
      def cache_options=(options)
        @cache_options = options
      end
      alias :store_options= :cache_options=
      
      def is_caching?
        !@cache_store.nil?
      end
      
      def get_with_cache(path, headers = {})
        return get_without_cache(path, headers) unless is_caching?
        cache_store.fetch(cache_key(path), cache_options) {get_without_cache(path, headers)}
      end
      alias_method_chain :get, :cache

      def put_with_cache(path, body = '', headers = {})
        cache_store.delete(cache_key(path))
        put_without_cache(path, body, headers)
      end
      alias_method_chain :put, :cache
      
      def delete_with_cache(path, headers = {})
        cache_store.delete(cache_key(path))
        delete_without_cache(path, headers)
      end
      alias_method_chain :delete, :cache
      
      def cache_key(*args)
        args.join(':')
      end
    end
  end  
end
