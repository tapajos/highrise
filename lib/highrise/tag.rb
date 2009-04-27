module Highrise
  class Tag < Base
    def ==(object)
      (object.instance_of?(self.class) && object.id == self.id && object.name == self.name)
    end
  end
end