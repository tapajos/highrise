module Highrise
  class Note < Base
    include Pagination

    TYPE_MAPPING = {
      'Highrise::Person'=>'Party',
      'Highrise::Company'=>'Party',
      'Highrise::Deal'=>'Deal',
      'Highrise::Kase'=>'Kase',
    }

    def comments
      Comment.find(:all, :from => "/notes/#{id}/comments.xml")
    end
  end
end