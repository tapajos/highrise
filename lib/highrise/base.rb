module Highrise
  class Base < ActiveResource::Base
    protected
    # Dynamic finder for attributes
    def self.method_missing(method, *args)
      case method.to_s
      when /^find_(all_)?by_([_a-zA-Z]\w*)$/
        raise ArgumentError, "Dynamic finder method must take an argument." if args.empty?
        send("find", :all).send($1 == 'all_' ? 'select' : 'detect') { |container| container.send($2) == args.first }
      else
        super
      end
    end

  end
end