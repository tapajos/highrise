require 'digest/sha1'

module Highrise
  class Base < ActiveResource::Base
    class << self
      def cache_store
        if defined?(@cache_store)
          @cache_store
        elsif superclass != Object && superclass.cache_store
          superclass.cache_store
        end
      end

      def cache_store=(store_option)
        @cache_store = store_option.nil? ? nil : ActiveSupport::Cache.lookup_store(store_option)
      end

      def is_caching?
        !cache_store.nil?
      end
    
      def find(*args)
        find_with_cache(*args)
      end
  
    private
    
      def find_with_cache(*args)
        return find_without_cache(*args) unless is_caching?
        fetch(args) { find_without_cache(*args) }
      end
    
      def find_without_cache(*args)
        superclass.find(*args)
      end
    
      def cache_key(*args)
        Digest::SHA1.hexdigest args.to_s
      end

      def fetch(args, &block)
        cache_store.fetch(cache_key(args), &block)
      end
    end
  end
end