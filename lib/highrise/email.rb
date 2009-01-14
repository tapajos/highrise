module Highrise
  class Email < Base
    include Pagination

    def comments
      Comment.find(:all, :from => "/emails/#{email_id}/comments.xml")
    end
  end
end