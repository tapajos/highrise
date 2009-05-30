module Highrise
  class Tag < Base
    @@tags = {}
    def ==(object)
      (object.instance_of?(self.class) && object.id == self.id && object.name == self.name)
    end
    
    def self.find_by_name(arg)
      if @@tags == {}
        self.find(:all).each do |tag|
          @@tags[tag.id] = tag
          @@tags[tag.name] = tag
        end
      end
      @@tags[arg]
    end
  end
end