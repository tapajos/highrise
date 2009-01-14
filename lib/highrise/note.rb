module Highrise
  class Note < Base
    include Pagination

    def comments
      Comment.find(:all, :from => "/notes/#{id}/comments.xml")
    end
  end
end