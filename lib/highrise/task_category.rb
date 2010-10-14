module Highrise
  class TaskCategory < Base
    def self.find_by_name(name)
      find(:all).detect {|task_category| task_category.name == name}
    end
  end
end