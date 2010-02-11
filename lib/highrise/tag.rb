module Highrise
  class Tag < Base    
    @cache = self.cache_store || ActiveSupport::Cache::MemoryStore.new
    
    def ==(object)
      (object.instance_of?(self.class) && object.id == self.id && object.name == self.name)
    end
    
    class << self
      # This find(:all) is very expensive, so cache all tags, once.
      def find_by_name(arg)
        @cache.fetch(to_key([self.to_s, arg])) {
          tags = self.find(:all).each{|tag| @cache.write(to_key([self.to_s, tag.name]), tag)}
          tags.find{|tag| tag.name == arg}
        }
      end
      
      private
      
      def to_key(*args)
        args.join('/')
      end
    end
  end
end