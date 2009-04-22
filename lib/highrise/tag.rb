module Highrise
  class Tag
   attr_accessor :id, :name
   
   def initialize(id=nil, name=nil)
    self.id = id
    self.name = name
   end
   
   def ==(object)
    (object.instance_of?(self.class) && object.id == self.id && object.name == self.name)
   end
   
  end
end