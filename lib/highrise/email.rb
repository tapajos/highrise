module Highrise
  class Email < Base
    include Pagination

    def comments
      Comment.find(:all, :from => "/emails/#{id}/comments.xml")
    end
  end
end