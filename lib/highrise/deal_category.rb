module Highrise
  class DealCategory < Base
    def self.find_by_name(name)
      find(:all).detect {|deal_category| deal_category.name == name}
    end
  end
end