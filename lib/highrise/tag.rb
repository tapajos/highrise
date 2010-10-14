module Highrise
  class Tag < Base  
    def ==(object)
      (object.instance_of?(self.class) && object.id == self.id && object.name == self.name)
    end
    
    # You can't find :one because that finds all *objects* with that tag
    def self.find_by_name(arg)
      self.find(:all).detect{|tag| tag.name == arg}
    end
  end
end