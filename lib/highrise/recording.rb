module Highrise
  class Recording < Base
    include Pagination

    def self.find_all_across_pages_since(time)
      find_all_across_pages(:params => { :since => time.utc.strftime("%Y%m%d%H%M%S") })
    end
  end
end