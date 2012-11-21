require 'active_resource'

module Highrise
  class Base < ActiveResource::Base
    protected

    class << self
      # If headers are not defined in a given subclass, then obtain
      # headers from the superclass.
      # http://opensoul.org/blog/archives/2010/02/16/active-resource-in-practice/
      def headers
        if defined?(@headers)
          @headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          @headers ||= {}
        end
      end

      def oauth_token=(token)
        headers['Authorization'] = "Bearer #{token}"
      end
    end

    # Fix for ActiveResource 3.1+ errors
    self.format = :xml

    # Dynamic finder for attributes
    def self.method_missing(method, *args)
      if method.to_s =~ /^find_(all_)?by_([_a-zA-Z]\w*)$/
        raise ArgumentError, "Dynamic finder method must take an argument." if args.empty?
        options = args.extract_options!
        resources = respond_to?(:find_all_across_pages) ? send(:find_all_across_pages, options) : send(:find, :all)
        resources.send($1 == 'all_' ? 'select' : 'detect') { |container| container.send($2) == args.first }
      else
        super
      end
    end

  end
end
