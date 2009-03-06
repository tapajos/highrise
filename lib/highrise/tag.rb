module Highrise
  class Tag < Base
    include Pagination

    def user
      Tag.find(:all, :from => "/tags/#{id}.xml")
    end
  end
end